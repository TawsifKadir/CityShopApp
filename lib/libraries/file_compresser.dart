import 'dart:io';

import 'package:flutter_image_compress/flutter_image_compress.dart';

class FileCompressor {
  Future<File?> compressImageFile(File file) async {
    var filePath = file.absolute.path;
    // if (kDebugMode) print(file.path);
    var lastIndex = filePath.lastIndexOf(RegExp('.jp'));
    var splitPath = filePath.substring(0, lastIndex);
    var targetPath = '${splitPath}_target${filePath.substring(lastIndex)}';
    var compressedFile = await FlutterImageCompress.compressAndGetFile(file.absolute.path, targetPath, quality: 3);
    // File? compressedFile = await FlutterImageCompress.compressAndGetFile(filePath, targetPath, quality: 3);
    // if (kDebugMode) print(file.lengthSync());
    // if (kDebugMode) print(compressedFile?.lengthSync());
    return File(compressedFile!.path);
    // return compressedFile!;
  }
}
