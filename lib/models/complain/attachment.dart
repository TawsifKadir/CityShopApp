import 'package:grs/constants/data_constants.dart';

class Attachment {
  int? id;
  int? complaintId;
  String? filePath;
  String? fileType;
  String? fileTitle;
  String? originalName;
  dynamic createdBy;
  dynamic modifiedBy;
  String? createdAt;
  String? modifiedAt;
  int? status;

  String? get attachment_url => filePath == null ? null : '$SERVER/${Uri.encodeFull(filePath!)}';

  Attachment({
    this.id,
    this.complaintId,
    this.filePath,
    this.fileType,
    this.fileTitle,
    this.originalName,
    this.createdBy,
    this.modifiedBy,
    this.createdAt,
    this.modifiedAt,
    this.status,
  });

  Attachment.fromJson(json) {
    id = json['id'];
    complaintId = json['complaint_id'];
    filePath = json['file_path'];
    fileType = json['file_type'];
    fileTitle = json['file_title'];
    originalName = json['file_original_name'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['complaint_id'] = complaintId;
    map['file_path'] = filePath;
    map['file_type'] = fileType;
    map['file_title'] = fileTitle;
    map['file_original_name'] = originalName;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['status'] = status;
    return map;
  }
}
