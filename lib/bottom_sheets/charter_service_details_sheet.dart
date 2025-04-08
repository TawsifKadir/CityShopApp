import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/citizen_charter/charter_service.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';

Future<void> charterServiceDetailsBottomSheet(CharterService service) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return PopScopeNavigator(canPop: false, child: _BlacklistDetailsSheetView(service));
    },
  );
}

class _BlacklistDetailsSheetView extends StatelessWidget {
  final CharterService service;
  const _BlacklistDetailsSheetView(this.service);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65.height,
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Service Details'.translate, closeOnTap: null),
          const SizedBox(height: 24),
          Expanded(child: _serviceInfo(context)),
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

  Widget _serviceInfo(BuildContext context) {
    var time = sl<Formatters>().localizeNumber('${service.serviceTime ?? 0}');
    return ListView(
      shrinkWrap: true,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenPadding),
      children: [
        Text('Name of service'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(service.service_name.trim(), style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Service Procedure'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(service.service_procedure.trim(), style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Document and Location'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(service.service_doc.trim(), style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Service Price and Payment Method'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(service.payment_method, style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 10),
        Text('Service Time (in days)'.translate, style: sl<TextStyles>().text16_600(black)),
        Text('$time ${'Workdays'.translate}', maxLines: 7, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black)),
      ],
    );
  }
}
