import 'package:grs/utils/assets.dart';

class Language {
  String name = 'English (US)';
  String code = 'en';
  String icon = 'assets/flags/us.png';

  Language({required this.name, required this.code, required this.icon});

  Language.fromJson(json) {
    name = json['name'];
    code = json['code'];
    icon = json['icon'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['name'] = name;
    map['code'] = code;
    map['icon'] = icon;
    return map;
  }
}

final List<Language> allLanguages = [
  Language(name: 'বাংলা', code: 'bn', icon: Assets.bd),
  Language(name: 'English', code: 'en', icon: Assets.us),
];
