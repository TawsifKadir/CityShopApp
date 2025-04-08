import 'package:flutter/material.dart';

import 'package:grs/components/list_views/comp_list/attachment_list.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/constants/date_formats.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/photo_dialog.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/libraries/launchers.dart';
import 'package:grs/models/complain/complain_details_api.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';

class ComplainDetailsView extends StatelessWidget {
  final ComplainDetailsApi? complainDetails;
  const ComplainDetailsView({required this.complainDetails});

  @override
  Widget build(BuildContext context) {
    var complain = complainDetails?.complain;
    var complaint = complainDetails?.complainedUser;
    var office = complainDetails?.office;
    var date = complain?.submissionDate == null ? null : sl<Formatters>().formatDate(DATE_FORMAT_4, complain!.submissionDate);
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16),
          _labelInfo(label: 'Grievance To'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: date ?? ''),
          _valueInfo(value: 'Grievance Redress Officer'.translate),
          _valueInfo(value: office?.office_name ?? ''),
          const SizedBox(height: 20),
          _boldLabelInfo(label: 'Subject'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: complain?.subject ?? ''),
          const SizedBox(height: 20),
          _boldLabelInfo(label: 'Grievance Details'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: complain?.complain_details ?? ''),
          const SizedBox(height: 20),
          _labelInfo(label: 'Details of Service'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: '${'Tracking Number'.translate}: ${complain?.tracking_number}'),
          _valueInfo(value: '${'Case number'.translate}: ${complain?.case_number ?? ''}'),
          _valueInfo(value: '${'Status'.translate}: ${complain?.format_status}'),
          const SizedBox(height: 20),
          _labelInfo(label: 'Complaint Information'.translate),
          const SizedBox(height: 4),
          _valueInfo(value: '${'Name'}: ${complaint?.name ?? ''}'),
          _valueInfo(value: '${'Mobile number'.translate}: ${complaint?.mobileNumber ?? ''}'),
          const SizedBox(height: 20),
          _labelInfo(label: 'Complain Attachments'.translate),
          const SizedBox(height: 16),
          _complainAttachments(context),
          const SizedBox(height: 24),
          _labelInfo(label: 'History Attachments'.translate),
          const SizedBox(height: 16),
          _historyAttachments(context),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _complainAttachments(BuildContext context) {
    var complain = complainDetails?.complain;
    var attachment = complain?.attachmentInfo;
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var label = Text('No complain attachments available now'.translate, style: sl<TextStyles>().text15_400(black));
    if (attachment == null) return Padding(padding: padding, child: label);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AttachmentList(
        attachmentList: attachment,
        imageOnTap: (attachment) => photoDialog(type: ImageType.network, path: attachment.attachment_url!),
        audioOnTap: (index) {},
        fileOnTap: (index) {},
        videoOnTap: (index) {},
        downloadOnTap: (attachment) => sl<Launchers>().launchInBrowser(url: attachment.attachment_url!),
      ),
    );
  }

  Widget _historyAttachments(BuildContext context) {
    // var complain = modelData.complainDetails?.complain;
    // var attachment = complain?.attachmentInfo;
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var label = Text('No History attachments available now'.translate, style: sl<TextStyles>().text15_400(black));
    return Padding(padding: padding, child: label);
    /*if (attachment == null) return Padding(padding: padding, child: label);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AttachmentList(
        attachmentList: [attachment],
        imageOnTap: (index) {},
        audioOnTap: (index) {},
        fileOnTap: (index) {},
        videoOnTap: (index) {},
      ),
    );*/
  }

  Widget _labelInfo({required String label}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var labelText = Text(label, style: sl<TextStyles>().text15_400(black));
    return Container(color: grey20, width: SizeConfig.width, padding: padding, child: labelText);
  }

  Widget _boldLabelInfo({required String label}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var labelText = Text(label, style: sl<TextStyles>().text16_800(black));
    return Container(color: grey20, width: SizeConfig.width, padding: padding, child: labelText);
  }

  Widget _valueInfo({required String value}) {
    var padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 2);
    var valueText = Text(value, style: sl<TextStyles>().text15_400(black));
    return Container(color: white, width: SizeConfig.width, padding: padding, child: valueText);
  }
}
