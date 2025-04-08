import 'package:flutter/material.dart';

import 'package:grs/bottom_sheets/blacklist_details_sheet.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_switch.dart';
import 'package:grs/core_widgets/profile_image.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/blacklist/blacklist.dart';
import 'package:grs/utils/text_styles.dart';

class BlackListListview extends StatelessWidget {
  final BlackListPref pref;
  final List<Blacklist> blacklists;
  final ScrollController? scrollController;
  final Function(bool, int) onChanged;
  const BlackListListview({required this.pref, required this.blacklists, required this.onChanged, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: scrollController,
      clipBehavior: Clip.antiAlias,
      itemCount: blacklists.length,
      itemBuilder: _blacklistCard,
      physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
      padding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  Widget _blacklistCard(BuildContext context, int index) {
    var blacklist = blacklists[index];
    var complaint = blacklists[index].complainantInfo;
    var isBlacklist = pref == BlackListPref.blacklist;
    var status = blacklist.blacklisted != null && blacklist.blacklisted == 1;
    return InkWell(
      onTap: () => blacklistDetailsBottomSheet(blacklists[index]),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 16),
        margin: EdgeInsets.only(bottom: index == blacklists.length - 1 ? 20 : 0),
        child: Row(
          children: [
            const ProfileImage(image: null, box_size: 75, image_size: 75),
            const SizedBox(width: 12),
            Expanded(child: complaint == null ? Container() : _complaintInformation(context, index)),
            if (isBlacklist) const SizedBox(width: 10),
            if (isBlacklist)
              ModifiedSwitch(width: 40, height: 22, toggleSize: 15, value: status, onToggle: (data) => onChanged(data, index)),
          ],
        ),
      ),
    );
  }

  Widget _complaintInformation(BuildContext context, int index) {
    var isRequested = pref == BlackListPref.requested_blacklist;
    var complaint = blacklists[index].complainantInfo;
    var reason = blacklists[index].reason;
    var phone = complaint?.mobileNumber;
    var occupation = complaint?.occupation ?? '';
    var name_style = sl<TextStyles>().text15_600(primary);
    var other_style = sl<TextStyles>().text15_400(black);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (complaint?.name != null) Text(complaint?.name ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: name_style),
        if (complaint?.occupation != null) Text(occupation, maxLines: 1, overflow: TextOverflow.ellipsis, style: other_style),
        if (complaint?.email != null) Text(complaint?.email ?? '', maxLines: 1, overflow: TextOverflow.ellipsis, style: other_style),
        if (!isRequested && phone != null) Text(phone, maxLines: 1, overflow: TextOverflow.ellipsis, style: other_style),
        if (isRequested && reason != null) Text(reason.removeHtml, maxLines: 1, overflow: TextOverflow.ellipsis, style: other_style),
      ],
    );
  }
}
