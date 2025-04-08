import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import 'package:grs/constants/data_constants.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/dummy/proof_file.dart';
import 'package:grs/models/dummy/signature_file.dart';
import 'package:grs/service/image_service.dart';
import 'package:grs/utils/assets.dart';

class FileHelper {
  String getFileType(String? path) {
    if (path == null) return '';
    final index = path.lastIndexOf('.');
    if (index < 0 || index + 1 >= path.length) return path;
    return path.substring(index + 1).toLower;
  }

  String getFileBasedIcon(String? path) {
    if (path == null) return Assets.file_outline;
    var fileType = getFileType(path).toLower;
    if (fileType == 'png' || fileType == 'jpg' || fileType == 'jpeg' || fileType == 'bmp') {
      return Assets.image_outline;
    } else if (fileType == 'doc' || fileType == 'docx' || fileType == 'pdf' || fileType == 'xls' || fileType == 'xlsx') {
      return Assets.file_outline;
    } else if (fileType == 'mp3') {
      return Assets.speaker_outline;
    } else if (fileType == '3gp' || fileType == 'mp4' || fileType == 'flv' || fileType == 'avi') {
      return Assets.youtube_outline;
    } else if (fileType == 'zip' || fileType == 'rar') {
      return Assets.archive_outline;
    } else {
      return Assets.file_outline;
    }
  }

  Future<bool> isLargeFile(File file) async {
    int fileSizeInBytes = await file.length();
    double fileSizeInMB = fileSizeInBytes / (1024 * 1024);
    return fileSizeInMB > 10;
  }

  bool isDuplicateFile(List<ProofFile> proofFiles, File file) {
    int count = 0;
    proofFiles.forEach((item) => item.file.path == file.path ? count = count + 1 : null);
    return count > 1;
  }

  bool isDuplicateFile2(List<SignatureFile> signatureFiles, File file) {
    int count = 0;
    signatureFiles.forEach((item) => item.file.path == file.path ? count = count + 1 : null);
    return count > 1;
  }

  Future<List<ProofFile>> renderFilesInModel(List<File> files) async {
    List<ProofFile> proofFiles = [];
    if (!files.haveList) return proofFiles;
    for (File item in files) {
      var fileType = getFileType(item.path);
      var isValid = FILE_EXTENSIONS.contains(fileType);
      var isLarge = await isLargeFile(item);
      var unit8list = await sl<ImageService>().fileToUnit8List(item);
      var b64 = base64.encode(unit8list!);
      var name = TextEditingController();
      var sizeInBytes = await item.length();
      proofFiles.add(
        ProofFile(file: item, isLarge: isLarge, base64: b64, isValid: isValid, unit8List: unit8list, name: name, size: sizeInBytes),
      );
    }
    return proofFiles;
  }

  Future<List<SignatureFile>> renderFilesInModel2(List<File> files) async {
    List<SignatureFile> signatureFiles = [];
    if (!files.haveList) return signatureFiles;
    for (File item in files) {
      var fileType = getFileType(item.path);
      var isValid = FILE_EXTENSIONS.contains(fileType);
      var isLarge = await isLargeFile(item);
      var unit8list = await sl<ImageService>().fileToUnit8List(item);
      var b64 = base64.encode(unit8list!);
      var name = TextEditingController();
      var sizeInBytes = await item.length();
      signatureFiles.add(
        SignatureFile(file: item, isLarge: isLarge, base64: b64, isValid: isValid, unit8List: unit8list, name: name, size: sizeInBytes),
      );
    }
    return signatureFiles;
  }
}
