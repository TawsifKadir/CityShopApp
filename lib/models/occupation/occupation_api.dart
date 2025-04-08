import 'package:grs/models/occupation/occupation.dart';

class OccupationApi {
  String? status;
  List<Occupation>? occupations;

  OccupationApi({this.status, this.occupations});

  OccupationApi.fromJson(json) {
    status = json['status'];
    occupations = [];
    if (json['data'] != null) json['data'].forEach((v) => occupations?.add(Occupation.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (occupations != null) map['data'] = occupations?.map((v) => v.toJson()).toList();
    return map;
  }
}
