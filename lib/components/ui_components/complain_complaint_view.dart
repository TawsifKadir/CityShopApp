import 'package:flutter/material.dart';

import 'package:lottie/lottie.dart';

import 'package:grs/components/list_views/complain/complain_list.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/library_widgets/circle_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/complain/complain_details_api.dart';
import 'package:grs/models/dummy/data_type.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class ComplainComplainantView extends StatelessWidget {
  final ComplainDetailsApi? complainDetails;
  final List<Complain> complains;
  const ComplainComplainantView(this.complainDetails, this.complains);

  @override
  Widget build(BuildContext context) {
    var loader = Center(child: Lottie.asset(Assets.image_loader, width: 100, height: 100));
    var error = Center(child: SvgImage(image: Assets.user_filled, color: grey, height: 50));
    var complaint = complainDetails?.complainedUser;
    var birth = complaint?.birthDate == null ? '' : sl<Formatters>().formatDate(DATE_FORMAT_4, complaint?.birthDate);
    var nid =
        complaint?.identificationType == null ? null : identity_types.firstWhere((item) => item.value == complaint!.identificationType);
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32),
          Center(child: CircleImage(radius: 45, imageUrl: null, backgroundColor: grey20, placeHolder: loader, errorWidget: error)),
          const SizedBox(height: 12),
          Center(child: Text(complaint?.name ?? '', style: sl<TextStyles>().text16_600(black))),
          const SizedBox(height: 2),
          Center(child: Text(complaint?.email ?? '', style: sl<TextStyles>().text14_400(black))),
          const SizedBox(height: 32),
          _labelInfo(label: 'Personal Details'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: '${'Gender'.translate}: ${complaint?.gender ?? ''}'),
          _valueInfo(value: '${'Birth Date'.translate}: $birth'),
          if (nid != null) _valueInfo(value: '${nid.label}: ${complaint?.identificationValue ?? ''}'),
          _valueInfo(value: '${'Qualification'.translate}: ${complaint?.educationalQualification ?? ''}'),
          _valueInfo(value: '${'Occupation'.translate}: ${complaint?.occupation ?? ''}'),
          _valueInfo(value: '${'Permanent address'.translate}: ${complaint?.permanentAddressHouse ?? ''}'),
          const SizedBox(height: 20),
          _labelInfo(label: 'Contact Details'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: '${'Mobile number'.translate}: ${complaint?.mobileNumber ?? ''}'),
          _valueInfo(value: '${'Email'.translate}: ${complaint?.email ?? ''}'),
          const SizedBox(height: 20),
          _labelInfo(label: 'Submitted Grievances of Complainant'.translate),
          SizedBox(height: complains.haveList ? 16 : 4),
          _complaintComplainList(context),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _complaintComplainList(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var label = Text('No previous complains available for this user', style: sl<TextStyles>().text15_400(black));
    if (!complains.haveList) return Padding(padding: padding, child: label);
    return ComplainList(pref: ComplainListPref.my_complain_history, complainList: complains);
  }

  Widget _labelInfo({required String label}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var labelText = Text(label, style: sl<TextStyles>().text15_400(black));
    return Container(color: grey20, width: SizeConfig.width, padding: padding, child: labelText);
  }

  Widget _valueInfo({required String value}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var valueText = Text(value, style: sl<TextStyles>().text15_400(black));
    return Container(color: white, width: SizeConfig.width, padding: padding, child: valueText);
  }
}
