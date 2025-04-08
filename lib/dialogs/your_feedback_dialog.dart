import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/shadows.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/core_widgets/rating_bar.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/utils/transitions.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';

Future<void> yourFeedbackDialog(Complain complain) async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierColor: popupBearer,
    barrierDismissible: false,
    transitionDuration: dialogDuration,
    barrierLabel: 'Your Feedback Dialog',
    transitionBuilder: sl<Transitions>().bottomToTop,
    pageBuilder: (buildContext, anim1, anim2) {
      return PopScopeNavigator(canPop: false, child: Align(child: _YourFeedbackDialogView(complain)));
    },
  );
}

class _YourFeedbackDialogView extends StatefulWidget {
  final Complain complain;
  const _YourFeedbackDialogView(this.complain);

  @override
  State<_YourFeedbackDialogView> createState() => _YourFeedbackDialogViewState();
}

class _YourFeedbackDialogViewState extends State<_YourFeedbackDialogView> {
  double rating = 0;
  var comment = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    rating = 0;
    comment.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: dialogWidth,
      padding: EdgeInsets.symmetric(horizontal: dialogPadding, vertical: dialogPadding),
      decoration: BoxDecoration(color: white, borderRadius: dialogRadius, boxShadow: const [popupShadow]),
      child: Material(color: white, borderRadius: dialogRadius, child: _mobileView(context)),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your comment here'.translate;
    var full = SvgImage(image: Assets.star_filled, color: yellow);
    var empty = SvgImage(image: Assets.star_filled, color: grey60);
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(child: Text('Your Feedback'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text22_500(black))),
        const SizedBox(height: 24),
        Text('Rating'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 06),
        RatingBar(
          itemSize: 24,
          maxRating: 5,
          initialRating: rating,
          unratedColor: primary,
          itemPadding: const EdgeInsets.only(right: 3),
          onRatingUpdate: (data) => setState(() => rating = data),
          ratingWidget: RatingWidget(full: full, half: empty, empty: empty),
        ),
        const SizedBox(height: 24),
        Text('Your Comment'.translate, textAlign: TextAlign.center, style: sl<TextStyles>().text18_500(black)),
        const SizedBox(height: 06),
        ModifiedTextField(minLines: 06, maxLines: 10, controller: comment, hintText: hint),
        const SizedBox(height: 24),
        Row(children: [Expanded(child: _closeButton(context)), const SizedBox(width: 16), Expanded(child: _sendButton(context))]),
      ],
    );
  }

  Widget _closeButton(BuildContext context) {
    return OutlinedButton(
      onPressed: backToPrevious,
      child: Text('Close'.translate, style: sl<TextStyles>().text18_500(grey)),
    );
  }

  Widget _sendButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () => _sendOnTap(context),
      style: ElevatedButton.styleFrom(backgroundColor: red),
      child: Text('Send'.translate, style: sl<TextStyles>().text18_500(white)),
    );
  }

  void _sendOnTap(BuildContext context) {
    if (rating == 0) return sl<Toasts>().warningToast(message: 'Please give your rating'.translate, isTop: true);
    if (comment.text.isEmpty) return sl<Toasts>().warningToast(message: 'Please write your comment'.translate, isTop: true);
    backToPrevious();
    Provider.of<OfficerComplainDetailsViewModel>(context, listen: false).sendFeedback();
  }
}
