import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/core_widgets/rating_bar.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain_details/citizen_complain_details_view_model.dart';

Future<void> ratingBottomSheet(Complain complain) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return PopScopeNavigator(canPop: false, child: _RatingBottomSheetView(complain));
    },
  );
}

class _RatingBottomSheetView extends StatefulWidget {
  final Complain complain;
  const _RatingBottomSheetView(this.complain);

  @override
  State<_RatingBottomSheetView> createState() => _RatingBottomSheetViewState();
}

class _RatingBottomSheetViewState extends State<_RatingBottomSheetView> {
  double rating = 0;
  var comment = TextEditingController();

  @override
  void dispose() {
    rating = 0;
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var buttonLabel = Text('Send Rating'.translate, style: sl<TextStyles>().text18_500(white));
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 30.height, maxHeight: 70.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Complain Rating'.translate, closeOnTap: backToPrevious),
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.symmetric(horizontal: screenPadding), child: _complainInfo(context)),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: ElevatedButton(onPressed: () => _sendAppealOnTap(context), child: buttonLabel),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _complainInfo(BuildContext context) {
    var full = SvgImage(image: Assets.star_filled, color: primary);
    var empty = SvgImage(image: Assets.star_outline);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Rating'.translate, style: sl<TextStyles>().text16_500(black)),
        const SizedBox(height: 6),
        RatingBar(
          itemSize: 24,
          unratedColor: primary,
          itemPadding: const EdgeInsets.only(right: 8),
          onRatingUpdate: (data) => setState(() => rating = data),
          ratingWidget: RatingWidget(full: full, half: empty, empty: empty),
        ),
        const SizedBox(height: 20),
        Text('Your comment'.translate, style: sl<TextStyles>().text16_500(black)),
        ModifiedTextField(minLines: 5, maxLines: 12, controller: comment, hintText: 'Write your comment here'.translate),
      ],
    );
  }

  void _sendAppealOnTap(BuildContext context) {
    if (rating < 1) return sl<Toasts>().errorToast(message: 'Please put a rating'.translate, isTop: true);
    var body = {'complaint_id': widget.complain.id, 'rating': rating, 'feedback_comments': comment.text};
    Provider.of<CitizenComplainDetailsViewModel>(context, listen: false).sendRating(body);
    backToPrevious();
  }
}
