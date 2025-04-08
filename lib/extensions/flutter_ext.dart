import 'package:flutter/material.dart';

import 'package:grs/utils/keys.dart';

extension FlutterExtensions on void {
  Future<void> minimizeKeyboard() async {
    var context = navigatorKey.currentState?.context;
    if (context == null) return Future.value();
    var keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;
    if (keyboardOpen) FocusScope.of(context).unfocus();
    // if (keyboardOpen) FocusScope.of(context).requestFocus(FocusNode());
  }
}
