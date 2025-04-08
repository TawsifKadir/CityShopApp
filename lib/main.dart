import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:grs/constants/storage_keys.dart';
import 'package:grs/provider/providers.dart';
import 'package:grs/screen_craft.dart';
import 'package:grs/service/http_overrides.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/views/grievance_redress_app.dart';
import 'package:provider/provider.dart';

import 'di.dart' as dependency_injection;

/// flutter build appbundle --release
/// flutter build apk --split-per-abi
/// flutter pub run import_sorter:main lib

// keytool -list -v -keystore /Users/md.tanviranwarrafi/RafiTanvir/projects/freelanceing/grs_officer/android_key/grs_app.jks -alias key

Future<void> main() async {
  await dependency_injection.init();
  await initApp();
  await Future.delayed(const Duration(microseconds: 1200));
  runApp(_runApp());
}

Widget screenCraft() => ScreenCraft(builder: (context, orientation) => GrievanceRedressApp());

Future<void> initApp() async {
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await portraitMode();
}

EasyLocalization _runApp() {
  return EasyLocalization(
    useOnlyLangCode: true,
    path: 'assets/languages',
    useFallbackTranslations: true,
    fallbackLocale: const Locale('bn'),
    supportedLocales: const [Locale('bn'), Locale('en')],
    startLocale: Locale(GetStorage().read(LANGUAGE_CODE) ?? 'bn'),
    child: MultiProvider(providers: providers, child: DismissKeyboard(child: screenCraft())),
  );
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  DismissKeyboard({required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Dismiss the keyboard when tapping outside a text field
        FocusScope.of(context).unfocus();
      },
      child: FocusScope(
        node: FocusScopeNode(),
        child: child,
      ),
    );
  }
}