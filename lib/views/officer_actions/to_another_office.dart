import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/comp_list/service_list.dart';
import 'package:grs/components/ui_components/doptor_view.dart';
import 'package:grs/components/ui_components/proof_files_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:grs/view_models/officer_actions/another_office_view_model.dart';

class ToAnotherOfficeScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const ToAnotherOfficeScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<ToAnotherOfficeScreen> createState() => _ToAnotherOfficeScreenState();
}

class _ToAnotherOfficeScreenState extends State<ToAnotherOfficeScreen> {
  var viewModel = AnotherOfficeViewModel();
  var modelData = AnotherOfficeViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<AnotherOfficeViewModel>(context, listen: false);
    modelData = Provider.of<AnotherOfficeViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<DoptorViewModel>(context, listen: false).disposeViewModel();
    Provider.of<ProofFilesViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var proofModel = Provider.of<ProofFilesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Send to Another Office'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || doptorModel.loader || proofModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your note here'.translate;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Your note'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.note, hintText: hint),
          const SizedBox(height: 20),
          ProofFilesView(),
          const SizedBox(height: 20),
          const DoptorView(needService: true, isCitizenCharter: false, isRequired: true),
          Text('select_service_commitment'.translate, style: sl<TextStyles>().text14_400(amber)),
          const SizedBox(height: 16),
          Text('Other Service Names'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(controller: viewModel.otherService, hintText: 'Name of other services'.translate),
          const SizedBox(height: 20),
          _serviceListSection(context),
        ],
      ),
    );
  }

  Widget _serviceListSection(BuildContext context) {
    var doptorModelData = Provider.of<DoptorViewModel>(context);
    if (!doptorModelData.serviceList.haveList) return const SizedBox.shrink();
    var doptorViewmodel = Provider.of<DoptorViewModel>(context, listen: false);
    return ServiceList(
      serviceList: doptorModelData.serviceList,
      selectedService: doptorModelData.selectedService,
      onTap: (index) => doptorViewmodel.selectService(doptorModelData.serviceList[index]),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    var doptorModel = Provider.of<DoptorViewModel>(context);
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Send',
      outlineOnTap: backToPrevious,
      loader: modelData.loader || doptorModel.loader,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
