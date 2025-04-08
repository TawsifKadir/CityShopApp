import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_buttons/action_floating_button.dart';
import 'package:grs/components/app_buttons/blacklist_floating_button.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/complain/complain_history_list.dart';
import 'package:grs/components/ui_components/complain_complaint_view.dart';
import 'package:grs/components/ui_components/complain_details_view.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';

import '../../di.dart';
import '../../service/storage_service.dart';

class OfficerComplainDetailsScreen extends StatefulWidget {
  final String menu;
  final ComplainListPref pref;
  final Complain complain;
  const OfficerComplainDetailsScreen({required this.menu, required this.pref, required this.complain});

  @override
  State<OfficerComplainDetailsScreen> createState() => _OfficerComplainDetailsScreenState();
}

class _OfficerComplainDetailsScreenState extends State<OfficerComplainDetailsScreen> with SingleTickerProviderStateMixin {
  var viewModel = OfficerComplainDetailsViewModel();
  var modelData = OfficerComplainDetailsViewModel();
  late TabController tabController;

  @override
  void initState() {
    var isRegular = widget.pref == ComplainListPref.complain_regular;
    tabController = TabController(length: isRegular ? 3 : 2, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.initViewModel(widget.complain);
      tabController.addListener(() => viewModel.handleTabChange(tabController));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<OfficerComplainDetailsViewModel>(context, listen: false);
    modelData = Provider.of<OfficerComplainDetailsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 16);
    var languageMenu = Center(child: LanguageMenu());
    var complain = modelData.complainDetails?.complain;
    var showActions = !modelData.loader.initial && complain != null;
    var isRegular = widget.pref == ComplainListPref.complain_regular;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Grievance Details'.translate),
        actions: !showActions ? null : [languageMenu, width],
      ),
      floatingActionButton: widget.menu != 'arrival' || modelData.loader.initial || !isRegular ? null : _floatingButtons(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
          if (modelData.loader.common) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _floatingButtons(BuildContext context) {
    var complain = modelData.complainDetails?.complain;
    var user = modelData.complainDetails?.complainedUser;
    var isGro = modelData.isGro;
    var isBlackList = user?.isBlacklisted != null && user!.isBlacklisted == 1;
    var loader = modelData.loader.initial || modelData.loader.common;
    if (modelData.loader.initial || modelData.complainDetails == null) {
      return Container();
    } else if (user != null && modelData.tabIndex == 2) {
      //return isGro ? BlacklistFloatingButton(loader: loader, complainDetails: modelData.complainDetails!, isBlackList: isBlackList): Container();
      return Container();
    } else {
      return ActionFloatingButton(loader: loader, complain: complain!, typePref: ActionTypePref.complain);
    }
  }

  Widget _mobileView(BuildContext context) {
    var isRegular = widget.pref == ComplainListPref.complain_regular;
    var indicatorPad = const EdgeInsets.only(left: 4, right: 4);
    var otherTabs = [Tab(text: 'Details'.translate), Tab(text: 'History'.translate)];
    var regularTabs = [Tab(text: 'Details'.translate), Tab(text: 'History'.translate), Tab(text: 'Complaint'.translate)];
    var otherViews = [_detailsView, _historyView(context)];
    var regularViews = [_detailsView, _historyView(context), _complainantView];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: white,
          elevation: 1,
          child: TabBar(
            indicatorColor: black,
            controller: tabController,
            unselectedLabelColor: grey80,
            indicatorPadding: indicatorPad,
            tabs: isRegular ? regularTabs : otherTabs,
          ),
        ),
        if (!modelData.loader.initial)
          Expanded(
            child: TabBarView(
              controller: tabController,
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              children: isRegular ? regularViews : otherViews,
            ),
          ),
      ],
    );
  }

  Widget _historyView(BuildContext context) {
    if (modelData.histories.length < 1) return const Center(child: NoDataFound(pref: NoDataPref.history));
    return ComplainHistoryList(histories: modelData.histories);
  }

  Widget get _detailsView => ComplainDetailsView(complainDetails: modelData.complainDetails);

  Widget get _complainantView => ComplainComplainantView(modelData.complainDetails, modelData.complainantComplainList);
}

/*IconButton(
onPressed: () {
Provider.of<ComplainsViewModel>(context, listen: false).getAllComplains();
backToPrevious();
},
icon: Icon(Icons.abc_outlined))*/
