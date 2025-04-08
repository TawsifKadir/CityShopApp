import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/bottom_sheets/subordinate_officers_sheet.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/dropdowns/service_dropdown.dart';
import 'package:grs/components/ui_components/proof_files_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/components/ui_widgets/add_button.dart';
import 'package:grs/components/ui_widgets/selected_officer_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:grs/view_models/component/subordinate_officers_view_model.dart';
import 'package:grs/view_models/officer_actions/subordinate_office_view_model.dart';

class SubordinateOfficeScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const SubordinateOfficeScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<SubordinateOfficeScreen> createState() => _SubordinateOfficeScreenState();
}

class _SubordinateOfficeScreenState extends State<SubordinateOfficeScreen> {
  var viewModel = SubordinateOfficeViewModel();
  var modelData = SubordinateOfficeViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(complain: widget.complain));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<SubordinateOfficeViewModel>(context, listen: false);
    modelData = Provider.of<SubordinateOfficeViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<ProofFilesViewModel>(context, listen: false).disposeViewModel();
    Provider.of<SubordinateOfficersViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var subordinateModel = Provider.of<SubordinateOfficersViewModel>(context);
    var proofModel = Provider.of<ProofFilesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Send to Subordinate Office'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || subordinateModel.loader || proofModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your note here'.translate;
    var subordinateModel = Provider.of<SubordinateOfficersViewModel>(context);
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select Officer'.translate, style: sl<TextStyles>().text16_400(black)),
              AddButton(onTap: () => subordinateOfficersBottomSheet(isMultiSelect: false)),
            ],
          ),
          Text('select_service_commitment'.translate, style: sl<TextStyles>().text14_400(primary.withOpacity(0.7))),
          const SizedBox(height: 8),
          SelectedOfficerView(selectedOfficer: subordinateModel.selectedOfficer),
          const SizedBox(height: 20),
          Text('Select Service'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ServiceDropdown(
            service: modelData.selectedService,
            serviceList: modelData.serviceList,
            onChanged: (data) => viewModel.selectService(data!),
          ),
          const SizedBox(height: 20),
          Text('Other Service Names'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(controller: viewModel.otherService, hintText: 'Name of other services'.translate),
          const SizedBox(height: 20),
          ProofFilesView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      elevatedLabel: 'Send',
      outlineLabel: 'back',
      loader: modelData.loader,
      outlineOnTap: backToPrevious,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
