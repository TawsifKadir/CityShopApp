import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/dropdowns/quality_dropdown.dart';
import 'package:grs/components/dropdowns/service_dropdown.dart';
import 'package:grs/components/dropdowns/suggestion_dropdown.dart';
import 'package:grs/components/ui_components/doptor_view.dart';
import 'package:grs/components/ui_widgets/nav_button_box.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/company/improvement_view_model.dart';
import 'package:grs/view_models/component/doptor_view_model.dart';

class ImprovementScreen extends StatefulWidget {
  @override
  State<ImprovementScreen> createState() => _ImprovementScreenState();
}

class _ImprovementScreenState extends State<ImprovementScreen> {
  var viewModel = ImprovementViewModel();
  var modelData = ImprovementViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ImprovementViewModel>(context, listen: false);
    modelData = Provider.of<ImprovementViewModel>(context);
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
    var label = Text('Improvement Suggestion'.translate);
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var loader = modelData.loader || doptorModel.loader;
    var responsive = Responsive(mobile: _mobileView(context));
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
    var hintPhone = 'Mobile number (in Bangla/English)'.translate;
    var emailPhone = 'Write your email address here (if any)'.translate;
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('Provide suggestion for Improvement of Service'.translate, style: sl<TextStyles>().text16_500(primary)),
          const SizedBox(height: 24),
          Text('Full name'.translate, style: sl<TextStyles>().text14_400(black)),
          const SizedBox(height: 4),
          ModifiedTextField(controller: viewModel.name, keyboardType: TextInputType.name, hintText: 'Write your full name here'.translate),
          const SizedBox(height: 20),
          Text('Mobile number'.translate, style: sl<TextStyles>().text14_400(black)),
          const SizedBox(height: 4),
          ModifiedTextField(controller: viewModel.mobile, keyboardType: TextInputType.phone, hintText: hintPhone),
          const SizedBox(height: 20),
          Text('Email address'.translate, style: sl<TextStyles>().text14_400(black)),
          const SizedBox(height: 4),
          ModifiedTextField(controller: viewModel.email, keyboardType: TextInputType.emailAddress, hintText: emailPhone),
          const SizedBox(height: 20),
          const DoptorView(needService: true, isCitizenCharter: false, isRequired: true),
          if (doptorModel.serviceList.haveList) Text('Choose service'.translate, style: sl<TextStyles>().text14_400(black)),
          if (doptorModel.serviceList.haveList) const SizedBox(height: 4),
          if (doptorModel.serviceList.haveList)
            ServiceDropdown(
              service: doptorModel.selectedService,
              serviceList: doptorModel.serviceList,
              onChanged: (data) => doptorModel.selectService(data!),
            ),
          if (doptorModel.serviceList.haveList) const SizedBox(height: 20),
          _requiredOptionLabel(label: 'Choose subject of suggestion'.translate),
          const SizedBox(height: 4),
          SuggestionDropdown(suggestion: modelData.suggestion, onChanged: (data) => viewModel.selectSuggestion(data!)),
          const SizedBox(height: 20),
          _requiredOptionLabel(label: 'Choose probable effects'.translate),
          const SizedBox(height: 4),
          QualityDropdown(effect: modelData.effect, onChanged: (data) => viewModel.selectQuality(data!)),
          const SizedBox(height: 20),
          _requiredOptionLabel(label: 'Current Situation'.translate),
          const SizedBox(height: 4),
          ModifiedTextField(minLines: 5, maxLines: 10, controller: viewModel.currentSituation, hintText: 'Provide a description'.translate),
          const SizedBox(height: 20),
          _requiredOptionLabel(label: 'Your Suggestion'.translate),
          const SizedBox(height: 4),
          ModifiedTextField(minLines: 5, maxLines: 10, controller: viewModel.yourSuggestion, hintText: 'Provide your suggestion'.translate),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _requiredOptionLabel({required String label}) {
    var title = Text(label, style: sl<TextStyles>().text14_400(black));
    var star = Text('*', style: sl<TextStyles>().text14_600(red));
    return Row(children: [title, const Text(' '), star]);
  }

  Widget _bottomNavbarButton(BuildContext context) {
    var doptorModel = Provider.of<DoptorViewModel>(context);
    var loader = modelData.loader || doptorModel.loader;
    var label = Text('Submit Suggestion'.translate, style: sl<TextStyles>().text18_500(white));
    return NavButtonBox(
      loader: modelData.loader || doptorModel.loader,
      child: ElevatedButton(onPressed: loader ? null : () => _sendSuggestionOnTap(context), child: label),
    );
  }

  void _sendSuggestionOnTap(BuildContext context) {
    minimizeKeyboard();
    // if (viewModel.name.text.length < 1) return sl<Toasts>().warningToast(message: 'Please enter your full name'.translate, isTop: true);
    // var mobileLength = viewModel.mobile.text.length;
    // if (mobileLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your mobile number'.translate, isTop: true);
    // if (mobileLength != 11) return sl<Toasts>().warningToast(message: 'Mobile number must be 11 digit'.translate, isTop: true);
    // var emailLength = viewModel.email.text.length;
    // if (emailLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your email address'.translate, isTop: true);
    // var isMatch = sl<RegExps>().email.hasMatch(viewModel.email.text);
    // if (!isMatch) return sl<Toasts>().warningToast(message: 'Please enter a valid email address'.translate, isTop: true);
    var doptorViewmodel = Provider.of<DoptorViewModel>(context, listen: false);
    if (!doptorViewmodel.doptorDataValidation()) return;
    // var message1 = 'Please select any subject of suggestion'.translate;
    // if (viewModel.suggestion == null) return sl<Toasts>().warningToast(message: message1, isTop: true);
    // var message2 = 'Please select any option for service quality'.translate;
    // if (viewModel.effect == null) return sl<Toasts>().warningToast(message: message2, isTop: true);
    var situationLength = viewModel.currentSituation.text.length;
    if (situationLength < 1) return sl<Toasts>().warningToast(message: 'Please write your current situation'.translate, isTop: true);
    var suggestionLength = viewModel.yourSuggestion.text.length;
    if (suggestionLength < 1) return sl<Toasts>().warningToast(message: 'Please write your suggestion'.translate, isTop: true);
    viewModel.sendSuggestionOnTap();
  }
}
