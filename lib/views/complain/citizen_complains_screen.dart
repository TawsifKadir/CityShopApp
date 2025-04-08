import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/hamburger_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/app_menus/profile_image_menu.dart';
import 'package:grs/components/list_views/complain/citizen_complain_list.dart';
import 'package:grs/components/ui_widgets/add_complain_button.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/dialogs/app_exit_dialog.dart';
import 'package:grs/drawers/app_drawer.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/complain/citizen_complains_view_model.dart';
import 'package:grs/view_models/global_view_model.dart';

class CitizenComplainsScreen extends StatefulWidget {
  @override
  State<CitizenComplainsScreen> createState() => _CitizenComplainsScreenState();
}

class _CitizenComplainsScreenState extends State<CitizenComplainsScreen> with SingleTickerProviderStateMixin {
  var viewModel = CitizenComplainsViewModel();
  var modelData = CitizenComplainsViewModel();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SizeConfig.initMediaQuery(context);
    viewModel = Provider.of<CitizenComplainsViewModel>(context, listen: false);
    modelData = Provider.of<CitizenComplainsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = SizeConfig.width;
    var height = SizeConfig.height;
    var width16 = const SizedBox(width: 16);
    var label = Text('All Complains'.translate);
    var hamburger = HamburgerMenu(color: black, scaffoldKey: scaffoldKey);
    var actions = [Center(child: LanguageMenu()), width16, ProfileImageMenu(), const SizedBox(width: appbarAction)];
    var responsive = Responsive(mobile: _mobileView(context));
    var logoutLoader = Provider.of<GlobalViewModel>(context).logoutLoader;
    var allLoader = modelData.loader.initial || modelData.loader.common;
    var screenLoader = modelData.loader.common || logoutLoader;
    return PopScopeNavigator(
      canPop: false,
      onPop: appExitDialog,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(menuScroll: null),
        resizeToAvoidBottomInset: false,
        appBar: AppBar(centerTitle: false, automaticallyImplyLeading: false, title: label, leading: hamburger, actions: actions),
        floatingActionButton: modelData.loader.initial ? const SizedBox.shrink() : AddComplainButton(loader: allLoader),
        body: Stack(children: [Container(width: width, height: height, child: responsive), if (screenLoader) ScreenLoader()]),
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    if (modelData.loader.initial) return const SizedBox.shrink();
    if (modelData.complainList.length < 1) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    // var complains = sl<SortHelper>().sortComplainByDate(modelData.complainList);
    return CustomRefreshContainer(
        onRefresh: () async {
          await viewModel.refreshComplains();
        },
        child: CitizenComplainList(complainList: modelData.complainList)
    );
  }
}
