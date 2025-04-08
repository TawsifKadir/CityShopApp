import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/fonts.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/text_styles.dart';

ThemeData lightTheme() {
  return ThemeData(
    useMaterial3: false,
    fontFamily: poppins,
    primaryColor: primary,
    dividerColor: grey40,
    disabledColor: disabled,
    hintColor: grey80,
    indicatorColor: primary,
    primarySwatch: Colors.indigo,
    splashColor: transparent,
    focusColor: transparent,
    hoverColor: transparent,
    highlightColor: transparent,
    scaffoldBackgroundColor: white,
    brightness: Brightness.light,
    visualDensity: VisualDensity.comfortable,
    textTheme: _textThemeLight,
    dividerTheme: _dividerThemeLight,
    primaryIconTheme: _primaryIconThemeLight,
    drawerTheme: _drawerThemeLight,
    dialogTheme: _dialogThemeLight,
    bottomSheetTheme: _bottomSheetThemeLight,
    tabBarTheme: _tabBarThemeLight,
    appBarTheme: _appBarThemeLight,
    cardTheme: _cardThemeLight,
    chipTheme: _chipThemeLight,
    bottomAppBarTheme: _bottomAppBarThemeLight,
    bottomNavigationBarTheme: bottomNavigationBarThemeLight,
    buttonTheme: _buttonThemeLight,
    floatingActionButtonTheme: _floatingActionButtonThemeLight,
    elevatedButtonTheme: ElevatedButtonThemeData(style: _elevatedButtonStyleLight),
    outlinedButtonTheme: OutlinedButtonThemeData(style: _outlineButtonStyleLight),
    colorScheme: const ColorScheme.light(
      primary: pink,          // Main buttons
      secondary: pink,        // FABs, selection controls
      onSurface: black,       // Regular text color
      surfaceVariant: white,
      secondaryContainer: pink,
      onSecondaryContainer: white,
    ),
  );
}

TextTheme get _textThemeLight => TextTheme(labelLarge: sl<TextStyles>().text18_500(white));
DividerThemeData get _dividerThemeLight => const DividerThemeData(color: grey40, thickness: 1);
IconThemeData get _primaryIconThemeLight => const IconThemeData(color: black, size: 24);

DrawerThemeData get _drawerThemeLight => DrawerThemeData(elevation: 0, backgroundColor: white, scrimColor: popupBearer, width: drawerWidth);
DialogTheme get _dialogThemeLight {
  return DialogTheme(
    elevation: 2,
    iconColor: black,
    backgroundColor: white,
    alignment: Alignment.topCenter,
    titleTextStyle: sl<TextStyles>().text20_600(black),
    contentTextStyle: sl<TextStyles>().text14_400(black),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
  );
}

CardTheme get _cardThemeLight {
  return CardTheme(
    elevation: 1,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
    color: white,
    margin: EdgeInsets.zero,
  );
}

ChipThemeData get _chipThemeLight {
  return ChipThemeData(
    backgroundColor: white,
    selectedColor: pink,
    disabledColor: grey80,
    labelStyle: sl<TextStyles>().text14_500(black),
    secondaryLabelStyle: sl<TextStyles>().text14_500(white),
    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: black),
      borderRadius: BorderRadius.circular(8),
    ),
    elevation: 0
  );
}

BottomSheetThemeData get _bottomSheetThemeLight {
  var radius = const Radius.circular(10);
  return BottomSheetThemeData(
    elevation: 5,
    modalElevation: 5,
    backgroundColor: white,
    modalBackgroundColor: white,
    clipBehavior: Clip.antiAliasWithSaveLayer,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.only(topLeft: radius, topRight: radius)),
  );
}

TabBarTheme get _tabBarThemeLight => TabBarTheme(
      labelColor: black,
      indicatorColor: primary,
      unselectedLabelColor: grey80,
      indicatorSize: TabBarIndicatorSize.tab,
      labelStyle: sl<TextStyles>().text16_500(black),
      labelPadding: const EdgeInsets.symmetric(horizontal: 10),
      unselectedLabelStyle: sl<TextStyles>().text16_500(grey80),
      indicator: const UnderlineTabIndicator(borderSide: BorderSide(color: primary, width: 2)),
    );

AppBarTheme get _appBarThemeLight {
  return AppBarTheme(
    elevation: 0,
    titleSpacing: 16,
    centerTitle: true,
    backgroundColor: white,
    systemOverlayStyle: overlayStyle,
    titleTextStyle: sl<TextStyles>().text18_500(black),
    toolbarTextStyle: sl<TextStyles>().text18_500(black),
    iconTheme: const IconThemeData(color: black, size: 24),
    actionsIconTheme: const IconThemeData(color: black, size: 24),
    toolbarHeight: 13.5.widthRatio,
  );
}

BottomAppBarTheme get _bottomAppBarThemeLight => const BottomAppBarTheme(color: primary, elevation: 3);

BottomNavigationBarThemeData get bottomNavigationBarThemeLight {
  return BottomNavigationBarThemeData(
    elevation: 3,
    backgroundColor: white,
    showUnselectedLabels: true,
    showSelectedLabels: true,
    type: BottomNavigationBarType.fixed,
    selectedLabelStyle: sl<TextStyles>().text12_500(pink),
    unselectedLabelStyle: sl<TextStyles>().text12_500(black),
    landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
    selectedIconTheme: const IconThemeData(size: 24, color: pink),
    unselectedIconTheme: const IconThemeData(size: 24, color: black),
  );
}

ButtonThemeData get _buttonThemeLight {
  return ButtonThemeData(
    minWidth: 50,
    height: 52,
    disabledColor: red20,
    buttonColor: primary,
    focusColor: transparent,
    hoverColor: transparent,
    splashColor: transparent,
    highlightColor: transparent,
    // textTheme: ButtonTextTheme.accent,
    // layoutBehavior: ButtonBarLayoutBehavior.constrained,
    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
  );
}

FloatingActionButtonThemeData get _floatingActionButtonThemeLight {
  return FloatingActionButtonThemeData(
    iconSize: 24,
    backgroundColor: primary,
    foregroundColor: white,
    hoverColor: transparent,
    splashColor: transparent,
    focusColor: transparent,
    disabledElevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );
}

ButtonStyle get _elevatedButtonStyleLight {
  return ElevatedButton.styleFrom(
    elevation: 0.5,
    shadowColor: transparent,
    backgroundColor: primary,
    disabledBackgroundColor: primary.withOpacity(0.3),
    disabledForegroundColor: white,
    disabledMouseCursor: MouseCursor.defer,
    visualDensity: VisualDensity.comfortable,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    minimumSize: button52Large,
    maximumSize: button52Large,
    textStyle: sl<TextStyles>().text18_500(white),
    side: const BorderSide(color: transparent, width: 0),
    padding: const EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );
}

ButtonStyle get _outlineButtonStyleLight {
  return OutlinedButton.styleFrom(
    elevation: 0.5,
    shadowColor: transparent,
    backgroundColor: transparent,
    foregroundColor: grey80,
    disabledBackgroundColor: transparent,
    disabledForegroundColor: grey40,
    enabledMouseCursor: MouseCursor.uncontrolled,
    disabledMouseCursor: MouseCursor.defer,
    visualDensity: VisualDensity.comfortable,
    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    side: const BorderSide(color: grey60),
    textStyle: sl<TextStyles>().text18_500(grey80),
    minimumSize: button52Large,
    maximumSize: button52Large,
    padding: const EdgeInsets.symmetric(horizontal: 20),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
  );
}
