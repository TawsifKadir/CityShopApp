import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Office {
  int? id;
  String? nameBn;
  String? name;
  String? code;
  int? division;
  int? district;
  int? upazila;
  String? phone;
  String? mobile;
  String? digitalNothiCode;
  String? fax;
  String? email;
  String? website;
  int? ministry;
  int? layer;
  int? origin;
  int? customLayer;
  int? parentOfficeId;

  Office({
    this.id,
    this.nameBn,
    this.name,
    this.code,
    this.division,
    this.district,
    this.upazila,
    this.phone,
    this.mobile,
    this.digitalNothiCode,
    this.fax,
    this.email,
    this.website,
    this.ministry,
    this.layer,
    this.origin,
    this.customLayer,
    this.parentOfficeId,
  });

  String get office_name => sl<StorageService>().getLanguage == 'bn' ? nameBn ?? '' : name ?? '';

  Office.fromJson(json) {
    id = json['id'];
    nameBn = json['nameBn'];
    name = json['name'];
    code = json['code'];
    division = json['division'];
    district = json['district'];
    upazila = json['upazila'];
    phone = json['phone'];
    mobile = json['mobile'];
    digitalNothiCode = json['digitalNothiCode'];
    fax = json['fax'];
    email = json['email'];
    website = json['website'];
    ministry = json['ministry'];
    layer = json['layer'];
    origin = json['origin'];
    customLayer = json['customLayer'];
    parentOfficeId = json['parentOfficeId'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['nameBn'] = nameBn;
    map['name'] = name;
    map['code'] = code;
    map['division'] = division;
    map['district'] = district;
    map['upazila'] = upazila;
    map['phone'] = phone;
    map['mobile'] = mobile;
    map['digitalNothiCode'] = digitalNothiCode;
    map['fax'] = fax;
    map['email'] = email;
    map['website'] = website;
    map['ministry'] = ministry;
    map['layer'] = layer;
    map['origin'] = origin;
    map['customLayer'] = customLayer;
    map['parentOfficeId'] = parentOfficeId;
    return map;
  }
}
