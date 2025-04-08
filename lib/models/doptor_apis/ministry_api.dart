import 'package:grs/models/doptor_apis/ministry.dart';

class MinistryApi {
  String? status;
  List<Ministry>? ministryList;

  MinistryApi({this.status, this.ministryList});

  MinistryApi.fromJson(json) {
    status = json['status'];
    ministryList = [];
    if (json['data'] != null) json['data'].forEach((v) => ministryList?.add(Ministry.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (ministryList != null) map['data'] = ministryList?.map((v) => v.toJson()).toList();
    return map;
  }
}
