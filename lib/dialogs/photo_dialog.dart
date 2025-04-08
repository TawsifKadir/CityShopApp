import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/image_memory.dart';
import 'package:grs/core_widgets/pop_scope_navigator.dart';
import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/number_ext.dart';
import 'package:grs/library_widgets/online_image.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/assets.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/utils/transitions.dart';

Future<void> photoDialog({required ImageType type, required String path}) async {
  final context = navigatorKey.currentState!.context;
  await showGeneralDialog(
    context: context,
    barrierDismissible: true,
    barrierLabel: 'Photo Dialog',
    transitionDuration: dialogDuration,
    transitionBuilder: sl<Transitions>().fadeTransaction,
    pageBuilder: (context, anim1, anim2) => PopScopeNavigator(
      canPop: true,
      child: Align(child: _PhotoDialogView(path, type)),
    ),
  );
}

class _PhotoDialogView extends StatelessWidget {
  final String imagePath;
  final ImageType imageType;

  const _PhotoDialogView(this.imagePath, this.imageType);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90.width,
      height: 90.width,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(16),
      child: Material(
        color: transparent,
        borderOnForeground: false,
        clipBehavior: Clip.antiAlias,
        child: imageType == ImageType.memory ? _memoryImage() : _networkImage(),
      ),
    );
  }

  Widget _memoryImage() {
    var size = 85.width;
    var dummyImage = Image.asset(Assets.image, width: 60.width, fit: BoxFit.contain);
    return ImageMemory(radius: 10, size: size, imagePath: base64.decode(imagePath), errorWidget: dummyImage);
  }

  Widget _networkImage() {
    var size = 85.width;
    var dummyImage = Image.asset(Assets.image, width: 60.width, fit: BoxFit.contain);
    return OnlineImage(radius: 10, width: size, image: imagePath, errorWidget: dummyImage);
  }
}
