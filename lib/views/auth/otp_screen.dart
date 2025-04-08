import 'package:flutter/material.dart';

import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/otp_field.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class OTPScreen extends StatefulWidget {
  final String mobile;
  const OTPScreen({required this.mobile});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  var otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var padding = const EdgeInsets.all(24);
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      appBar: AppBar(elevation: 0, centerTitle: true, leading: const BackMenu()),
      body: Container(width: width, height: height, padding: padding, child: responsive),
    );
  }

  Widget _mobileView(BuildContext context) {
    // var otpTyped = otpController.text.length == 4;
    var description = 'Please type in the verification code sent to your email account'.translate;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Image.asset(Assets.grs_web_logo, width: 60.widthRatio)),
        const SizedBox(height: 50),
        Text('Verification Code'.translate, style: sl<TextStyles>().text20_600(black)),
        const SizedBox(height: 8),
        Text(description, style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 8),
        Text(widget.mobile, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_500(black)),
        const SizedBox(height: 32),
        OtpField(
          otpController: otpController,
          onChanged: (code) => WidgetsBinding.instance.addPostFrameCallback((timeStamp) => setState(() {})),
        ),
        const SizedBox(height: 24),
        ElevatedButton(
          onPressed: () => _sendCodeOnTap(context),
          child: Text('Send Code'.translate, style: sl<TextStyles>().text18_500(white)),
        ),
      ],
    );
  }

  void _sendCodeOnTap(BuildContext context) {
    if (otpController.text.length != 4) return sl<Toasts>().errorToast(message: 'Please enter your otp'.translate, isTop: true);
    sl<Routes>().signInScreen().pushAndRemoveUntil();
  }
}
