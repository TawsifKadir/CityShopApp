import 'package:grs/models/officer_profile/employee_info.dart';
import 'package:grs/models/officer_profile/officer_profile.dart';
import 'package:grs/models/officer_profile/user_office_info.dart';

class OfficerProfileInfo {
  OfficerProfile? profile;
  // UserNotification? notification;
  EmployeeInfo? employeeInfo;
  List<UserOfficeInfo>? officeInfo;
  bool? hasDigitalCertificate;

  OfficerProfileInfo({
    this.profile,
    // this.notification,
    this.employeeInfo,
    this.officeInfo,
    this.hasDigitalCertificate,
  });

  OfficerProfileInfo.fromJson(json) {
    profile = json['user'] != null ? OfficerProfile.fromJson(json['user']) : null;
    // notification = json['notifications'] != null ? UserNotification.fromJson(json['notifications']) : null;
    employeeInfo = json['employee_info'] != null ? EmployeeInfo.fromJson(json['employee_info']) : null;
    officeInfo = [];
    if (json['office_info'] != null) json['office_info'].forEach((v) => officeInfo?.add(UserOfficeInfo.fromJson(v)));
    hasDigitalCertificate = json['has_digital_certificate'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profile != null) map['user'] = profile?.toJson();
    // if (notification != null) map['notifications'] = notification?.toJson();
    if (employeeInfo != null) map['employee_info'] = employeeInfo?.toJson();
    if (officeInfo != null) map['office_info'] = officeInfo?.map((v) => v.toJson()).toList();
    map['has_digital_certificate'] = hasDigitalCertificate;
    return map;
  }
}
