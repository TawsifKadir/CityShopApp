import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/bottom_sheets/branch_officers_sheet.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/ui_components/proof_files_view.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/components/ui_widgets/add_button.dart';
import 'package:grs/components/ui_widgets/selected_officer_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/date_picker_view.dart';
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
import 'package:grs/view_models/component/branch_officers_view_model.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:grs/view_models/officer_actions/provide_service_view_model.dart';

class ProvideServiceScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const ProvideServiceScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<ProvideServiceScreen> createState() => _ProvideServiceScreenState();
}

class _ProvideServiceScreenState extends State<ProvideServiceScreen> {
  var viewModel = ProvideServiceViewModel();
  var modelData = ProvideServiceViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ProvideServiceViewModel>(context, listen: false);
    modelData = Provider.of<ProvideServiceViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<BranchOfficersViewModel>(context, listen: false).disposeViewModel();
    Provider.of<ProofFilesViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var branchModel = Provider.of<BranchOfficersViewModel>(context);
    var proofModel = Provider.of<ProofFilesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Service Delivery Instructions'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || branchModel.loader || proofModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your comment here'.translate;
    var branchModel = Provider.of<BranchOfficersViewModel>(context);
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Select the specific date of service'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          DatePickerView(
            showPicker: true,
            lastDate: DateTime(2050),
            firstDate: DateTime(2000),
            dateFormat: DATE_FORMAT_4,
            initialDate: modelData.serviceDate,
            hint: 'Select the date of service'.translate,
            onChanged: (date) => setState(() => modelData.serviceDate = date),
          ),
          const SizedBox(height: 20),
          Text('My Comment'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.comment, hintText: hint),
          const SizedBox(height: 20),
          // Text('Select Language'.translate, style: sl<TextStyles>().text16_400(black)),
          // const SizedBox(height: 6),
          // LanguageDropdown(language: modelData.selectedLanguage, onChanged: (data) => setState(() => modelData.selectedLanguage = data)),
          // const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Select the person to give guidance'.translate, style: sl<TextStyles>().text16_400(black)),
              AddButton(onTap: () => branchOfficersBottomSheet(isMultiSelect: false)),
            ],
          ),
          const SizedBox(height: 6),
          SelectedOfficerView(selectedOfficer: branchModel.selectedOfficer),
          const SizedBox(height: 20),
          ProofFilesView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    var branchModel = Provider.of<BranchOfficersViewModel>(context);
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Send',
      outlineOnTap: backToPrevious,
      loader: modelData.loader || branchModel.loader,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
