import 'package:grs/models/district/district.dart';

class DistrictApi {
  String? status;
  List<District>? districts;

  DistrictApi({this.status, this.districts});

  DistrictApi.fromJson(json) {
    status = json['status'];
    districts = [];
    if (json['data'] != null) json['data'].forEach((v) => districts?.add(District.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (districts != null) map['data'] = districts?.map((v) => v.toJson()).toList();
    return map;
  }
}
