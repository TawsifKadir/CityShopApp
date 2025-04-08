import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/company/charter_service_list.dart';
import 'package:grs/components/ui_components/doptor_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/expansion.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/company/citizen_charter_view_model.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';

class CitizenCharterScreen extends StatefulWidget {
  @override
  State<CitizenCharterScreen> createState() => _CitizenCharterScreenState();
}

class _CitizenCharterScreenState extends State<CitizenCharterScreen> {
  var viewModel = CitizenCharterViewModel();
  var modelData = CitizenCharterViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<CitizenCharterViewModel>(context, listen: false);
    modelData = Provider.of<CitizenCharterViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<DoptorViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var responsive = Responsive(mobile: _mobileView(context));
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var loader = modelData.loader || doptorModel.loader;
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Citizen Charter'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      body: Stack(children: [Container(width: width, height: height, child: responsive), if (loader) ScreenLoader()]),
    );
  }

  Widget _mobileView(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      children: [
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Expansion(
            tilePadding: EdgeInsets.zero,
            maintainState: modelData.isExpanded,
            initiallyExpanded: modelData.isExpanded,
            title: Text('Choose an Office to View Citizens Charter'.translate, style: sl<TextStyles>().text15_600(black)),
            childrenPadding: EdgeInsets.zero,
            expandedAlignment: Alignment.centerLeft,
            onExpansionChanged: (data) => setState(() => modelData.isExpanded = data),
            children: const [SizedBox(height: 12), DoptorView(needService: false, isCitizenCharter: true, isRequired: true)],
          ),
        ),
        if (!modelData.isExpanded) const SizedBox(height: 20),
        _vision_mission_section(context),
        _providedServices(context),
      ],
    );
  }

  Widget _vision_mission_section(BuildContext context) {
    var vision = modelData.charterApi?.vision;
    if (vision == null) return const SizedBox.shrink();
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vision.vision.isNotEmpty) _labelInfo(label: 'Vision'.translate),
        if (vision.vision.isNotEmpty) const SizedBox(height: 4),
        if (vision.vision.isNotEmpty)
          Padding(padding: padding, child: Text(vision.vision.trim(), style: sl<TextStyles>().text15_400(black))),
        if (vision.vision.isNotEmpty) const SizedBox(height: 20),
        if (vision.mission.isNotEmpty) _labelInfo(label: 'Mission'.translate),
        if (vision.mission.isNotEmpty) const SizedBox(height: 4),
        if (vision.mission.isNotEmpty)
          Padding(padding: padding, child: Text(vision.mission.trim(), style: sl<TextStyles>().text15_400(black))),
        if (vision.mission.isNotEmpty) const SizedBox(height: 20),
      ],
    );
  }

  Widget _providedServices(BuildContext context) {
    var services = modelData.charterApi?.charterDetails?.charterServices;
    if (!services.haveList) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _labelInfo(label: 'Services we pledge'.translate),
        const SizedBox(height: 4),
        CharterServiceList(services: services!),
      ],
    );
  }

  Widget _labelInfo({required String label}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var labelText = Text(label, style: sl<TextStyles>().text15_400(black));
    return Container(color: grey20, width: SizeConfig.width, padding: padding, child: labelText);
  }
}
