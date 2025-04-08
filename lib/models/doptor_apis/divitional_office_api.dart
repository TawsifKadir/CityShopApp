import 'package:grs/models/doptor_apis/divitional_office.dart';

class DivitionalOfficeApi {
  String? status;
  List<DivitionalOffice>? divitionalOffices;

  DivitionalOfficeApi({this.status, this.divitionalOffices});

  DivitionalOfficeApi.fromJson(json) {
    status = json['status'];
    divitionalOffices = [];
    if (json['data'] != null) json['data'].forEach((v) => divitionalOffices!.add(DivitionalOffice.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (divitionalOffices != null) map['data'] = divitionalOffices!.map((v) => v.toJson()).toList();
    return map;
  }
}
