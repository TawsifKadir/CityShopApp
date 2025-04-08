import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class SafetyNet {
  int? id;
  String? nameEn;
  String? nameBn;
  int? officeId;
  int? status;

  String get label => sl<StorageService>().getLanguage == 'bn' ? nameBn ?? '' : nameEn ?? '';

  SafetyNet({this.id, this.nameEn, this.nameBn, this.officeId, this.status});

  SafetyNet.fromJson(json) {
    id = json['id'];
    nameEn = json['name_en'];
    nameBn = json['name_bn'];
    officeId = json['office_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name_en'] = nameEn;
    map['name_bn'] = nameBn;
    map['office_id'] = officeId;
    map['status'] = status;
    return map;
  }
}
