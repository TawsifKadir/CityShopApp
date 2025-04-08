import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/fonts.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/helpers/dimension_helper.dart';
import 'package:grs/models/dummy/dimension.dart';
import 'package:grs/utils/text_styles.dart';

class ModifiedTextField extends StatelessWidget {
  final int? minLines;
  final int? maxLines;
  final int? maxLength;
  final bool? readOnly;
  final String? hintText;
  final FocusNode? focusNode;
  final bool? showCursor;
  final bool? autoFocus;
  final String? counterText;
  /*final Color? fillColor;*/
  final bool? obscureText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(PointerDownEvent)? onTapOutside;
  final Function()? onTap;
  final bool? isFocusBorderTransparent;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final EdgeInsetsGeometry? contentPadding;
  final TextCapitalization? textCapitalization;

  const ModifiedTextField({
    this.hintText,
    this.minLines,
    this.maxLength,
    this.maxLines,
    this.readOnly,
    this.validator,
    /*this.fillColor,*/
    this.onChanged,
    this.autoFocus,
    this.prefixIcon,
    this.focusNode,
    this.showCursor,
    this.counterText,
    this.suffixIcon,
    this.obscureText,
    this.keyboardType,
    this.controller,
    this.onEditingComplete,
    this.contentPadding,
    this.textCapitalization,
    this.isFocusBorderTransparent,
    this.onTapOutside,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // var borderTransparent = const BorderSide(color: transparent);
    // final transparentBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderTransparent);

    return TextFormField(
      cursorColor: black,
      validator: validator,
      maxLength: maxLength,
      onChanged: onChanged,
      controller: controller,
      showCursor: showCursor,
      focusNode: focusNode,
      minLines: minLines ?? 1,
      cursorHeight: 18,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      autofocus: autoFocus ?? false,
      obscureText: obscureText ?? false,
      style: sl<TextStyles>().text14_400(black),
      keyboardType: keyboardType ?? TextInputType.text,
      textCapitalization: textCapitalization ?? TextCapitalization.none,
      onSaved: controller != null ? (val) => controller?.text = val! : null,
      onEditingComplete: onEditingComplete,
      decoration: _inputDecoration,
      onTapOutside: onTapOutside,
      onTap: onTap,
    );
  }

  InputDecoration get _inputDecoration {
    var radius = BorderRadius.circular(6);
    var enabled = readOnly != null && readOnly! ? false : true;
    var borderGrey20 = const BorderSide(color: grey20);
    var borderGrey40 = const BorderSide(color: grey40);
    var borderBlack = const BorderSide(color: grey80);
    var borderRed = const BorderSide(color: red);
    var border = OutlineInputBorder(borderRadius: radius, borderSide: borderGrey40);
    var focusedBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderBlack);
    var errorBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderRed);
    var disabledBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderGrey20);
    var font14 = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.9.sp, tab: 14));
    var font13 = sl<DimensionHelper>().dimensionSizer(Dimension(mobile: 9.2.sp, tab: 13));
    return InputDecoration(
      filled: true,
      isDense: true,
      enabled: enabled,
      errorMaxLines: 2,
      hintText: hintText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      counterText: counterText,
      fillColor: white,
      labelStyle: sl<TextStyles>().text14_400(black),
      prefixIconConstraints: const BoxConstraints(minWidth: 44),
      suffixIconConstraints: const BoxConstraints(minWidth: 44),
      contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: border,
      enabledBorder: border,
      errorBorder: errorBorder,
      focusedErrorBorder: errorBorder,
      disabledBorder: disabledBorder,
      focusedBorder: readOnly != null && readOnly! ? border : focusedBorder,
      hintStyle: TextStyle(color: grey80, fontSize: font14, fontWeight: normal, fontFamily: poppins),
      errorStyle: TextStyle(color: red, fontSize: font13, fontWeight: normal, fontFamily: poppins),
    );
  }
}
