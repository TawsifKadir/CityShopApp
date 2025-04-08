import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class District {
  int? division;
  String? bbsCode;
  int? district;
  String? name;
  String? nameBn;
  int? id;

  String get label => sl<StorageService>().getLanguage == 'bn' ? nameBn ?? '' : name ?? '';

  District({this.division, this.bbsCode, this.district, this.name, this.nameBn, this.id});

  District.fromJson(json) {
    division = json['division'];
    bbsCode = json['bbsCode'];
    district = json['district'];
    name = json['name'];
    nameBn = json['nameBn'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['division'] = division;
    map['bbsCode'] = bbsCode;
    map['district'] = district;
    map['name'] = name;
    map['nameBn'] = nameBn;
    map['id'] = id;
    return map;
  }
}
