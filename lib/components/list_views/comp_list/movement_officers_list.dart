import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/models/history/complain_history.dart';
import 'package:grs/utils/text_styles.dart';

class MovementOfficersList extends StatelessWidget {
  final Function(int) onTap;
  final List<ComplainHistory> movementOfficers;

  const MovementOfficersList({required this.onTap, required this.movementOfficers});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: _officerCard,
      clipBehavior: Clip.antiAlias,
      itemCount: movementOfficers.length,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _officerCard(BuildContext context, int index) {
    var officer = movementOfficers[index];
    var isSelected = officer.isSelected != null && officer.isSelected!;
    var name = officer.to_employee_name;
    var designation = officer.toEmployeeDesignationBng ?? '';
    var unit = officer.toEmployeeUnitNameBng ?? '';
    var officerLabel = '$name${designation.trim().length < 1 ? '' : ', '}$designation${unit.trim().length < 1 ? '' : ', '}$unit'.trim();
    var icon = Icon(isSelected ? Icons.check_box : Icons.check_box_outline_blank, color: isSelected ? primary : grey, size: 20);
    return InkWell(
      onTap: () => onTap(index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.only(top: index == 0 ? 10 : 0),
        margin: EdgeInsets.only(bottom: index == movementOfficers.length - 1 ? 0 : 6),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(padding: const EdgeInsets.only(top: 2), child: icon),
            const SizedBox(width: 6),
            Expanded(child: Text(officerLabel, style: sl<TextStyles>().text15_400(black)))
          ],
        ),
      ),
    );
  }
}
