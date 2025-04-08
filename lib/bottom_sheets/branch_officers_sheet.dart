import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/ui_components/officers_expansion_tile_list.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/component/branch_officers_view_model.dart';

Future<void> branchOfficersBottomSheet({required bool isMultiSelect}) async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: PopScopeNavigator(canPop: false, child: _BranchOfficersSheetView(isMultiSelect)),
      );
    },
  );
}

class _BranchOfficersSheetView extends StatelessWidget {
  final bool isMultiSelect;
  const _BranchOfficersSheetView(this.isMultiSelect);

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var label = Text('Close'.translate, style: sl<TextStyles>().text18_500(white));
    return SizedBox(
      height: 65.height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Select officer'.translate, closeOnTap: backToPrevious),
          const SizedBox(height: 24),
          Expanded(child: Padding(padding: padding, child: _branchOfficersList(context))),
          const SizedBox(height: 32),
          Padding(padding: padding, child: ElevatedButton(onPressed: backToPrevious, child: label)),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _branchOfficersList(BuildContext context) {
    var modelData = Provider.of<BranchOfficersViewModel>(context);
    var viewmodel = Provider.of<BranchOfficersViewModel>(context, listen: false);
    if (!modelData.officeBranches.haveList) return const Center(child: NoDataFound(pref: NoDataPref.branch_officers));
    return OfficersExpansionTileList(
      isMultiSelect: isMultiSelect,
      selectedOfficer: modelData.selectedOfficer,
      officeList: modelData.officeBranches,
      onSelect: (pIndex, cIndex) => viewmodel.officerSelectionFromList(isMultiSelect, pIndex, cIndex),
      onExpansionChanged: (index, isExpanded) => viewmodel.expansionChanged(index),
    );
  }
}
