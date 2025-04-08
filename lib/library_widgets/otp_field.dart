import 'package:flutter/material.dart';

import 'package:pin_code_fields/pin_code_fields.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/models/dummy/dimension.dart';
import 'package:grs/utils/text_styles.dart';

class OtpField extends StatelessWidget {
  final TextEditingController otpController;
  final Function(String) onChanged;
  const OtpField({required this.otpController, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return PinCodeTextField(
      length: 4,
      appContext: context,
      cursorColor: primary,
      onChanged: onChanged,
      enableActiveFill: true,
      backgroundColor: transparent,
      controller: otpController,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      mainAxisAlignment: MainAxisAlignment.center,
      animationDuration: const Duration(milliseconds: 300),
      textStyle: sl<TextStyles>().text26_600(black),
      pinTheme: PinTheme(
        activeColor: primary,
        selectedColor: primary,
        inactiveColor: grey40,
        disabledColor: grey40,
        activeFillColor: primary.withOpacity(0.02),
        inactiveFillColor: primary.withOpacity(0.02),
        selectedFillColor: primary.withOpacity(0.02),
        errorBorderColor: red,
        shape: PinCodeFieldShape.box,
        fieldOuterPadding: const EdgeInsets.all(08),
        borderRadius: BorderRadius.circular(6),
        fieldWidth: sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 16.width)),
        fieldHeight: sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 16.width)),
      ),
    );
  }
}
