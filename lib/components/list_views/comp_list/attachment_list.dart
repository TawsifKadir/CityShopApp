import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/file_helper.dart';
import 'package:grs/library_widgets/online_image.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/complain/attachment.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class AttachmentList extends StatelessWidget {
  final List<Attachment> attachmentList;
  final Function(Attachment) imageOnTap;
  final Function(int) fileOnTap;
  final Function(int) audioOnTap;
  final Function(int) videoOnTap;
  final Function(Attachment) downloadOnTap;

  const AttachmentList({
    required this.attachmentList,
    required this.imageOnTap,
    required this.fileOnTap,
    required this.audioOnTap,
    required this.videoOnTap,
    required this.downloadOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _fileCard,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      itemCount: attachmentList.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _fileCard(BuildContext context, int index) {
    var attachment = attachmentList[index];
    var center = Alignment.center;
    var fileType = sl<FileHelper>().getFileType(attachment.filePath);
    var downloadIcon = SvgImage(image: Assets.download, color: primary, height: 20, fit: BoxFit.contain);
    var visibility = SvgImage(image: Assets.visibility_on_outline, color: primary, height: 20, fit: BoxFit.contain);
    return Container(
      height: 64,
      width: double.infinity,
      margin: EdgeInsets.only(bottom: index == attachmentList.length - 1 ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fileType.isImageFile)
            OnlineImage(
              radius: 04,
              width: 56,
              height: 56,
              borderColor: grey40,
              image: attachment.attachment_url,
              errorWidget: _dummyFileImage(context, attachment),
            )
          else
            _dummyFileImage(context, attachment),
          const SizedBox(width: 12),
          Expanded(child: _fileInformation(context, attachment)),
          if (fileType.isImageFile) const SizedBox(width: 10),
          if (fileType.isImageFile)
            InkWell(onTap: () => _fileOnTap(context, index), child: Container(width: 24, height: 24, alignment: center, child: visibility)),
          const SizedBox(width: 10),
          InkWell(
            onTap: () => downloadOnTap(attachment),
            child: Container(width: 24, height: 24, alignment: center, child: downloadIcon),
          ),
        ],
      ),
    );
  }

  Widget _dummyFileImage(BuildContext context, Attachment attachment) {
    var icon = sl<FileHelper>().getFileBasedIcon(attachment.filePath);
    var image = SvgImage(image: icon, color: primary, height: 36, fit: BoxFit.cover);
    var decoration = BoxDecoration(border: Border.all(color: grey40), borderRadius: BorderRadius.circular(04));
    return Container(width: 56, height: 56, child: image, alignment: Alignment.center, decoration: decoration);
  }

  Widget _fileInformation(BuildContext context, Attachment attachment) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          attachment.originalName ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: sl<TextStyles>().text14_400(black),
        ),
        Text(
          '${'Title'.translate}: ${attachment.fileTitle ?? ''}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: sl<TextStyles>().text12_400(black),
        ),
        Text(
          '${'File type'.translate}: ${attachment.fileType == null ? '' : attachment.fileType!.toLower}',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: sl<TextStyles>().text12_400(black),
        ),
      ],
    );
  }

  void _fileOnTap(BuildContext context, int index) {
    var attachment = attachmentList[index];
    var fileType = attachmentList[index].fileType == null ? null : attachmentList[index].fileType!.toLower;
    if (fileType == null) return;
    if (fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg' || fileType == 'bmp') {
      imageOnTap(attachment);
    } else if (fileType == 'doc' || fileType == 'docx' || fileType == 'pdf' || fileType == 'xls' || fileType == 'xlsx') {
      fileOnTap(index);
    } else if (fileType == 'mp3') {
      audioOnTap(index);
    } else if (fileType == '3gp' || fileType == 'mp4' || fileType == 'flv' || fileType == 'avi') {
      videoOnTap(index);
    } else if (fileType == 'zip' || fileType == 'rar') {
      return;
    } else {
      return;
    }
  }
}
