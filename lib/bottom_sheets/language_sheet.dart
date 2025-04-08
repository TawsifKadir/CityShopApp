import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/list_views/comp_list/language_list.dart';
import 'package:grs/components/ui_widgets/sheet_header.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/global_view_model.dart';

Future<void> languageBottomSheet() async {
  var context = navigatorKey.currentState!.context;
  await showModalBottomSheet(
    context: context,
    isDismissible: false,
    shape: bottomSheetShape,
    isScrollControlled: true,
    clipBehavior: Clip.antiAlias,
    builder: (builder) {
      return PopScopeNavigator(canPop: false, child: _LanguageSheetView());
    },
  );
}

class _LanguageSheetView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minWidth: double.infinity, minHeight: 30.height, maxHeight: 70.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SheetHeader(title: 'Change Language'.translate, closeOnTap: null),
          const SizedBox(height: 24),
          Padding(padding: EdgeInsets.symmetric(horizontal: screenPadding), child: _complainInfo(context)),
          const SizedBox(height: 24),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: screenPadding),
            child: ElevatedButton(onPressed: backToPrevious, child: Text('Close'.translate, style: sl<TextStyles>().text18_500(white))),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _complainInfo(BuildContext context) {
    var modelData = Provider.of<GlobalViewModel>(context);
    var viewmodel = Provider.of<GlobalViewModel>(context, listen: false);
    return LanguageList(selectedLanguage: modelData.language, onTap: (index) => viewmodel.selectLanguage(context, index));
  }
}
