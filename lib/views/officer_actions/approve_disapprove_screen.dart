import 'package:flutter/material.dart';
import 'package:grs/components/ui_components/signature_files_view.dart';
import 'package:grs/view_models/component/signature_files_view_model.dart';

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
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/officer_actions/approve_disapprove_view_model.dart';

import '../../components/ui_components/attachment_view.dart';
import '../../components/ui_components/proof_files_view.dart';
import '../../utils/keys.dart';
import '../../view_models/component/proof_files_view_model.dart';

class ApproveDisapproveScreen extends StatefulWidget {
  final Complain complain;
  final ActionViewPref viewPref;
  final ActionTypePref typePref;

  const ApproveDisapproveScreen({required this.complain, required this.viewPref, required this.typePref});

  @override
  State<ApproveDisapproveScreen> createState() => _ApproveDisapproveScreenState();
}

class _ApproveDisapproveScreenState extends State<ApproveDisapproveScreen> {
  var viewModel = ApproveDisapproveViewModel();
  var modelData = ApproveDisapproveViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<ApproveDisapproveViewModel>(context, listen: false);
    modelData = Provider.of<ApproveDisapproveViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    var context = navigatorKey.currentState?.context;
    if (context == null) return;
    Provider.of<SignatureFilesViewModel>(context, listen: false).disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.symmetric(horizontal: 24);
    var responsive = Responsive(mobile: _mobileView(context));
    var signatureModel = Provider.of<SignatureFilesViewModel>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Agree/Disagree about Investigation Report'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      bottomNavigationBar: _bottomNavBar(context),
      body: Stack(
        children: [
          Container(width: SizeConfig.width, height: SizeConfig.height, padding: padding, child: responsive),
          if (modelData.loader || signatureModel.loader) ScreenLoader(),
        ],
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text('approve_disapprove_desc'.translate, style: sl<TextStyles>().text14_400(primary)),
          const SizedBox(height: 30),
          SignatureFilesView(),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _bottomNavBar(BuildContext context) {
    return ActionUiNavbar(
      outlineLabel: 'Agree',
      elevatedLabel: 'Disagree',
      loader: modelData.loader,
      outlineOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref, true),
      elevatedOnTap: () => viewModel.sendOnTap(widget.complain, widget.typePref, widget.viewPref, false),
    );
  }
}
