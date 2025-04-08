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
import 'package:grs/view_models/blacklist/blacklists_view_model.dart';

class BlacklistsScreen extends StatefulWidget {
  @override
  State<BlacklistsScreen> createState() => _BlacklistsScreenState();
}

class _BlacklistsScreenState extends State<BlacklistsScreen> {
  var viewModel = BlacklistsViewModel();
  var modelData = BlacklistsViewModel();
  var scrollController = ScrollController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<BlacklistsViewModel>(context, listen: false);
    modelData = Provider.of<BlacklistsViewModel>(context);
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
        title: Text('Blacklists'.translate),
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
        pref: BlackListPref.blacklist,
        scrollController: scrollController,
        onChanged: (data, index) => viewModel.changeBlacklistStatus(index),
    );
  }
}
