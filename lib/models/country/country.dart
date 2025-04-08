import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Country {
  int? id;
  String? countryNameEng;
  String? nationalityEng;
  String? countryNameBng;
  String? nationalityBng;

  Country({this.id, this.countryNameEng, this.nationalityEng, this.countryNameBng, this.nationalityBng});

  String get country_name => sl<StorageService>().getLanguage == 'bn' ? countryNameBng ?? '' : countryNameEng ?? '';
  String get nationality => sl<StorageService>().getLanguage == 'bn' ? nationalityBng ?? '' : nationalityEng ?? '';

  Country.fromJson(json) {
    id = json['id'];
    countryNameEng = json['country_name_eng'];
    nationalityEng = json['nationality_eng'];
    countryNameBng = json['country_name_bng'];
    nationalityBng = json['nationality_bng'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['country_name_eng'] = countryNameEng;
    map['nationality_eng'] = nationalityEng;
    map['country_name_bng'] = countryNameBng;
    map['nationality_bng'] = nationalityBng;
    return map;
  }
}
