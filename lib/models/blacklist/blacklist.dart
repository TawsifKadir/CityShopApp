import 'package:grs/models/complain/complained_user.dart';

class Blacklist {
  int? id;
  int? complainantId;
  int? officeId;
  int? requested;
  int? blacklisted;
  String? officeName;
  String? reason;
  String? createdAt;
  String? modifiedAt;
  dynamic createdBy;
  dynamic modifiedBy;
  dynamic status;
  ComplainedUser? complainantInfo;

  Blacklist({
    this.id,
    this.complainantId,
    this.officeId,
    this.requested,
    this.blacklisted,
    this.officeName,
    this.reason,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.complainantInfo,
  });

  Blacklist.fromJson(json) {
    id = json['id'];
    complainantId = json['complainant_id'];
    officeId = json['office_id'];
    requested = json['requested'] ? 1 : 0;
    blacklisted = json['blacklisted'] ? 1 : 0;
    officeName = json['office_name'];
    reason = json['reason'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    status = json['status'];
    complainantInfo = json['complainant_info'] != null ? ComplainedUser.fromJson(json['complainant_info']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['complainant_id'] = complainantId;
    map['office_id'] = officeId;
    map['requested'] = requested;
    map['blacklisted'] = blacklisted;
    map['office_name'] = officeName;
    map['reason'] = reason;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['status'] = status;
    if (complainantInfo != null) map['complainant_info'] = complainantInfo?.toJson();
    return map;
  }
}
