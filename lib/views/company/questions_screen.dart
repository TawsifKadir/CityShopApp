import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/company/question_list.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/dummy/resource.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/company/questions_view_model.dart';

class QuestionsScreen extends StatefulWidget {
  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  var viewModel = QuestionsViewModel();
  var modelData = QuestionsViewModel();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<QuestionsViewModel>(context, listen: false);
    modelData = Provider.of<QuestionsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Frequently Asked Questions'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      body: Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
    );
  }

  Widget _mobileView(BuildContext context) => FrequentQuestionList(frequentQuestionList: frequentQuestionsData);
}
