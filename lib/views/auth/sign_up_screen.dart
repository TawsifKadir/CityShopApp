import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/button_loader.dart';
import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/dropdowns/country_dropdown.dart';
import 'package:grs/components/dropdowns/gender_dropdown.dart';
import 'package:grs/components/dropdowns/nationality_dropdown.dart';
import 'package:grs/components/dropdowns/nid_type_dropdown.dart';
import 'package:grs/components/dropdowns/occupation_dropdown.dart';
import 'package:grs/components/dropdowns/qualification_dropdown.dart';
import 'package:grs/components/ui_widgets/date_box.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/service/validators.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/auth/sign_up_view_model.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  var viewModel = SignUpViewModel();
  var modelData = SignUpViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<SignUpViewModel>(context, listen: false);
    modelData = Provider.of<SignUpViewModel>(context);
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
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      // appBar: AppBar(leading: const BackMenu()),
      resizeToAvoidBottomInset: true,
      body: Stack(children: [Container(width: width, height: height, child: responsive), if (modelData.loader) ScreenLoader()]),
    );
  }

  Widget _mobileView(BuildContext context) {
    var dob = modelData.dateOfBirth;
    var birthDate = dob == null ? 'Select your birth date'.translate : sl<Formatters>().formatDate(DATE_FORMAT_4, '$dob');
    var alreadyExistLabel = Text('User already exist with this mobile number'.translate, style: sl<TextStyles>().text13_400(red));
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: SizeConfig.statusBar + 32),
          Center(child: Image.asset(Assets.grs_web_logo, width: 60.widthRatio)),
          const SizedBox(height: 40),
          _requiredOptionLabel(label: 'Mobile number'.translate),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.mobile,
            keyboardType: TextInputType.phone,
            onChanged: (data) => viewModel.checkUser(),
            hintText: 'Mobile number (in Bangla/English)'.translate,
            suffixIcon: !modelData.userLoader ? const SizedBox.shrink() : Container(height: 30, width: 30, child: ButtonLoader()),
          ),
          if (modelData.isAppUser) const SizedBox(height: 4),
          if (modelData.isAppUser) alreadyExistLabel,
          const SizedBox(height: 16),
          _requiredOptionLabel(label: 'Full name'.translate),
          const SizedBox(height: 4),
          ModifiedTextField(controller: viewModel.name, hintText: 'Write your full name here'.translate),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: Text('Date of birth'.translate, style: sl<TextStyles>().text14_400(black))),
            const SizedBox(width: 16),
            Expanded(child: Text('Gender'.translate, style: sl<TextStyles>().text14_400(black)))
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(child: DateBox(onTap: () => viewModel.getBirthDate(context), date: birthDate, haveDate: true)),
            const SizedBox(width: 16),
            Expanded(child: GenderDropdown(gender: modelData.gender, onChanged: (data) => setState(() => modelData.gender = data))),
          ]),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: Text('Occupation'.translate, style: sl<TextStyles>().text14_400(black))),
            const SizedBox(width: 16),
            Expanded(child: Text('Qualification'.translate, style: sl<TextStyles>().text14_400(black)))
          ]),
          const SizedBox(height: 4),
          Row(children: [Expanded(child: _occupation(context)), const SizedBox(width: 16), Expanded(child: _qualification(context))]),
          const SizedBox(height: 16),
          _requiredOptionLabel(label: 'Your national identity'.translate),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(flex: 3, child: _nationalIdTypeDropdown(context)),
            const SizedBox(width: 16),
            Expanded(flex: 5, child: _nationalIdentity(context)),
          ]),
          const SizedBox(height: 16),
          Text('Email address'.translate, style: sl<TextStyles>().text14_400(black)),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.email,
            keyboardType: TextInputType.emailAddress,
            hintText: 'john@gmail.com'.translate,
          ),
          const SizedBox(height: 16),
          Row(children: [
            Expanded(child: Text('Country'.translate, style: sl<TextStyles>().text14_400(black))),
            const SizedBox(width: 16),
            Expanded(child: Text('Nationality'.translate, style: sl<TextStyles>().text14_400(black)))
          ]),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(child: _countryDropdown(context)),
            const SizedBox(width: 16),
            Expanded(child: _nationalityDropdown(context)),
          ]),
          const SizedBox(height: 16),
          Text('Street address'.translate, style: sl<TextStyles>().text14_400(black)),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.street,
            hintText: 'write your street address here'.translate,
            validator: (val) => sl<Validators>().yourAddress(address: val!),
          ),
          const SizedBox(height: 16),
          _requiredOptionLabel(label: 'House address'.translate),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.house,
            hintText: 'write your house address here'.translate,
            validator: (val) => sl<Validators>().yourAddress(address: val!),
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 16),
          ElevatedButton(
            clipBehavior: Clip.antiAlias,
            onPressed: modelData.loader ? null : _signUpOnTap,
            child: Text('Registration'.translate, style: sl<TextStyles>().text18_500(white)),
          ),
          const SizedBox(height: 30),
          Center(child: _signInSection(context)),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _requiredOptionLabel({required String label}) {
    var title = Text(label, style: sl<TextStyles>().text14_400(black));
    var star = Text('*', style: sl<TextStyles>().text14_600(red));
    return Row(children: [title, const Text(' '), star]);
  }

  Widget _occupation(BuildContext context) {
    return OccupationDropdown(
      occupation: modelData.occupation,
      occupationList: modelData.occupations,
      onChanged: (data) => setState(() => modelData.occupation = data),
    );
  }

  Widget _qualification(BuildContext context) {
    return QualificationDropdown(
      qualification: modelData.qualification,
      qualificationList: modelData.qualifications,
      onChanged: (data) => setState(() => modelData.qualification = data),
    );
  }

  Widget _nationalIdTypeDropdown(BuildContext context) {
    return NidTypeDropdown(
      identityType: modelData.identityType,
      onChanged: (data) => setState(() => modelData.identityType = data),
    );
  }

  Widget _nationalIdentity(BuildContext context) {
    return ModifiedTextField(
      controller: viewModel.nationalId,
      keyboardType: TextInputType.phone,
      hintText: 'Write your national id number'.translate,
    );
  }

  Widget _countryDropdown(BuildContext context) {
    return CountryDropdown(
      country: modelData.country,
      countryList: modelData.nationalities,
      onChanged: (data) => viewModel.selectCountry(data!),
    );
  }

  Widget _nationalityDropdown(BuildContext context) {
    return NationalityDropdown(
      nationality: modelData.nationality,
      nationalityList: modelData.nationalities,
      onChanged: (data) => setState(() => modelData.nationality = data),
    );
  }

  Widget _signInSection(BuildContext context) {
    var spanStyle = sl<TextStyles>().text16_400(primary);
    var recognizer = TapGestureRecognizer()..onTap = sl<Routes>().signInScreen().pushAndRemoveUntil;
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: sl<TextStyles>().text16_400(grey),
        text: 'Already have an account?'.translate + ' ',
        children: <TextSpan>[TextSpan(text: 'Sign in'.translate, style: spanStyle, recognizer: recognizer)],
      ),
    );
  }

  void _signUpOnTap() {
    minimizeKeyboard();
    var mobileLength = viewModel.mobile.text.length;
    if (mobileLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your mobile number'.translate, isTop: true);
    if (mobileLength != 11) return sl<Toasts>().warningToast(message: 'Mobile number must be 11 digit'.translate, isTop: true);
    if (viewModel.name.text.length < 1) return sl<Toasts>().warningToast(message: 'Please enter your full name'.translate, isTop: true);
    var message1 = 'Please select your date of birth'.translate;
    if (modelData.dateOfBirth == null) return sl<Toasts>().warningToast(message: message1, isTop: true);
    // if (modelData.gender == null) return sl<Toasts>().warningToast(message: 'Please select your gender'.translate, isTop: true);
    // if (modelData.occupation == null) return sl<Toasts>().warningToast(message: 'Please select your occupation'.translate, isTop: true);
    // var message2 = 'Please select your qualification'.translate;
    // if (modelData.qualification == null) return sl<Toasts>().warningToast(message: message2, isTop: true);
    var message3 = 'Please select your identity type'.translate;
    if (modelData.identityType == null) return sl<Toasts>().warningToast(message: message3, isTop: true);
    var message4 = 'Please write your national identity number'.translate;
    if (modelData.nationalId.text.isEmpty) return sl<Toasts>().warningToast(message: message4, isTop: true);
    // var emailLength = viewModel.email.text.length;
    // if (emailLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your email address'.translate, isTop: true);
    // var isMatch = sl<RegExps>().email.hasMatch(viewModel.email.text);
    // if (!isMatch) return sl<Toasts>().warningToast(message: 'Please enter a valid email address'.translate, isTop: true);
    if (modelData.country == null) return sl<Toasts>().warningToast(message: 'Please select your country'.translate, isTop: true);
    if (modelData.nationality == null) return sl<Toasts>().warningToast(message: 'Please select your nationality'.translate, isTop: true);
    // var streetLength = viewModel.street.text.length;
    // if (streetLength < 1) return sl<Toasts>().warningToast(message: 'Please write your address here'.translate, isTop: true);
    var houseLength = viewModel.house.text.length;
    if (houseLength < 1) return sl<Toasts>().warningToast(message: 'Please write your address here'.translate, isTop: true);
    viewModel.signUpOnTap();
  }
}
