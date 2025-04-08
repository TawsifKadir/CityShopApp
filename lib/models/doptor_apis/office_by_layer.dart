import 'package:grs/di.dart';
import 'package:grs/models/doptor_apis/layer.dart';
import 'package:grs/service/storage_service.dart';

class OfficeByLayer {
  int? id;
  String? officeNameBng;
  String? officeNameEng;
  int? geoDivisionId;
  int? geoDistrictId;
  int? geoUpazilaId;
  String? digitalNothiCode;
  String? officePhone;
  String? officeMobile;
  String? officeFax;
  String? officeEmail;
  String? officeWeb;
  int? officeMinistryId;
  int? officeLayerId;
  int? officeOriginId;
  int? customLayerId;
  int? parentOfficeId;
  Layer? officeLayer;

  OfficeByLayer({
    this.id,
    this.officeNameBng,
    this.officeNameEng,
    this.geoDivisionId,
    this.geoDistrictId,
    this.geoUpazilaId,
    this.digitalNothiCode,
    this.officePhone,
    this.officeMobile,
    this.officeFax,
    this.officeEmail,
    this.officeWeb,
    this.officeMinistryId,
    this.officeLayerId,
    this.officeOriginId,
    this.customLayerId,
    this.parentOfficeId,
    this.officeLayer,
  });

  String get office_name => sl<StorageService>().getLanguage == 'bn' ? officeNameBng ?? '' : officeNameEng ?? '';

  OfficeByLayer.fromJson(json) {
    id = json['id'];
    officeNameBng = json['office_name_bng'];
    officeNameEng = json['office_name_eng'];
    geoDivisionId = json['geo_division_id'];
    geoDistrictId = json['geo_district_id'];
    geoUpazilaId = json['geo_upazila_id'];
    digitalNothiCode = json['digital_nothi_code'];
    officePhone = json['office_phone'];
    officeMobile = json['office_mobile'];
    officeFax = json['office_fax'];
    officeEmail = json['office_email'];
    officeWeb = json['office_web'];
    officeMinistryId = json['office_ministry_id'];
    officeLayerId = json['office_layer_id'];
    officeOriginId = json['office_origin_id'];
    customLayerId = json['custom_layer_id'];
    parentOfficeId = json['parent_office_id'];
    officeLayer = json['office_layer'] != null ? Layer.fromJson(json['office_layer']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_name_bng'] = officeNameBng;
    map['office_name_eng'] = officeNameEng;
    map['geo_division_id'] = geoDivisionId;
    map['geo_district_id'] = geoDistrictId;
    map['geo_upazila_id'] = geoUpazilaId;
    map['digital_nothi_code'] = digitalNothiCode;
    map['office_phone'] = officePhone;
    map['office_mobile'] = officeMobile;
    map['office_fax'] = officeFax;
    map['office_email'] = officeEmail;
    map['office_web'] = officeWeb;
    map['office_ministry_id'] = officeMinistryId;
    map['office_layer_id'] = officeLayerId;
    map['office_origin_id'] = officeOriginId;
    map['custom_layer_id'] = customLayerId;
    map['parent_office_id'] = parentOfficeId;
    if (officeLayer != null) map['office_layer'] = officeLayer?.toJson();
    return map;
  }
}
