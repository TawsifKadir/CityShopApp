import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/auth/forgot_pin_view_model.dart';

class ForgotPinScreen extends StatefulWidget {
  @override
  State<ForgotPinScreen> createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> {
  var viewModel = ForgotPinViewModel();
  var modelData = ForgotPinViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ForgotPinViewModel>(context, listen: false);
    modelData = Provider.of<ForgotPinViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var loader = modelData.loader;
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var padding = const EdgeInsets.all(24);
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      appBar: AppBar(elevation: 0, centerTitle: true, leading: const BackMenu()),
      body: Stack(children: [Container(width: width, height: height, padding: padding, child: responsive), if (loader) ScreenLoader()]),
    );
  }

  Widget _mobileView(BuildContext context) {
  var description = 'No Worries! We will send a pin code to your mobile number.'.translate;
  var mobileIcon = SvgImage(image: Assets.mobile_outline, width: 24, color: grey);

  return SingleChildScrollView(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(Assets.grs_web_logo, width: 60.widthRatio)),
          const SizedBox(height: 50),
          Text('Please type your mobile number'.translate, style: sl<TextStyles>().text20_600(black)),
          const SizedBox(height: 8),
          Text(description, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 32),
          ModifiedTextField(
            controller: viewModel.mobile,
            keyboardType: TextInputType.phone,
            hintText: 'Mobile number (in Bangla/English)'.translate,
            prefixIcon: Container(width: 30, alignment: Alignment.center, child: mobileIcon),
          ),
          const SizedBox(height: 40),
          ElevatedButton(
            onPressed: modelData.loader ? null : () => _sendCodeOnTap(context),
            child: Text('Send Code'.translate, style: sl<TextStyles>().text18_500(white)),
            style: ElevatedButton.styleFrom(disabledBackgroundColor: primary.withOpacity(0.3)),
          ),
        ],
      ),
    ),
  );
}

  void _sendCodeOnTap(BuildContext context) {
    minimizeKeyboard();
    var mobileLength = viewModel.mobile.text.length;
    if (mobileLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your mobile number'.translate, isTop: true);
    if (mobileLength != 11) return sl<Toasts>().warningToast(message: 'Mobile number must be 11 digit'.translate, isTop: true);
    viewModel.sendCodeOnTap();
  }
}
