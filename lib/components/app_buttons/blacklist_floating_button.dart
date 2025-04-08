import 'package:flutter/material.dart';

import 'package:grs/bottom_sheets/add_blacklist_sheet.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain_details_api.dart';
import 'package:grs/utils/text_styles.dart';

class BlacklistFloatingButton extends StatelessWidget {
  final bool loader;
  final bool isBlackList;
  final ComplainDetailsApi complainDetails;

  const BlacklistFloatingButton({required this.loader, required this.complainDetails, required this.isBlackList});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      elevation: loader ? 0 : 1,
      materialTapTargetSize: MaterialTapTargetSize.padded,
      backgroundColor: loader ? primary.withOpacity(0.6) : primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      label: Text((isBlackList ? 'Blacklisted Complaint' : 'Add In Blacklist').translate, style: sl<TextStyles>().text15_600(white)),
      onPressed: () => isBlackList ? null : addBlacklistBottomSheet(complainDetails),
    );
  }
}
