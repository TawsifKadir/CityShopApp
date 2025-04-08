import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/rating_bar.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/flutter_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain/tracking_view_model.dart';

class TrackingScreen extends StatefulWidget {
  @override
  State<TrackingScreen> createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  var viewModel = TrackingViewModel();
  var modelData = TrackingViewModel();
  var formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<TrackingViewModel>(context, listen: false);
    modelData = Provider.of<TrackingViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var responsive = Responsive(mobile: _mobileView(context));
    var label = Text('Track your Complain'.translate);
    var actions = [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)];
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(centerTitle: false, leading: const BackMenu(), automaticallyImplyLeading: false, title: label, actions: actions),
      body: Stack(children: [Container(width: width, height: height, child: responsive), if (modelData.loader) ScreenLoader()]),
    );
  }

  Widget _mobileView(BuildContext context) {
    return SingleChildScrollView(
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: screenPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          Text('tracking_desc'.translate, style: sl<TextStyles>().text16_500(black)),
          const SizedBox(height: 24),
          Row(
            children: [
              Text('Mobile number'.translate, style: sl<TextStyles>().text14_400(black)),
              const Text(' '),
              Text('*', style: sl<TextStyles>().text14_600(red)),
            ],
          ),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.mobileNo,
            keyboardType: TextInputType.phone,
            hintText: 'Mobile number (in Bangla/English)'.translate,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Text('Tracking number'.translate, style: sl<TextStyles>().text14_400(black)),
              const Text(' '),
              Text('*', style: sl<TextStyles>().text14_600(red)),
            ],
          ),
          const SizedBox(height: 4),
          ModifiedTextField(
            controller: viewModel.trackingNo,
            keyboardType: TextInputType.number,
            hintText: 'Write your tracking number'.translate,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: modelData.loader ? null : () => _trackingOnTap(context),
            child: Text('Track Complain'.translate, style: sl<TextStyles>().text18_500(white)),
          ),
          const SizedBox(height: 24),
          if (modelData.complain != null) _complainStatusBox(context),
        ],
      ),
    );
  }

  void _trackingOnTap(BuildContext context) {
    FocusScope.of(context).unfocus();
    var mobileLength = viewModel.mobileNo.text.length;
    if (mobileLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your mobile number'.translate, isTop: true);
    if (mobileLength != 11) return sl<Toasts>().warningToast(message: 'Mobile number must be 11 digit'.translate, isTop: true);
    var trackingLength = viewModel.trackingNo.text.length;
    if (trackingLength < 1) return sl<Toasts>().warningToast(message: 'Please enter your tracking number'.translate, isTop: true);
    if (trackingLength < 11) return sl<Toasts>().warningToast(message: 'Tracking number is not valid'.translate, isTop: true);
    var phone = viewModel.mobileNo.text;
    var tracking = viewModel.trackingNo.text.substring(0, 11);
    if (phone != tracking) return sl<Toasts>().warningToast(message: 'Mobile number is not valid'.translate, isTop: true);
    viewModel.trackComplainOnTap();
  }

  bool get _ratingStatus {
    var complain = modelData.complain;
    var status = complain?.currentStatus ?? '';
    if (status == '') return false;
    var officerStatus = status == 'CLOSED_OTHERS' || status == 'CLOSED_ACCUSATION_INCORRECT' || status == 'CLOSED_ACCUSATION_PROVED';
    var appealStatus =
        status == 'APPEAL_CLOSED_OTHERS' || status == 'APPEAL_CLOSED_ACCUSATION_INCORRECT' || status == 'APPEAL_CLOSED_ACCUSATION_PROVED';
    return (officerStatus || appealStatus) && (complain?.isRatingGiven == null || complain?.isRatingGiven == 0);
  }

  Widget _complainStatusBox(BuildContext context) {
    var complain = modelData.complain;
    var ratingGiven = complain?.isRatingGiven;
    var isRating = sl<AuthService>().authStatus && _ratingStatus && (ratingGiven == null || ratingGiven == 0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),
        Text('Tracking Details'.translate, style: sl<TextStyles>().text20_600(black)),
        const SizedBox(height: 04),
        Container(height: 1, width: 40.width, color: grey60),
        const SizedBox(height: 16),
        Text('Grievance Date'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(sl<Formatters>().formatDate(DATE_FORMAT_4, complain?.submissionDate), style: sl<TextStyles>().text16_500(black)),
        const SizedBox(height: 8),
        Text('Subject'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(complain?.subject ?? '', style: sl<TextStyles>().text16_500(black)),
        const SizedBox(height: 8),
        Text('Current Status'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(complain?.format_status ?? '', style: sl<TextStyles>().text14_400(black)),
        const SizedBox(height: 8),
        Text('Other Service Worker'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(complain?.otherService ?? '', style: sl<TextStyles>().text14_400(black)),
        const SizedBox(height: 8),
        Text('Possible Close Date'.translate, style: sl<TextStyles>().text16_600(black)),
        Text(sl<Formatters>().formatDate(DATE_FORMAT_4, complain?.possibleCloseDate), style: sl<TextStyles>().text14_400(black)),
        // if (isRating) const SizedBox(height: 20),
        // if (isRating) _ratingSection(context),
        SizedBox(height: SizeConfig.bottomNotch ? 24 : 20),
      ],
    );
  }

  Widget _ratingSection(BuildContext context) {
    var empty = SvgImage(image: Assets.star_outline);
    var full = SvgImage(image: Assets.star_filled, color: amber);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Your Rating'.translate, style: sl<TextStyles>().text16_600(black)),
        RatingBar(
          itemSize: 30,
          unratedColor: primary,
          itemPadding: const EdgeInsets.only(right: 8),
          onRatingUpdate: (data) => setState(() => modelData.rating = data),
          ratingWidget: RatingWidget(full: full, half: empty, empty: empty),
        ),
        const SizedBox(height: 16),
        Text('Your comment'.translate, style: sl<TextStyles>().text16_500(black)),
        ModifiedTextField(minLines: 5, maxLines: 12, controller: modelData.comment, hintText: 'Write your comment here'.translate),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () => _submitRatingOnTap(context),
          child: Text('Send Rating'.translate, style: sl<TextStyles>().text18_500(white)),
        ),
      ],
    );
  }

  void _submitRatingOnTap(BuildContext context) {
    minimizeKeyboard();
    if (modelData.rating < 1) return sl<Toasts>().warningToast(message: 'Please put a rating'.translate, isTop: true);
    viewModel.submitRating();
  }
}
