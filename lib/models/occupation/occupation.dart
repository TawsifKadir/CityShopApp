import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Occupation {
  int? id;
  String? occupationEng;
  String? occupationBng;
  int? status;

  Occupation({this.id, this.occupationEng, this.occupationBng, this.status});

  String get occupation => sl<StorageService>().getLanguage == 'bn' ? occupationBng ?? '' : occupationEng ?? '';

  Occupation.fromJson(json) {
    id = json['id'];
    occupationEng = json['occupation_eng'];
    occupationBng = json['occupation_bng'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['occupation_eng'] = occupationEng;
    map['occupation_bng'] = occupationBng;
    map['status'] = status;
    return map;
  }
}
