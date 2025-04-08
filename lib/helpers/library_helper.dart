import 'package:flutter/material.dart';

import 'package:flutter_typeahead/flutter_typeahead.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/fonts.dart';
import 'package:grs/di.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class LibraryHelper {
  Widget typeAheadLoader(BuildContext context) {
    var radius = BorderRadius.circular(4);
    var decoration = BoxDecoration(color: grey20.withOpacity(0.5), borderRadius: radius);
    var box = Container(height: 40, width: double.infinity, decoration: decoration);
    return Container(
      height: 130,
      color: white,
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      child: Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [box, box]),
    );
  }

  TextFieldConfiguration typeAheadConfig({required TextEditingController controller, required String hint, Widget? suffix}) {
    var radius = BorderRadius.circular(6);
    var borderGrey20 = const BorderSide(color: grey20);
    var borderGrey40 = const BorderSide(color: grey40);
    var borderBlack = const BorderSide(color: black);
    var borderRed = const BorderSide(color: red);
    var border = OutlineInputBorder(borderRadius: radius, borderSide: borderGrey40);
    var focusedBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderBlack);
    var errorBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderRed);
    var disabledBorder = OutlineInputBorder(borderRadius: radius, borderSide: borderGrey20);
    return TextFieldConfiguration(
      cursorColor: black,
      controller: controller,
      style: sl<TextStyles>().text14_400(black),
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        hintMaxLines: 1,
        border: border,
        fillColor: white,
        enabledBorder: border,
        errorBorder: errorBorder,
        focusedBorder: focusedBorder,
        disabledBorder: disabledBorder,
        focusedErrorBorder: errorBorder,
        hintText: hint,
        suffixIcon: suffix,
        prefixIconConstraints: const BoxConstraints(minWidth: 44),
        suffixIconConstraints: const BoxConstraints(minWidth: 44),
        contentPadding: const EdgeInsets.fromLTRB(16, 15, 16, 15),
        prefixIcon: SvgImage(image: Assets.search, color: grey80, height: 20),
        hintStyle: const TextStyle(color: grey80, fontSize: 14, fontWeight: normal, fontFamily: poppins),
      ),
    );
  }
}
