import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class DivitionalOffice {
  int? id;
  String? name;
  int? layerLevel;
  String? nameEn;

  DivitionalOffice({this.id, this.name, this.layerLevel, this.nameEn});

  DivitionalOffice.fromJson(json) {
    id = json['id'];
    name = json['name'];
    layerLevel = json['layer_level'];
    nameEn = json['name_en'];
  }

  String get office_name => sl<StorageService>().getLanguage == 'bn' ? name ?? '' : nameEn ?? '';

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['layer_level'] = layerLevel;
    map['name_en'] = nameEn;
    return map;
  }
}
