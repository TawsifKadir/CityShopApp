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
import 'package:grs/view_models/complain_details/appeal_complain_details_view_model.dart';

class AppealComplainDetailsScreen extends StatefulWidget {
  final String menu;
  final ComplainListPref pref;
  final Complain complain;

  const AppealComplainDetailsScreen({required this.menu, required this.pref, required this.complain});

  @override
  State<AppealComplainDetailsScreen> createState() => _AppealComplainDetailsScreenState();
}

class _AppealComplainDetailsScreenState extends State<AppealComplainDetailsScreen> with SingleTickerProviderStateMixin {
  var viewModel = AppealComplainDetailsViewModel();
  var modelData = AppealComplainDetailsViewModel();
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(length: 4, vsync: this);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.initViewModel(widget.complain);
      tabController.addListener(() => viewModel.handleTabChange(tabController));
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<AppealComplainDetailsViewModel>(context, listen: false);
    modelData = Provider.of<AppealComplainDetailsViewModel>(context);
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Grievance Details'.translate),
        actions: !showActions ? null : [languageMenu, width],
      ),
      floatingActionButton: widget.menu != 'arrival' || modelData.loader.initial ? null : _floatingButtons(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
          if (modelData.loader.common) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _floatingButtons(BuildContext context) {
    var loader = modelData.loader.initial || modelData.loader.common;
    var complain = modelData.complainDetails?.complain;
    var isGro = modelData.isGro;
    var user = modelData.complainDetails?.complainedUser;
    var isBlackList = user?.isBlacklisted != null && user!.isBlacklisted == 1;
    if (modelData.loader.initial || modelData.complainDetails == null) {
      return Container();
    } else if (user != null && modelData.tabIndex == 3) {
      // return isGro ? BlacklistFloatingButton(loader: loader, complainDetails: modelData.complainDetails!, isBlackList: isBlackList): Container();
      return Container();
    } else {
      return ActionFloatingButton(loader: loader, complain: complain!, typePref: ActionTypePref.appeal);
    }
  }

  Widget _mobileView(BuildContext context) {
    var indicatorPad = const EdgeInsets.only(left: 4, right: 4);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Material(
          color: white,
          elevation: 1,
          child: TabBar(
            isScrollable: true,
            indicatorColor: black,
            controller: tabController,
            unselectedLabelColor: grey80,
            indicatorPadding: indicatorPad,
            labelPadding: const EdgeInsets.symmetric(horizontal: 12),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            tabs: [
              Tab(text: 'Details'.translate),
              Tab(text: 'Appeal History'.translate),
              Tab(text: 'Complain History'.translate),
              Tab(text: 'Complaint'.translate),
            ],
          ),
        ),
        if (!modelData.loader.initial)
          Expanded(
            child: TabBarView(
              controller: tabController,
              clipBehavior: Clip.antiAlias,
              physics: const BouncingScrollPhysics(),
              children: [_detailsView, _appealHistoryView(context), _complainHistoryView(context), _complainantView],
            ),
          ),
      ],
    );
  }

  Widget get _detailsView => ComplainDetailsView(complainDetails: modelData.complainDetails);

  Widget get _complainantView => ComplainComplainantView(modelData.complainDetails, modelData.complainantComplainList);

  Widget _appealHistoryView(BuildContext context) {
    if (modelData.appealHistories.length < 1) return const Center(child: NoDataFound(pref: NoDataPref.history));
    return ComplainHistoryList(histories: modelData.appealHistories);
  }

  Widget _complainHistoryView(BuildContext context) {
    if (modelData.complainHistories.length < 1) return const Center(child: NoDataFound(pref: NoDataPref.history));
    return ComplainHistoryList(histories: modelData.complainHistories);
  }
}
