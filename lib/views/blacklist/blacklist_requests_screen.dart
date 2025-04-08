import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/blacklist/blacklist_listview.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/blacklist/blacklist_requests_view_model.dart';

class BlacklistRequestScreen extends StatefulWidget {
  @override
  State<BlacklistRequestScreen> createState() => _BlacklistRequestScreenState();
}

class _BlacklistRequestScreenState extends State<BlacklistRequestScreen> {
  var viewModel = BlacklistRequestsViewModel();
  var modelData = BlacklistRequestsViewModel();
  var scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<BlacklistRequestsViewModel>(context, listen: false);
    modelData = Provider.of<BlacklistRequestsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Blacklist Requests'.translate),
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
    if (modelData.loader.initial) return const SizedBox.shrink();
    // var blacklists = modelData.blacklists;
    if (!modelData.loader.common && !modelData.blacklists.haveList) return const Center(child: NoDataFound(pref: NoDataPref.blacklist));
    return BlackListListview(
      blacklists: modelData.blacklists,
      onChanged: (data, index) {},
      scrollController: scrollController,
      pref: BlackListPref.requested_blacklist,
    );
  }
}
