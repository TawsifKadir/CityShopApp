import 'package:flutter/material.dart';
import 'package:grs/view_models/officer_actions/give_permission_view_model.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/ui_widgets/action_ui_navbar.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/modified_text_field.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/officer_actions/send_for_permission_view_model.dart';

class GivePermissionScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;
  const GivePermissionScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<GivePermissionScreen> createState() => _GivePermissionScreenState();
}

class _GivePermissionScreenState extends State<GivePermissionScreen> {
  var viewModel = GivePermissionViewModel();
  var modelData = GivePermissionViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<GivePermissionViewModel>(context, listen: false);
    modelData = Provider.of<GivePermissionViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Give Permission'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var hint = 'Write your note here'.translate;
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Text('Note for permission'.translate, style: sl<TextStyles>().text16_400(black)),
          const SizedBox(height: 6),
          ModifiedTextField(minLines: 06, maxLines: 12, controller: viewModel.note, hintText: hint),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      outlineLabel: 'Back',
      elevatedLabel: 'Send',
      loader: modelData.loader,
      outlineOnTap: backToPrevious,
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref),
    );
  }
}
