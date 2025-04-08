import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/fonts.dart';
import 'package:grs/models/dummy/language.dart';

class LanguageList extends StatelessWidget {
  final Language selectedLanguage;
  final Function(int) onTap;
  const LanguageList({required this.selectedLanguage, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _languageCard,
      clipBehavior: Clip.antiAlias,
      itemCount: allLanguages.length,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _languageCard(BuildContext context, int index) {
    var language = allLanguages[index];
    var style = const TextStyle(color: black, fontSize: 16, fontWeight: w500);
    var radioOff = const Icon(Icons.radio_button_off, size: 24, color: grey80);
    var radioOn = const Icon(Icons.radio_button_checked, size: 24, color: primary);
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: index == 0 ? 20 : 0),
        margin: EdgeInsets.only(bottom: index == allLanguages.length - 1 ? 24 : 16),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Image.asset(language.icon, height: 24, width: 24, fit: BoxFit.cover)),
                const SizedBox(width: 16),
                Expanded(child: Text(language.name, maxLines: 1, overflow: TextOverflow.ellipsis, style: style)),
                const SizedBox(width: 16),
                selectedLanguage == language ? radioOn : radioOff,
              ],
            ),
            if (index != allLanguages.length - 1) const SizedBox(height: 16),
            if (index != allLanguages.length - 1) Container(width: double.infinity, height: 1, color: grey60),
          ],
        ),
      ),
    );
  }
}
