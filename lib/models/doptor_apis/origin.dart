import 'package:grs/di.dart';
import 'package:grs/models/doptor_apis/layer.dart';
import 'package:grs/service/storage_service.dart';

class Origin {
  int? id;
  String? officeNameBng;
  String? officeNameEng;
  int? officeMinistryId;
  int? officeLayerId;
  int? parentOfficeId;
  int? officeLevel;
  int? officeSequence;
  Layer? officeLayer;

  Origin({
    this.id,
    this.officeNameBng,
    this.officeNameEng,
    this.officeMinistryId,
    this.officeLayerId,
    this.parentOfficeId,
    this.officeLevel,
    this.officeSequence,
    this.officeLayer,
  });

  String get office_name => sl<StorageService>().getLanguage == 'bn' ? officeNameBng ?? '' : officeNameEng ?? '';

  Origin.fromJson(json) {
    id = json['id'];
    officeNameBng = json['office_name_bng'];
    officeNameEng = json['office_name_eng'];
    officeMinistryId = json['office_ministry_id'];
    officeLayerId = json['office_layer_id'];
    parentOfficeId = json['parent_office_id'];
    officeLevel = json['office_level'];
    officeSequence = json['office_sequence'];
    officeLayer = json['office_layer'] != null ? Layer.fromJson(json['office_layer']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_name_bng'] = officeNameBng;
    map['office_name_eng'] = officeNameEng;
    map['office_ministry_id'] = officeMinistryId;
    map['office_layer_id'] = officeLayerId;
    map['parent_office_id'] = parentOfficeId;
    map['office_level'] = officeLevel;
    map['office_sequence'] = officeSequence;
    if (officeLayer != null) map['office_layer'] = officeLayer?.toJson();
    return map;
  }
}
