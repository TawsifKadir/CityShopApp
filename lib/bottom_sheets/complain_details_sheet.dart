import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';

Future<void> complainDetailsBottomSheet(Complain complain) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return PopScopeNavigator(canPop: false, child: _ComplainDetailsSheetView(complain));
    },
  );
}

class _ComplainDetailsSheetView extends StatelessWidget {
  final Complain complain;
  const _ComplainDetailsSheetView(this.complain);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 30.height, maxHeight: 70.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Complain Details'.translate, closeOnTap: null),
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
    var date = sl<Formatters>().formatDate(DATE_FORMAT_10, '${complain.submissionDate}');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Tracking id'.translate, style: sl<TextStyles>().text16_500(black)),
        Text('#${complain.tracking_number}', style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Complain subject'.translate, style: sl<TextStyles>().text16_500(black)),
        Text(complain.subject ?? '', style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Complain details'.translate, style: sl<TextStyles>().text16_500(black)),
        Text(complain.details ?? '', style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Complain date'.translate, style: sl<TextStyles>().text16_500(black)),
        Text(date, style: sl<TextStyles>().text16_400(black)),
      ],
    );
  }
}
