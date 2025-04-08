import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/complain/complain_list.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain/my_complains_view_model.dart';

class MyComplainsScreen extends StatefulWidget {
  @override
  State<MyComplainsScreen> createState() => _MyComplainsScreenState();
}

class _MyComplainsScreenState extends State<MyComplainsScreen> {
  var viewModel = MyComplainsViewModel();
  var modelData = MyComplainsViewModel();
  var scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.initViewModel();
      viewModel.checkPagination(scrollController);
    });
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<MyComplainsViewModel>(context, listen: false);
    modelData = Provider.of<MyComplainsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('My Complains'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
          if (modelData.loader.common) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    // var complains = modelData.complainList;
    var label = 'LIST OF COMPLAINTS YOU HAVE FILED'.translate;
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    return CustomRefreshContainer(
      onRefresh: () async {
        await viewModel.refreshUserComplains();
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (modelData.complainList.haveList) Padding(padding: padding, child: Text(label, style: sl<TextStyles>().text16_500(primary))),
          const SizedBox(height: 20),
          Expanded(child: _complainList(context)),
        ],
      ),
    );
  }

  Widget _complainList(BuildContext context) {
    if (modelData.loader.initial) return const SizedBox.shrink();
    if (!modelData.loader.common && !modelData.complainList.haveList) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    return ComplainList(pref: ComplainListPref.my_regular_complain, complainList: modelData.complainList, scrollController: scrollController);
  }
}
