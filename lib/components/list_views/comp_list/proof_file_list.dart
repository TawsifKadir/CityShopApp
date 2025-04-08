import 'package:flutter/material.dart';

import 'package:path/path.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/image_memory.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/file_helper.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/dummy/proof_file.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class ProofFileList extends StatelessWidget {
  final Function(int) onTap;
  final Function(int) removeOnTap;
  final List<ProofFile> proofFileList;
  const ProofFileList({required this.proofFileList, required this.onTap, required this.removeOnTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: _fileCard,
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      itemCount: proofFileList.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _fileCard(BuildContext context, int index) {
    var proofFile = proofFileList[index];
    var closeIcon = SvgImage(image: Assets.close, color: red, height: 20, fit: BoxFit.contain);
    var visibility = SvgImage(image: Assets.visibility_on_outline, color: primary, height: 20, fit: BoxFit.contain);
    var fileType = sl<FileHelper>().getFileType(proofFile.file.path);
    return Container(
      width: double.infinity,
      height: 56,
      margin: EdgeInsets.only(bottom: index == proofFileList.length - 1 ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (fileType.isImageFile)
            ImageMemory(radius: 04, size: 56, imagePath: proofFile.unit8List, errorWidget: _dummyFileImage(context, proofFile))
          else
            _dummyFileImage(context, proofFile),
          const SizedBox(width: 12),
          Expanded(child: _fileInformation(context, proofFile)),
          if (fileType.isImageFile) const SizedBox(width: 10),
          if (fileType.isImageFile)
            InkWell(onTap: () => onTap(index), child: Container(width: 24, height: 24, alignment: Alignment.center, child: visibility)),
          const SizedBox(width: 10),
          InkWell(onTap: () => removeOnTap(index), child: Container(width: 24, height: 24, alignment: Alignment.center, child: closeIcon)),
        ],
      ),
    );
  }

  Widget _dummyFileImage(BuildContext context, ProofFile proofFile) {
    var icon = sl<FileHelper>().getFileBasedIcon(proofFile.file.path);
    var image = SvgImage(image: icon, color: primary, height: 36, fit: BoxFit.cover);
    var decoration = BoxDecoration(border: Border.all(color: grey40), borderRadius: BorderRadius.circular(04));
    return Container(width: 56, height: 56, child: image, alignment: Alignment.center, decoration: decoration);
  }

  Widget _fileInformation(BuildContext context, ProofFile proofFile) {
    var isDuplicate = sl<FileHelper>().isDuplicateFile(proofFileList, proofFile.file);
    var style = sl<TextStyles>().text14_400(isDuplicate ? amber : black);
    var invalid = proofFile.isLarge ? 'This file size is too large.' : 'File type is not valid';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(basename(proofFile.file.path), maxLines: 1, overflow: TextOverflow.ellipsis, style: style),
        const SizedBox(width: 2),
        if (proofFile.isLarge || !proofFile.isValid)
          Text(invalid.translate, style: sl<TextStyles>().text14_400(red))
        else
          ModifiedTextField(
            controller: proofFile.name,
            keyboardType: TextInputType.text,
            hintText: 'Enter file name here'.translate,
            contentPadding: const EdgeInsets.fromLTRB(16, 10, 16, 10),
          ),
      ],
    );
  }
}
