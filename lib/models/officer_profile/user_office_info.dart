import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class UserOfficeInfo {
  int? id;
  int? employeeRecordId;
  int? officeId;
  int? officeUnitId;
  int? officeUnitOrganogramId;
  String? designation;
  int? designationLevel;
  int? designationSequence;
  int? officeHead;
  String? inChargeLabel;
  dynamic joiningDate;
  dynamic lastOfficeDate;
  bool? status;
  int? showUnit;
  String? designationEn;
  String? unitNameBn;
  String? officeNameBn;
  String? unitNameEn;
  String? officeNameEn;
  int? protikolpoStatus;
  dynamic releasedBy;
  int? officeMinistryId;
  int? officeLayerId;
  int? customLayerId;
  String? designationEng;

  UserOfficeInfo({
    this.id,
    this.employeeRecordId,
    this.officeId,
    this.officeUnitId,
    this.officeUnitOrganogramId,
    this.designation,
    this.designationLevel,
    this.designationSequence,
    this.officeHead,
    this.inChargeLabel,
    this.joiningDate,
    this.lastOfficeDate,
    this.status,
    this.showUnit,
    this.designationEn,
    this.unitNameBn,
    this.officeNameBn,
    this.unitNameEn,
    this.officeNameEn,
    this.protikolpoStatus,
    this.releasedBy,
    this.officeMinistryId,
    this.officeLayerId,
    this.customLayerId,
    this.designationEng,
  });

  String get designation_name => sl<StorageService>().getLanguage == 'bn' ? designation ?? '' : designationEn ?? '';
  String get office_name => sl<StorageService>().getLanguage == 'bn' ? officeNameBn ?? '' : officeNameEn ?? '';
  String get unit_name => sl<StorageService>().getLanguage == 'bn' ? unitNameBn ?? '' : unitNameEn ?? '';

  UserOfficeInfo.fromJson(json) {
    id = json['id'];
    employeeRecordId = json['employee_record_id'];
    officeId = json['office_id'];
    officeUnitId = json['office_unit_id'];
    officeUnitOrganogramId = json['office_unit_organogram_id'];
    designation = json['designation'];
    designationLevel = json['designation_level'];
    designationSequence = json['designation_sequence'];
    officeHead = json['office_head'];
    inChargeLabel = json['incharge_label'];
    joiningDate = json['joining_date'];
    lastOfficeDate = json['last_office_date'];
    status = json['status'];
    showUnit = json['show_unit'];
    designationEn = json['designation_en'];
    unitNameBn = json['unit_name_bn'];
    officeNameBn = json['office_name_bn'];
    unitNameEn = json['unit_name_en'];
    officeNameEn = json['office_name_en'];
    protikolpoStatus = json['protikolpo_status'];
    releasedBy = json['released_by'];
    officeMinistryId = json['office_ministry_id'];
    officeLayerId = json['office_layer_id'];
    customLayerId = json['custom_layer_id'];
    designationEng = json['designation_eng'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['employee_record_id'] = employeeRecordId;
    map['office_id'] = officeId;
    map['office_unit_id'] = officeUnitId;
    map['office_unit_organogram_id'] = officeUnitOrganogramId;
    map['designation'] = designation;
    map['designation_level'] = designationLevel;
    map['designation_sequence'] = designationSequence;
    map['office_head'] = officeHead;
    map['incharge_label'] = inChargeLabel;
    map['joining_date'] = joiningDate;
    map['last_office_date'] = lastOfficeDate;
    map['status'] = status;
    map['show_unit'] = showUnit;
    map['designation_en'] = designationEn;
    map['unit_name_bn'] = unitNameBn;
    map['office_name_bn'] = officeNameBn;
    map['unit_name_en'] = unitNameEn;
    map['office_name_en'] = officeNameEn;
    map['protikolpo_status'] = protikolpoStatus;
    map['released_by'] = releasedBy;
    map['office_ministry_id'] = officeMinistryId;
    map['office_layer_id'] = officeLayerId;
    map['custom_layer_id'] = customLayerId;
    map['designation_eng'] = designationEng;
    return map;
  }
}
