import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Qualification {
  int? id;
  String? educationEng;
  String? educationBng;
  int? status;

  Qualification({this.id, this.educationEng, this.educationBng, this.status});

  String get qualification => sl<StorageService>().getLanguage == 'bn' ? educationBng ?? '' : educationEng ?? '';

  Qualification.fromJson(json) {
    id = json['id'];
    educationEng = json['education_eng'];
    educationBng = json['education_bng'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['education_eng'] = educationEng;
    map['education_bng'] = educationBng;
    map['status'] = status;
    return map;
  }
}
