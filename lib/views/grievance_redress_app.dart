import 'package:flutter/material.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:grs/views/component_demo_screen.dart';
import 'package:grs/views/home/home_screen.dart';
import 'package:provider/provider.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/themes/light_theme.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/view_models/global_view_model.dart';
import 'package:grs/views/complain/citizen_complains_screen.dart';
import 'package:grs/views/complain/officer_complains_screen.dart';
import 'package:grs/views/onboard/grs_onboard_screen.dart';

class GrievanceRedressApp extends StatefulWidget {
  @override
  State<GrievanceRedressApp> createState() => _GrievanceRedressAppState();
}

class _GrievanceRedressAppState extends State<GrievanceRedressApp> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var authStatus = sl<AuthService>().authStatus;
      Provider.of<GlobalViewModel>(context, listen: false).initViewModel();
      if (authStatus) sl<AuthService>().initStorageInLoginState();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: primary,
      theme: lightTheme(),
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: scaffoldMessengerKey,
      supportedLocales: context.supportedLocales,
      home: _getHomeRoute,
      navigatorKey: navigatorKey,
      title: 'Grievance Redress System',
      localizationsDelegates: context.localizationDelegates,
    );
  }

  Widget get _getHomeRoute {
    return const ComponentDemoScreen();
    // if (!sl<AuthService>().authStatus) {
    //   return GrsOnboardScreen();
    // } else {
    //   return sl<ProfileHelper>().isCitizen ? CitizenComplainsScreen() : OfficerComplainsScreen();
    // }
  }
}
