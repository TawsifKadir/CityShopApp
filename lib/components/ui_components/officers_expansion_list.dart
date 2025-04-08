import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/expansion.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/branch/officer.dart';
import 'package:grs/models/subordinate_office/sub_ordinate_office.dart';
import 'package:grs/utils/text_styles.dart';

class SubordinateOfficeList extends StatelessWidget {
  final bool isMultiSelect;
  final Officer? selectedOfficer;
  final List<SubordinateOffice> parentOffices;
  final Function(int, int, int) onSelect;
  final Function(int, bool) officeExpansionChanged;
  final Function(int, int, bool) branchExpansionChanged;

  const SubordinateOfficeList({
    required this.onSelect,
    required this.parentOffices,
    required this.isMultiSelect,
    required this.selectedOfficer,
    required this.officeExpansionChanged,
    required this.branchExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: parentOffices.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: _officeItemCard,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _officeItemCard(BuildContext context, int pIndex) {
    var office = parentOffices[pIndex];
    var officeName = office.label ?? '';
    var subOffices = office.branchOffices;
    return Expansion(
      title: _header(officeName),
      childrenPadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      initiallyExpanded: office.isExpanded ?? false,
      tilePadding: const EdgeInsets.symmetric(vertical: 4),
      onExpansionChanged: subOffices.haveList ? null : (isExpanded) => officeExpansionChanged(pIndex, isExpanded),
      children:
          !subOffices.haveList ? [] : subOffices!.asMap().entries.map((entry) => _branchItemCard(context, pIndex, entry.key)).toList(),
    );
  }

  Widget _branchItemCard(BuildContext context, int oIndex, int bIndex) {
    var office = parentOffices[oIndex].branchOffices![bIndex];
    var officeName = office.label ?? '';
    var officers = office.officers;
    return Expansion(
      childrenPadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(vertical: 4),
      title: Padding(padding: const EdgeInsets.only(left: 10), child: _header(officeName)),
      onExpansionChanged: officers.haveList ? null : (isExpanded) => branchExpansionChanged(oIndex, bIndex, isExpanded),
      children: !officers.haveList ? [] : office.officers!.asMap().entries.map((entry) => _itemCard(oIndex, bIndex, entry.key)).toList(),
    );
  }

  Widget _header(String officeName) {
    var style = sl<TextStyles>().text16_400(primary);
    return Container(padding: EdgeInsets.zero, child: Text(officeName, style: style, maxLines: 1, overflow: TextOverflow.ellipsis));
  }

  Widget _itemCard(int oIndex, int bIndex, int cIndex) {
    var officer = parentOffices[oIndex].branchOffices![bIndex].officers![cIndex];
    var multiSelected = officer.selected != null && officer.selected!;
    var singleSelected =
        selectedOfficer != null && selectedOfficer!.id == officer.id && selectedOfficer!.officeUnitId == officer.officeUnitId;
    var selected = !isMultiSelect ? singleSelected : multiSelected;
    var checked = const Icon(Icons.check_box, color: primary, size: 18);
    var check = const Icon(Icons.check_box_outline_blank, color: grey80, size: 18);
    var icon = selected ? checked : check;
    var label = Text(officer.label ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black));
    return InkWell(
      onTap: () => onSelect(oIndex, bIndex, cIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 20),
        child: Row(children: [icon, const SizedBox(width: 10), Expanded(child: label)]),
      ),
    );
  }
}
