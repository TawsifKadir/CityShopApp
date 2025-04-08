import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/expansion.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/branch/branch_office.dart';
import 'package:grs/models/branch/officer.dart';
import 'package:grs/utils/text_styles.dart';

class OfficersExpansionTileList extends StatelessWidget {
  final bool isMultiSelect;
  final Officer? selectedOfficer;
  final List<BranchOffice> officeList;
  final Function(int, int) onSelect;
  final Function(int, bool) onExpansionChanged;

  const OfficersExpansionTileList({
    required this.onSelect,
    required this.officeList,
    required this.isMultiSelect,
    required this.selectedOfficer,
    required this.onExpansionChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemCount: officeList.length,
      clipBehavior: Clip.antiAlias,
      itemBuilder: _expansionItemCard,
      physics: const BouncingScrollPhysics(),
    );
  }

  Widget _expansionItemCard(BuildContext context, int index) {
    var office = officeList[index];
    return Expansion(
      title: _header(office),
      childrenPadding: EdgeInsets.zero,
      expandedAlignment: Alignment.centerLeft,
      tilePadding: const EdgeInsets.symmetric(vertical: 4),
      onExpansionChanged: (isExpanded) => onExpansionChanged(index, isExpanded),
      children: !office.officers.haveList ? [] : office.officers!.asMap().entries.map((entry) => _itemCard(index, entry.key)).toList(),
    );
  }

  Widget _header(BranchOffice office) {
    var label = Text(office.label ?? '', style: sl<TextStyles>().text16_400(primary));
    return Container(padding: EdgeInsets.zero, child: label);
  }

  Widget _itemCard(int parentIndex, int childIndex) {
    var officer = officeList[parentIndex].officers![childIndex];
    var multiSelected = officer.selected != null && officer.selected!;
    var singleSelected =
        selectedOfficer != null && selectedOfficer!.id == officer.id && selectedOfficer!.officeUnitId == officer.officeUnitId;
    var selected = !isMultiSelect ? singleSelected : multiSelected;
    var checked = const Icon(Icons.check_box, color: primary, size: 18);
    var check = const Icon(Icons.check_box_outline_blank, color: grey80, size: 18);
    var icon = selected ? checked : check;
    var label = Text(officer.label ?? '', maxLines: 2, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text16_400(black));
    return InkWell(
      onTap: () => onSelect(parentIndex, childIndex),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
        child: Row(children: [icon, const SizedBox(width: 10), Expanded(child: label)]),
      ),
    );
  }
}

/*return ListTileTheme.merge(
      minVerticalPadding: 0,
      contentPadding: EdgeInsets.zero,
      child: ExpansionTile(
        iconColor: primary,
        shape: const Border(),
        collapsedIconColor: grey80,
        tilePadding: EdgeInsets.zero,
        childrenPadding: EdgeInsets.zero,
        expandedAlignment: Alignment.centerLeft,
        title: _header(context, item['title'] ?? ''),
        onExpansionChanged: (isExpanded) => onExpansionChanged(index, isExpanded),
        children: officers.map((item) => _itemCard(context, item)).toList(),
      ),
    );*/
