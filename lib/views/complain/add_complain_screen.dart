import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/dropdowns/complain_category_dropdown.dart';
import 'package:grs/components/dropdowns/district_dropdown.dart';
import 'package:grs/components/dropdowns/safety_net_dropdown.dart';
import 'package:grs/components/dropdowns/service_dropdown.dart';
import 'package:grs/components/ui_components/doptor_view.dart';
import 'package:grs/components/ui_components/proof_files_view.dart';
import 'package:grs/components/ui_widgets/nav_button_box.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain/add_complain_view_model.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';
import 'package:grs/view_models/component/proof_files_view_model.dart';
import 'package:provider/provider.dart';

class AddComplainScreen extends StatefulWidget {
  @override
  State<AddComplainScreen> createState() => _AddComplainScreenState();
}

class _AddComplainScreenState extends State<AddComplainScreen> {
  var viewModel = AddComplainViewModel();
  var modelData = AddComplainViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<AddComplainViewModel>(context, listen: false);
    modelData = Provider.of<AddComplainViewModel>(context);
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
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var label = Text('Add New Complain'.translate);
    var responsive = Responsive(mobile: _mobileView(context));
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var proofModel = Provider.of<ProofFilesViewModel>(context);
    var loader = modelData.loader || doptorModel.loader || proofModel.loader;
    var actions = [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      bottomNavigationBar: _bottomNavbarButton(context),
      appBar: AppBar(centerTitle: false, leading: const BackMenu(), automaticallyImplyLeading: false, title: label, actions: actions),
      body: Stack(children: [Container(width: width, height: height, child: responsive), if (loader) ScreenLoader()]),
    );
  }

  Widget _mobileView(BuildContext context) {
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var authStatus = sl<AuthService>().authStatus;
    var isSafetyNet = modelData.category.value == '2';
    var descHint = 'Write your complain description (300 char max)'.translate;
    var safetyNet = modelData.safetyNet;
    var safetyNets = modelData.safetyNets;
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          if (!authStatus)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [Text('anonymous_text'.translate, style: sl<TextStyles>().text16_500(red)), const SizedBox(height: 24)],
            ),
          if (!authStatus)
            Row(
              children: [
                Text('Type of Complaint'.translate, style: sl<TextStyles>().text16_600(black)),
                const Text(' '),
                Text('*', style: sl<TextStyles>().text14_600(red)),
              ],
            ),
          if (!authStatus) Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
          if (!authStatus) const SizedBox(height: 16),
          if (!authStatus) ComplainCategoryDropdown(category: modelData.category, onChanged: (data) => viewModel.selectCategory(data!)),
          if (!authStatus) const SizedBox(height: 24),
          if (!authStatus)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('User Information'.translate, style: sl<TextStyles>().text16_600(black)),
                Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
                const SizedBox(height: 16),
                _userInfoForm(context),
                const SizedBox(height: 24),
              ],
            ),
          if (isSafetyNet)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _requiredOptionLabel(label: 'SafetyNet Program'.translate, isMenu: true),
                Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
                const SizedBox(height: 16),
                SafetyNetDropdown(
                  safetyNet: safetyNet,
                  safetyNets: safetyNets,
                  onChanged: (data) => setState(() => modelData.safetyNet = data),
                ),
                const SizedBox(height: 24),
                _requiredOptionLabel(label: 'Select Location'.translate, isMenu: true),
                Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
                const SizedBox(height: 16),
                DistrictDropdown(
                  type: 'division',
                  city: modelData.division,
                  cities: modelData.divisions,
                  onChanged: (data) => viewModel.selectDivision(data!),
                ),
                const SizedBox(height: 16),
                DistrictDropdown(
                  type: 'district',
                  city: modelData.district,
                  cities: modelData.districts,
                  onChanged: (data) => viewModel.selectDistrict(data!),
                ),
                const SizedBox(height: 16),
                DistrictDropdown(
                  type: 'sub_district',
                  city: modelData.subDistrict,
                  cities: modelData.subDistricts,
                  onChanged: (data) => viewModel.selectSubDistrict(data!),
                ),
                const SizedBox(height: 24),
              ],
            ),
          if (isSafetyNet && doptorModel.serviceList.haveList) _serviceSection(context),
          Text('Complain Details'.translate, style: sl<TextStyles>().text16_600(black)),
          Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
          const SizedBox(height: 16),
          if (!isSafetyNet) const DoptorView(needService: false, isCitizenCharter: false, isRequired: true),
          if (!isSafetyNet && doptorModel.serviceList.haveList) _serviceSection(context),
          _requiredOptionLabel(label: 'Subject of complain'.translate, isMenu: false),
          const SizedBox(height: 4),
          ModifiedTextField(controller: viewModel.subject, hintText: 'Write your complain subject here'.translate),
          const SizedBox(height: 20),
          _requiredOptionLabel(label: 'Complain description'.translate, isMenu: false),
          const SizedBox(height: 4),
          ModifiedTextField(minLines: 5, maxLines: 12, controller: viewModel.description, hintText: descHint),
          const SizedBox(height: 20),
          ProofFilesView(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _requiredOptionLabel({required String label, required bool isMenu}) {
    var title_style = isMenu ? sl<TextStyles>().text16_600(black) : sl<TextStyles>().text14_400(black);
    var title = Text(label, style: title_style);
    var star = Text('*', style: sl<TextStyles>().text14_600(red));
    return Row(children: [title, const Text(' '), star]);
  }

  Widget _userInfoForm(BuildContext context) {
    var authStatus = sl<AuthService>().authStatus;
    var mobileHint = 'Mobile number (in Bangla/English)'.translate;
    var emailHint = 'Write your email address here (if any)'.translate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Mobile number'.translate, style: sl<TextStyles>().text14_400(black)),
        const SizedBox(height: 4),
        ModifiedTextField(
          controller: viewModel.mobile,
          keyboardType: TextInputType.phone,
          hintText: mobileHint,
          onChanged: (data) {
            if (!authStatus) viewModel.checkUser();
          },
        ),
        const SizedBox(height: 16),
        Text('Full name'.translate, style: sl<TextStyles>().text14_400(black)),
        const SizedBox(height: 4),
        ModifiedTextField(controller: viewModel.name, keyboardType: TextInputType.name, hintText: 'Write your full name here'.translate),
        const SizedBox(height: 16),
        Text('Email address'.translate, style: sl<TextStyles>().text14_400(black)),
        const SizedBox(height: 4),
        ModifiedTextField(controller: viewModel.email, keyboardType: TextInputType.emailAddress, hintText: emailHint),
      ],
    );
  }

  Widget _serviceSection(BuildContext context) {
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var service = doptorModel.selectedService;
    var serviceList = doptorModel.serviceList;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Choose service'.translate, style: sl<TextStyles>().text16_600(black)),
        Container(width: 20.width, height: 1.2, color: primary.withOpacity(0.5)),
        const SizedBox(height: 16),
        ServiceDropdown(service: service, serviceList: serviceList, onChanged: (data) => doptorModel.selectService(data!)),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _bottomNavbarButton(BuildContext context) {
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var loader = modelData.loader || doptorModel.loader;
    var label = Text('Send Complain'.translate, style: sl<TextStyles>().text18_500(white));
    return NavButtonBox(
      loader: modelData.loader || doptorModel.loader,
      child: ElevatedButton(onPressed: loader ? null : () => _sendComplainOnTap(context), child: label),
    );
  }

  void _sendComplainOnTap(BuildContext context) {
    minimizeKeyboard();
    var isSafetyNet = modelData.category.value == '2';
    if (isSafetyNet) {
      var invalidSafetyNet = modelData.safetyNet == null;
      if (invalidSafetyNet) return sl<Toasts>().warningToast(message: 'Please select safety net programme'.translate, isTop: true);
      if (modelData.division == null) return sl<Toasts>().warningToast(message: 'Please select division'.translate, isTop: true);
      if (modelData.district == null) return sl<Toasts>().warningToast(message: 'Please select district'.translate, isTop: true);
      if (modelData.subDistrict == null) return sl<Toasts>().warningToast(message: 'Please select sub district'.translate, isTop: true);
    } else {
      var doptorViewmodel = Provider.of<DoptorViewModel>(context, listen: false);
      if (!doptorViewmodel.doptorDataValidation()) return;
    }
    var subjectLength = viewModel.subject.text.length;
    if (subjectLength < 1) return sl<Toasts>().warningToast(message: 'Please write your complain subject'.translate, isTop: true);
    var descriptionLength = viewModel.description.text.length;
    if (descriptionLength < 1) return sl<Toasts>().warningToast(message: 'Please write your complain description'.translate, isTop: true);
    viewModel.sendComplainOnTap();
  }
}
