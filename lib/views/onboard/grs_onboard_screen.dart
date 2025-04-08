import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_menus/hamburger_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/ui_widgets/add_complain_button.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/dialogs/app_exit_dialog.dart';
import 'package:grs/drawers/app_drawer.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/extensions/route_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/service/routes.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/onboard/grs_onboard_view_model.dart';

class GrsOnboardScreen extends StatefulWidget {
  @override
  State<GrsOnboardScreen> createState() => _GrsOnboardScreenState();
}

class _GrsOnboardScreenState extends State<GrsOnboardScreen> with SingleTickerProviderStateMixin {
  var viewModel = GrsOnboardViewModel();
  var modelData = GrsOnboardViewModel();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    SizeConfig.initMediaQuery(context);
    viewModel = Provider.of<GrsOnboardViewModel>(context, listen: false);
    modelData = Provider.of<GrsOnboardViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var width = const SizedBox(width: 16);
    var hamburger = HamburgerMenu(color: black, scaffoldKey: scaffoldKey);
    var actions = [Center(child: LanguageMenu()), width, Center(child: _signInAppbarButton(context)), const SizedBox(width: appbarAction)];
    var appbar = AppBar(centerTitle: false, title: const Text(''), automaticallyImplyLeading: false, leading: hamburger, actions: actions);
    return PopScopeNavigator(
      canPop: false,
      onPop: appExitDialog,
      child: Scaffold(
        key: scaffoldKey,
        drawer: const AppDrawer(menuScroll: null),
        resizeToAvoidBottomInset: false,
        appBar: !SizeConfig.isMobile ? null : appbar,
        floatingActionButton: !SizeConfig.isMobile ? null : AddComplainButton(loader: false),
        body: Container(width: SizeConfig.width, height: SizeConfig.height, child: Responsive(mobile: _mobileView(context))),
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    var spanStyle = sl<TextStyles>().text16_500(primary);
    var regularStyle = sl<TextStyles>().text16_400(black);
    var recognizer = TapGestureRecognizer()..onTap = sl<Routes>().questionsScreen().push;
    var span = TextSpan(text: 'please click here...'.translate, style: spanStyle, recognizer: recognizer);
    var welcome = 'welcome_desc'.translate + ' ';
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 24),
          Center(child: Image.asset(Assets.grs_web_logo, width: 60.widthRatio)),
          const SizedBox(height: 24),
          RichText(textAlign: TextAlign.left, text: TextSpan(style: regularStyle, text: welcome, children: <TextSpan>[span])),
          const SizedBox(height: 32),
        ],
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
}
