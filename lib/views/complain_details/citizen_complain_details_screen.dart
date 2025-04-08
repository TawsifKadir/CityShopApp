import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/complain/complain_history_list.dart';
import 'package:grs/components/ui_components/complain_details_view.dart';
import 'package:grs/components/ui_widgets/citizen_action_popup_menu.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/complain_details/citizen_complain_details_view_model.dart';

class CitizenComplainDetailsScreen extends StatefulWidget {
  final Complain complain;
  const CitizenComplainDetailsScreen({required this.complain});

  @override
  State<CitizenComplainDetailsScreen> createState() => _CitizenComplainDetailsScreenState();
}

class _CitizenComplainDetailsScreenState extends State<CitizenComplainDetailsScreen> with SingleTickerProviderStateMixin {
  var viewModel = CitizenComplainDetailsViewModel();
  var modelData = CitizenComplainDetailsViewModel();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(widget.complain));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<CitizenComplainDetailsViewModel>(context, listen: false);
    modelData = Provider.of<CitizenComplainDetailsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var label = Text('Complain Details'.translate);
    var actions = [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)];
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      appBar: AppBar(centerTitle: false, leading: const BackMenu(), automaticallyImplyLeading: false, title: label, actions: actions),
      floatingActionButton: modelData.loader.initial ? null : _floatingButtons(context),
      body: Stack(children: [Container(width: width, height: height, child: responsive), if (modelData.loader.common) ScreenLoader()]),
    );
  }

  Widget _floatingButtons(BuildContext context) {
    var complain = modelData.complainDetails?.complain;
    var status = complain?.currentStatus;
    if (status == null) return const SizedBox.shrink();
    var showActions = complain?.showCitizenAction ?? false;
    if (!showActions) return const SizedBox.shrink();
    var loader = modelData.loader.initial || modelData.loader.common;
    return FloatingActionButton.extended(
      elevation: loader ? 0 : 1,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: loader ? primary.withOpacity(0.6) : primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      label: CitizenActionPopUpMenu(onlyIcon: false, complain: modelData.complainDetails!.complain!),
      onPressed: null,
    );
  }

  Widget _mobileView(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: white,
          elevation: 1,
          child: TabBar(
            indicatorColor: black,
            unselectedLabelColor: grey80,
            controller: tabController,
            indicatorPadding: const EdgeInsets.only(left: 4, right: 4),
            tabs: [Tab(text: 'Details'.translate), Tab(text: 'History'.translate)],
          ),
        ),
        if (!modelData.loader.initial)
          Expanded(
            child: TabBarView(
              controller: tabController,
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              children: [_detailsView, _historyView],
            ),
          ),
      ],
    );
  }

  Widget get _detailsView => ComplainDetailsView(complainDetails: modelData.complainDetails);

  Widget get _historyView {
    if (modelData.histories.length < 1) return const Center(child: NoDataFound(pref: NoDataPref.history));
    return ComplainHistoryList(histories: modelData.histories);
  }
}
