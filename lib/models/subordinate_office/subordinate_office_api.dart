import 'package:grs/models/subordinate_office/sub_ordinate_office.dart';

class SubordinateOfficeApi {
  String? status;
  List<SubordinateOffice>? subordinateOffices;

  SubordinateOfficeApi({this.status, this.subordinateOffices});

  SubordinateOfficeApi.fromJson(json) {
    status = json['status'];
    subordinateOffices = [];
    if (json['data'] != null) json['data'].forEach((v) => subordinateOffices?.add(SubordinateOffice.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (subordinateOffices != null) map['data'] = subordinateOffices?.map((v) => v.toJson()).toList();
    return map;
  }
}
