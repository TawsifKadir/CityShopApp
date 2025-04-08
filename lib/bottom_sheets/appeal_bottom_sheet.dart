import 'package:flutter/material.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/text_styles.dart';

/*Future<void> appealBottomSheet(Complain complain) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return WillPopScope(onWillPop: () => Future.value(false), child: _AppealBottomSheetView(complain));
    },
  );
}*/

class _AppealBottomSheetView extends StatefulWidget {
  final Complain complain;
  const _AppealBottomSheetView(this.complain);

  @override
  State<_AppealBottomSheetView> createState() => _AppealBottomSheetViewState();
}

class _AppealBottomSheetViewState extends State<_AppealBottomSheetView> {
  var note = TextEditingController();

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appealLabel = Text('Send Appeal'.translate, style: sl<TextStyles>().text18_500(white));
    var cancelLabel = Text('Cancel'.translate, style: sl<TextStyles>().text18_500(black));
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 30.height, maxHeight: 70.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Are you sure you want to appeal?'.translate, closeOnTap: null),
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.symmetric(horizontal: screenPadding), child: _complainInfo(context)),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: backToPrevious, child: cancelLabel)),
                const SizedBox(width: 20),
                Expanded(child: ElevatedButton(onPressed: () => _sendAppealOnTap(context), child: appealLabel)),
              ],
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _complainInfo(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Note'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 06),
        ModifiedTextField(minLines: 5, maxLines: 12, controller: note, hintText: 'Write your note here'.translate),
      ],
    );
  }

  void _sendAppealOnTap(BuildContext context) {
    if (note.text.isEmpty) return sl<Toasts>().errorToast(message: 'Please write your note here'.translate, isTop: true);
    // var body = {'complaint_id': widget.complain.id, 'note': note.text};
    // Provider.of<ComplainDetailsViewModel>(context, listen: false).sendAppeal(body);
    backToPrevious();
  }
}
