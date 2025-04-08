import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class EmployeeInfo {
  int? id;
  dynamic prefixNameEng;
  String? nameEng;
  String? surnameEng;
  dynamic prefixNameBng;
  String? nameBng;
  String? surnameBng;
  String? fatherNameEng;
  String? fatherNameBng;
  String? motherNameEng;
  String? motherNameBng;
  String? dateOfBirth;
  String? nid;
  String? bcn;
  String? ppn;
  String? gender;
  String? religion;
  String? bloodGroup;
  String? maritalStatus;
  String? personalEmail;
  String? personalMobile;
  String? alternativeMobile;
  int? isCadre;
  dynamic employeeGrade;
  dynamic joiningDate;
  int? defaultSign;

  EmployeeInfo({
    this.id,
    this.prefixNameEng,
    this.nameEng,
    this.surnameEng,
    this.prefixNameBng,
    this.nameBng,
    this.surnameBng,
    this.fatherNameEng,
    this.fatherNameBng,
    this.motherNameEng,
    this.motherNameBng,
    this.dateOfBirth,
    this.nid,
    this.bcn,
    this.ppn,
    this.gender,
    this.religion,
    this.bloodGroup,
    this.maritalStatus,
    this.personalEmail,
    this.personalMobile,
    this.alternativeMobile,
    this.isCadre,
    this.employeeGrade,
    this.joiningDate,
    this.defaultSign,
  });

  String get name => sl<StorageService>().getLanguage == 'bn' ? nameBng ?? '' : nameEng ?? '';

  EmployeeInfo.fromJson(json) {
    id = json['id'];
    prefixNameEng = json['prefix_name_eng'];
    nameEng = json['name_eng'];
    surnameEng = json['surname_eng'];
    prefixNameBng = json['prefix_name_bng'];
    nameBng = json['name_bng'];
    surnameBng = json['surname_bng'];
    fatherNameEng = json['father_name_eng'];
    fatherNameBng = json['father_name_bng'];
    motherNameEng = json['mother_name_eng'];
    motherNameBng = json['mother_name_bng'];
    dateOfBirth = json['date_of_birth'];
    nid = json['nid'];
    bcn = json['bcn'];
    ppn = json['ppn'];
    gender = json['gender'];
    religion = json['religion'];
    bloodGroup = json['blood_group'];
    maritalStatus = json['marital_status'];
    personalEmail = json['personal_email'];
    personalMobile = json['personal_mobile'];
    alternativeMobile = json['alternative_mobile'];
    isCadre = json['is_cadre'];
    employeeGrade = json['employee_grade'];
    joiningDate = json['joining_date'];
    defaultSign = json['default_sign'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['prefix_name_eng'] = prefixNameEng;
    map['name_eng'] = nameEng;
    map['surname_eng'] = surnameEng;
    map['prefix_name_bng'] = prefixNameBng;
    map['name_bng'] = nameBng;
    map['surname_bng'] = surnameBng;
    map['father_name_eng'] = fatherNameEng;
    map['father_name_bng'] = fatherNameBng;
    map['mother_name_eng'] = motherNameEng;
    map['mother_name_bng'] = motherNameBng;
    map['date_of_birth'] = dateOfBirth;
    map['nid'] = nid;
    map['bcn'] = bcn;
    map['ppn'] = ppn;
    map['gender'] = gender;
    map['religion'] = religion;
    map['blood_group'] = bloodGroup;
    map['marital_status'] = maritalStatus;
    map['personal_email'] = personalEmail;
    map['personal_mobile'] = personalMobile;
    map['alternative_mobile'] = alternativeMobile;
    map['is_cadre'] = isCadre;
    map['employee_grade'] = employeeGrade;
    map['joining_date'] = joiningDate;
    map['default_sign'] = defaultSign;
    return map;
  }
}
