import 'package:flutter/material.dart';

import 'package:grs/components/list_views/comp_list/attachment_list.dart';
import 'package:grs/components/ui_widgets/no_attachments_view.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/photo_dialog.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/launchers.dart';
import 'package:grs/models/complain/attachment.dart';
import 'package:grs/utils/text_styles.dart';

class AttachmentView extends StatelessWidget {
  final List<Attachment> attachmentList;
  const AttachmentView({required this.attachmentList});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Previous attachments'.translate, style: sl<TextStyles>().text16_400(black)),
        const SizedBox(height: 6),
        if (!attachmentList.haveList) NoAttachmentsView(),
        if (attachmentList.haveList)
          AttachmentList(
            attachmentList: attachmentList,
            imageOnTap: (attachment) => photoDialog(type: ImageType.network, path: attachment.attachment_url!),
            audioOnTap: (index) {},
            fileOnTap: (index) {},
            videoOnTap: (index) {},
            downloadOnTap: (attachment) => sl<Launchers>().launchInBrowser(url: attachment.attachment_url!),
          ),
      ],
    );
  }
}
