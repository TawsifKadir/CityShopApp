import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ProofFile {
  File file;
  bool isLarge;
  bool isValid;
  String base64;
  Uint8List unit8List;
  TextEditingController name;
  int size;

  ProofFile({
    required this.file,
    required this.isLarge,
    required this.base64,
    required this.isValid,
    required this.unit8List,
    required this.name,
    required this.size,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['file'] = file;
    map['base64'] = base64;
    map['isValid'] = isValid;
    map['is_large'] = isLarge;
    map['unit8List'] = unit8List;
    map['name'] = name.text;
    map['size'] = size;
    return map;
  }
}
