import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';
import 'package:grs/components/dropdowns/page_dropdown.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/hamburger_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/app_menus/profile_image_menu.dart';
import 'package:grs/components/list_views/complain/complain_list.dart';
import 'package:grs/components/list_views/complain/complain_menu_list.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/app_exit_dialog.dart';
import 'package:grs/drawers/app_drawer.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/complain_helper.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/service/validators.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/complain/officer_complains_view_model.dart';
import 'package:grs/view_models/global_view_model.dart';

class OfficerComplainsScreen extends StatefulWidget {
  @override
  State<OfficerComplainsScreen> createState() => _OfficerComplainsScreenState();
}

class _OfficerComplainsScreenState extends State<OfficerComplainsScreen> with SingleTickerProviderStateMixin {
  var viewModel = OfficerComplainsViewModel();
  var modelData = OfficerComplainsViewModel();
  var menuScroll = ScrollController();
  var complainScroll = ScrollController();
  var search = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SizeConfig.initMediaQuery(context);
    viewModel = Provider.of<OfficerComplainsViewModel>(context, listen: false);
    modelData = Provider.of<OfficerComplainsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var authStatus = sl<AuthService>().authStatus;
    var logoutLoader = Provider.of<GlobalViewModel>(context).logoutLoader;
    var screenLoader = modelData.loader.common || logoutLoader;
    return PopScopeNavigator(
      canPop: false,
      onPop: appExitDialog,
      child: Scaffold(
        key: scaffoldKey,
        resizeToAvoidBottomInset: false,
        drawer: AppDrawer(menuScroll: menuScroll),
        appBar: AppBar(
          centerTitle: false,
          automaticallyImplyLeading: false,
          title: Text('All Grievance List'.translate),
          leading: HamburgerMenu(color: black, scaffoldKey: scaffoldKey),
          actions: [
            Center(child: LanguageMenu()),
            const SizedBox(width: 16),
            authStatus ? ProfileImageMenu() : Center(child: _signInAppbarButton(context)),
            const SizedBox(width: appbarAction),
          ],
        ),
        body: Stack(
          clipBehavior: Clip.antiAlias,
          children: [
            Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
            if (screenLoader) ScreenLoader(),
          ],
        ),
      ),
    );
  }

  Widget _signInAppbarButton(BuildContext context) {
    var minSize = const Size(50, 34);
    var maxSize = const Size(double.infinity, 34);
    var side = const BorderSide(color: grey80);
    var textStyle = sl<TextStyles>().text14_500(grey80);
    return OutlinedButton(
      child: Text('Sign in'.translate),
      onPressed: sl<Routes>().signInScreen().push,
      style: OutlinedButton.styleFrom(minimumSize: minSize, maximumSize: maxSize, side: side, textStyle: textStyle),
    );
  }

  Widget _mobileView(BuildContext context) {
    if (modelData.loader.initial) return const SizedBox.shrink();
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var complains = modelData.complainMenus[modelData.menuIndex].complains;
    return Stack(
      children: [
        CustomRefreshContainer(
          onRefresh: () async {
            await viewModel.refreshAllComplains();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              ComplainMenuList(
                scrollController: menuScroll,
                menuIndex: modelData.menuIndex,
                onTap: (index) => viewModel.selectMenu(index),
              ),
              const SizedBox(height: 16),
              if (complains.haveList) Padding(padding: padding, child: _searchBox(context)),
              if (complains.haveList) const SizedBox(height: 16),
              Expanded(child: _complainList(context)),
            ],
          ),
        ),
        // Adding dropdown in the bottom right corner
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 24, right: 24), // Adjust padding to position the dropdown
            child: Container(
                width: 64,
                child: PageDropdown(
                    selectedPage: modelData.currentPage,
                    pageCount: modelData.totalPages ?? 1,
                    onChanged: (page) {
                      (page != modelData.currentPage) ? viewModel.setCurrentPage(page): null;
                    }
                )
            ),
          ),
        ),
      ],
    );
  }

  Widget _searchBox(BuildContext context) {
    var searchIcon = SvgImage(image: Assets.search, height: 24, color: grey);
    return ModifiedTextField(
      controller: search,
      hintText: 'Search grievance'.translate,
      onChanged: (val) => setState(() {}),
      validator: (val) => sl<Validators>().pinNumber(pin: val!),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 15),
      prefixIcon: Container(width: 30, alignment: Alignment.center, child: searchIcon),
    );
  }

  Widget _complainList(BuildContext context) {
    if (modelData.loader.initial) return const SizedBox.shrink();
    var complains = modelData.complainMenus[modelData.menuIndex].complains;
    if (!modelData.loader.common && !complains.haveList) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    var filteredComplains = sl<ComplainHelper>().filterComplains(complains, search.text);
    if (!filteredComplains.haveList) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    var pref = ComplainListPref.complain_regular;
    var menu = modelData.complainMenus[modelData.menuIndex].value;
    return ComplainList(menu: menu, pref: pref, complainList: filteredComplains, scrollController: complainScroll);
  }
}
