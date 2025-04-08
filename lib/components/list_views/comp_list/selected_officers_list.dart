import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/models/branch/officer.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/text_styles.dart';

class SelectedOfficersList extends StatelessWidget {
  final bool isRecipient;
  final bool isCommitteeHead;
  final Function(int) removeOnTap;
  final Function(int) recipientOnTap;
  final Function(int) committeeHeadOnTap;
  final List<Officer> selectedOfficers;

  const SelectedOfficersList({
    required this.isRecipient,
    required this.isCommitteeHead,
    required this.removeOnTap,
    required this.selectedOfficers,
    required this.recipientOnTap,
    required this.committeeHeadOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: _officerCard,
      clipBehavior: Clip.antiAlias,
      itemCount: selectedOfficers.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _officerCard(BuildContext context, int index) {
    var officer = selectedOfficers[index];
    var des = officer.designation ?? '';
    var name = officer.name ?? '';
    var slNo = index + 1 > 9 ? index + 1 : '0${index + 1}';
    var closeIcon = SvgImage(image: Assets.close, height: 20, color: red);
    return Container(
      width: double.infinity,
      padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
      margin: EdgeInsets.only(bottom: index == selectedOfficers.length - 1 ? 0 : 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 30, child: Text('$slNo.', style: sl<TextStyles>().text15_600(black))),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text15_400(black)),
                const SizedBox(height: 6),
                Text(des, maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_400(grey80)),
                !isCommitteeHead && !isRecipient ? const SizedBox.shrink() : const SizedBox(height: 6),
                !isCommitteeHead && !isRecipient ? const SizedBox.shrink() : _actionSection(context, index),
              ],
            ),
          ),
          if (!isCommitteeHead && !isRecipient) const SizedBox(width: 16),
          if (!isCommitteeHead && !isRecipient) InkWell(onTap: () => removeOnTap(index), child: Center(child: closeIcon)),
        ],
      ),
    );
  }

  Widget _actionSection(BuildContext context, int index) {
    return Row(
      children: [
        if (isCommitteeHead) _committeeHead(context, index),
        if (isCommitteeHead) const SizedBox(width: 12),
        if (isRecipient) _copyRecipient(context, index),
        if (isRecipient) const SizedBox(width: 12),
        _closeAction(context, index),
      ],
    );
  }

  Widget _committeeHead(BuildContext context, int index) {
    var officer = selectedOfficers[index];
    var isHead = officer.isCommitteeHead != null && officer.isCommitteeHead == true;
    var radioOff = const Icon(Icons.radio_button_off, color: primary, size: 20);
    var radioOn = const Icon(Icons.radio_button_checked, color: primary, size: 20);
    var label = Text('Head'.translate, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_400(grey80));
    return InkWell(
      onTap: () => committeeHeadOnTap(index),
      child: Row(children: [isHead ? radioOn : radioOff, const SizedBox(width: 06), label]),
    );
  }

  Widget _copyRecipient(BuildContext context, int index) {
    var officer = selectedOfficers[index];
    var isRecipient = officer.isRecipient != null && officer.isRecipient!;
    var check = const Icon(Icons.check_box_outline_blank, size: 20, color: primary);
    var checked = const Icon(Icons.check_box, size: 20, color: primary);
    var label = Text('Recipient'.translate, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_400(grey80));
    return InkWell(
      onTap: () => recipientOnTap(index),
      child: Row(children: [isRecipient ? checked : check, const SizedBox(width: 06), label]),
    );
  }

  Widget _closeAction(BuildContext context, int index) {
    var close = SvgImage(image: Assets.close, height: 18, color: red);
    var label = Text('Remove'.translate, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text14_400(red));
    return InkWell(onTap: () => removeOnTap(index), child: Row(children: [close, const SizedBox(width: 06), label]));
  }
}
