import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/appeal/appeal_menu_list.dart';
import 'package:grs/components/list_views/complain/complain_list.dart';
import 'package:grs/components/ui_widgets/no_data_found.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/sort_helper.dart';
import 'package:grs/library_widgets/svg_image.dart';
import 'package:grs/service/validators.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/view_models/complain/appeal_complains_view_model.dart';

import '../../components/dropdowns/page_dropdown.dart';

class AppealComplainsScreen extends StatefulWidget {
  final int index;
  const AppealComplainsScreen({required this.index});

  @override
  State<AppealComplainsScreen> createState() => _AppealComplainsScreenState();
}

class _AppealComplainsScreenState extends State<AppealComplainsScreen> {
  var viewModel = AppealComplainsViewModel();
  var modelData = AppealComplainsViewModel();
  var menuScroll = ScrollController();
  var appealScroll = ScrollController();
  var search = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel(widget.index, menuScroll));
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<AppealComplainsViewModel>(context, listen: false);
    modelData = Provider.of<AppealComplainsViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    search.dispose();
    appealScroll.dispose();
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
        title: Text('Appeal Management'.translate),
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
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var complains = modelData.appealMenus[modelData.menuIndex].complains;
    return Stack(
      children: [
        CustomRefreshContainer(
          onRefresh: () async {
            await viewModel.refreshAppealComplains();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              if (complains.haveList) Padding(padding: padding, child: _searchBox(context)),
              if (complains.haveList) const SizedBox(height: 16),
              AppealMenuList(scrollController: menuScroll, menuIndex: modelData.menuIndex, onTap: (index) => viewModel.selectMenu(index)),
              const SizedBox(height: 16),
              Expanded(child: _complainList(context)),
            ],
          ),
        ),
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
      ]
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
    var complains = modelData.appealMenus[modelData.menuIndex].complains;
    if (!modelData.loader.common && !complains.haveList) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    var filteredComplains = sl<SortHelper>().sortComplainId(complains);
    if (!filteredComplains.haveList) return const Center(child: NoDataFound(pref: NoDataPref.complains));
    var pref = ComplainListPref.appeal_regular;
    var menu = modelData.appealMenus[modelData.menuIndex].value;
    return ComplainList(menu: menu, pref: pref, complainList: filteredComplains, scrollController: appealScroll);
  }
}
