import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Ministry {
  int? layerLevel;
  String? name;
  String? nameEn;

  Ministry({this.layerLevel, this.name, this.nameEn});

  String get ministry_name => sl<StorageService>().getLanguage == 'bn' ? name ?? '' : nameEn ?? '';

  Ministry.fromJson(json) {
    layerLevel = json['layer_level'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['layer_level'] = layerLevel;
    map['name'] = name;
    map['name_en'] = nameEn;
    return map;
  }
}
