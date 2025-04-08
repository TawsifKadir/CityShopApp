import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/blacklist/blacklist.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';

Future<void> blacklistDetailsBottomSheet(Blacklist blacklist) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return PopScopeNavigator(canPop: false, child: _BlacklistDetailsSheetView(blacklist));
    },
  );
}

class _BlacklistDetailsSheetView extends StatelessWidget {
  final Blacklist blacklist;
  const _BlacklistDetailsSheetView(this.blacklist);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Blacklist Details'.translate, closeOnTap: null),
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.symmetric(horizontal: screenPadding), child: _complainInfo(context)),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: ElevatedButton(onPressed: backToPrevious, child: Text('Close'.translate, style: sl<TextStyles>().text18_500(white))),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _complainInfo(BuildContext context) {
    var reason = blacklist.reason;
    var name = blacklist.complainantInfo?.name;
    var occupation = blacklist.complainantInfo?.occupation;
    var email = blacklist.complainantInfo?.email;
    var mobileNumber = blacklist.complainantInfo?.mobileNumber;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        if (name != null) Text('Name'.translate, style: sl<TextStyles>().text16_600(black)),
        if (name != null) Text(name, style: sl<TextStyles>().text16_400(black)),
        if (name != null) const SizedBox(height: 10),
        if (occupation != null) Text('Occupation'.translate, style: sl<TextStyles>().text16_600(black)),
        if (occupation != null) Text(occupation, style: sl<TextStyles>().text16_400(black)),
        if (occupation != null) const SizedBox(height: 10),
        if (email != null) Text('Email'.translate, style: sl<TextStyles>().text16_600(black)),
        if (email != null) Text(email, style: sl<TextStyles>().text16_400(black)),
        if (email != null) const SizedBox(height: 10),
        if (mobileNumber != null) Text('Mobile Number'.translate, style: sl<TextStyles>().text16_600(black)),
        if (mobileNumber != null) Text(mobileNumber, style: sl<TextStyles>().text16_400(black)),
        if (mobileNumber != null) const SizedBox(height: 10),
        if (reason != null) Text('Reason'.translate, style: sl<TextStyles>().text16_600(black)),
        if (reason != null)
          Text(reason.removeHtml, maxLines: 7, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black)),
      ],
    );
  }
}
