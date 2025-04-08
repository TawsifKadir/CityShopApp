import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Vision {
  int? id;
  int? officeOriginId;
  String? officeOriginNameBng;
  String? officeOriginNameEng;
  int? layerLevel;
  String? visionBng;
  String? visionEng;
  String? missionBng;
  String? missionEng;
  String? expectationsBng;
  String? expectationsEng;

  String get vision => sl<StorageService>().getLanguage == 'bn' ? visionBng ?? '' : visionEng ?? '';
  String get mission => sl<StorageService>().getLanguage == 'bn' ? missionBng ?? '' : missionEng ?? '';

  Vision({
    this.id,
    this.officeOriginId,
    this.officeOriginNameBng,
    this.officeOriginNameEng,
    this.layerLevel,
    this.visionBng,
    this.visionEng,
    this.missionBng,
    this.missionEng,
    this.expectationsBng,
    this.expectationsEng,
  });

  Vision.fromJson(json) {
    id = json['id'];
    officeOriginId = json['office_origin_id'];
    officeOriginNameBng = json['office_origin_name_bng'];
    officeOriginNameEng = json['office_origin_name_eng'];
    layerLevel = json['layer_level'];
    visionBng = json['vision_bng'];
    visionEng = json['vision_eng'];
    missionBng = json['mission_bng'];
    missionEng = json['mission_eng'];
    expectationsBng = json['expectations_bng'];
    expectationsEng = json['expectations_eng'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_origin_id'] = officeOriginId;
    map['office_origin_name_bng'] = officeOriginNameBng;
    map['office_origin_name_eng'] = officeOriginNameEng;
    map['layer_level'] = layerLevel;
    map['vision_bng'] = visionBng;
    map['vision_eng'] = visionEng;
    map['mission_bng'] = missionBng;
    map['mission_eng'] = missionEng;
    map['expectations_bng'] = expectationsBng;
    map['expectations_eng'] = expectationsEng;
    return map;
  }
}
