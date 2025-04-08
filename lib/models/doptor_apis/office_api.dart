import 'package:grs/models/doptor_apis/office.dart';

class OfficeApi {
  String? status;
  List<Office>? officeList;

  OfficeApi({this.status, this.officeList});

  OfficeApi.fromJson(json) {
    status = json['status'];
    officeList = [];
    if (json['data'] != null) json['data'].forEach((v) => officeList?.add(Office.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (officeList != null) map['data'] = officeList?.map((v) => v.toJson()).toList();
    return map;
  }
}
