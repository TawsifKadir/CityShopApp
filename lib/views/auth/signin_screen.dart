import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/service/validators.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/auth/signin_view_model.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  var viewModel = SignInViewModel();
  var modelData = SignInViewModel();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SizeConfig.initMediaQuery(context);
    viewModel = Provider.of<SignInViewModel>(context, listen: false);
    modelData = Provider.of<SignInViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        padding: EdgeInsets.all(screenPadding),
        margin: EdgeInsets.only(top: SizeConfig.statusBar),
        child: Stack(children: [Responsive(mobile: _mobileView(context)), if (modelData.loader) ScreenLoader()]),
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var isCitizen = modelData.selectedModule == 'citizen';
    var forgotPinLabel = Text('Forgot pin?'.translate, style: sl<TextStyles>().text14_500(primary));
    var mobileIcon = SvgImage(image: Assets.mobile_outline, width: 24, color: grey);
    var lockIcon = SvgImage(image: Assets.lock_outline, width: 24, color: grey);
    var visibilityIcon = modelData.obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          const SizedBox(height: 32),
          Center(child: Image.asset(Assets.grs_web_logo, width: 60.widthRatio)),
          const SizedBox(height: 40),
          Text(
            isCitizen ? 'To submit a grievance'.translate : "Officer's Panel".translate,
            textAlign: TextAlign.center,
            style: isCitizen ? sl<TextStyles>().text18_400(black) : sl<TextStyles>().text22_600(black),
          ),
          const SizedBox(height: 32),
          _moduleSection(context),
          const SizedBox(height: 16),
          ModifiedTextField(
            controller: viewModel.mobile,
            keyboardType: TextInputType.text,
            onTapOutside: isCitizen ? null : (event) => _resetUserName(true),
            hintText: isCitizen ? 'Mobile number (in Bangla/English)'.translate : 'Login using User ID or Username'.translate,
            validator: isCitizen ? null : (val) => sl<Validators>().userId(data: val!),
            prefixIcon: Container(width: 30, alignment: Alignment.center, child: mobileIcon),
          ),
          const SizedBox(height: 16),
          ModifiedTextField(
            controller: viewModel.pin,
            obscureText: modelData.obscureText,
            keyboardType: TextInputType.text,
            hintText: 'Pin code (in English)'.translate,
            validator: isCitizen ? null : (val) => sl<Validators>().pinNumber(pin: val!),
            onTap: isCitizen ? null : () => _resetUserName(false),
            prefixIcon: Container(width: 30, alignment: Alignment.center, child: lockIcon),
            suffixIcon: InkWell(
              onTap: () => setState(() => modelData.obscureText = !modelData.obscureText),
              child: Icon(visibilityIcon, size: 24, color: grey),
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_rememberMe(context), if (isCitizen) InkWell(onTap: sl<Routes>().forgotPinScreen().push, child: forgotPinLabel)],
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            clipBehavior: Clip.antiAlias,
            onPressed: modelData.loader ? null : _signInOnTap,
            child: Text('Log in'.translate, style: sl<TextStyles>().text18_500(white)),
          ),
          const SizedBox(height: 30),
          if (isCitizen) Center(child: _signUpOption(context)),
        ],
      ),
    );
  }

  Widget _moduleSection(BuildContext context) {
    var border = Border.all(color: primary, width: 0.6);
    var radius = BorderRadius.circular(06);
    return Container(
      height: 42,
      width: double.infinity,
      decoration: BoxDecoration(color: primary.withOpacity(0.03), borderRadius: radius, border: border),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(child: _moduleBox(context: context, module: citizen_module)),
          Container(height: double.infinity, width: 0.6, color: primary),
          Expanded(child: _moduleBox(context: context, module: officer_module)),
        ],
      ),
    );
  }

  Widget _moduleBox({required BuildContext context, required DataType module}) {
    var selected = modelData.selectedModule == module.value;
    var radius = const Radius.circular(06);
    var topLeft = module.value == 'citizen' ? radius : Radius.zero;
    var bottomLeft = module.value == 'citizen' ? radius : Radius.zero;
    var topRight = module.value == 'officer' ? radius : Radius.zero;
    var bottomRight = module.value == 'officer' ? radius : Radius.zero;
    var borderRadius = BorderRadius.only(topLeft: topLeft, bottomLeft: bottomLeft, topRight: topRight, bottomRight: bottomRight);
    return InkWell(
      onTap: () => viewModel.setModule(module.value),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 10, right: 8),
        decoration: BoxDecoration(color: selected ? primary.withOpacity(0.05) : white, borderRadius: borderRadius),
        child: Row(
          children: [
            Icon(selected ? Icons.radio_button_on : Icons.radio_button_off, color: primary, size: 18),
            const SizedBox(width: 8),
            Expanded(child: Text(module.label, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text15_500(primary))),
          ],
        ),
      ),
    );
  }

  Widget _signUpOption(BuildContext context) {
    var spanStyle = sl<TextStyles>().text16_400(primary);
    var recognizer = TapGestureRecognizer()..onTap = sl<Routes>().signUpScreen().push;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: sl<TextStyles>().text16_400(grey),
        text: 'Don’t have an account?'.translate + ' ',
        children: <TextSpan>[TextSpan(text: 'Sign up'.translate, style: spanStyle, recognizer: recognizer)],
      ),
    );
  }

  void _resetUserName(bool isKeyboard) {
    var phone = viewModel.mobile.text.trim();
    if (phone.length < 1 || phone.length == 12) return;
    if (isKeyboard) FocusScope.of(context).unfocus();
    viewModel.mobile.text = phone[0] + '0' * (12 - (phone.length)) + phone.substring(1);
    if (isKeyboard) minimizeKeyboard();
    setState(() {});
  }

  Widget _rememberMe(BuildContext context) {
    var width = const SizedBox(width: 8);
    const checkboxIcon = Icon(Icons.check_box, color: primary, size: 22);
    const checkboxBlankIcon = Icon(Icons.check_box_outline_blank, color: grey, size: 22);
    var label = Text('Remember me'.translate, style: sl<TextStyles>().text14_500(black));
    return InkWell(
      onTap: () => setState(() => modelData.keepLoggedIn = !modelData.keepLoggedIn),
      child: Row(children: [modelData.keepLoggedIn ? checkboxIcon : checkboxBlankIcon, width, label]),
    );
  }

  void _signInOnTap() {
    minimizeKeyboard();
    if (modelData.selectedModule == 'citizen') {
      var mobileLength = viewModel.mobile.text.length;
      if (mobileLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your mobile number'.translate, isTop: true);
      if (mobileLength != 11) return sl<Toasts>().warningToast(message: 'Mobile number must be 11 digit'.translate, isTop: true);
    } else {
      var invalidUserId = viewModel.mobile.text.length < 1;
      if (invalidUserId) return sl<Toasts>().warningToast(message: 'Please enter your user id'.translate, isTop: true);
    }
    var pinLength = viewModel.pin.text.length;
    if (pinLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your pin number'.translate, isTop: true);
    if (pinLength < 4) return sl<Toasts>().warningToast(message: 'Pin number must be greater than 4 digit'.translate, isTop: true);
    modelData.selectedModule == 'citizen' ? viewModel.citizenSignIn() : viewModel.officerSignIn();
  }

  Future<void> changeLanguage({required String langCode}) async {
    Locale locale = Locale(langCode);
    await navigatorKey.currentState!.context.setLocale(locale);
    setState(() {});
    // await getStorage.write(LANGUAGE_CODE, langCode);
    // languageCode = langCode;
    // notifyListeners();
    // sl<Toasts>().toastMessage(message: 'Your language is'.tr() + ' ' + (langCode == 'bn' ? 'Densk' : 'English'), isTop: false);
  }
}
