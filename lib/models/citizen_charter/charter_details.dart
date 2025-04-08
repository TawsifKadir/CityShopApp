import 'package:grs/models/citizen_charter/charter_service.dart';

class CharterDetails {
  String? status;
  List<CharterService>? charterServices;

  CharterDetails({this.status, this.charterServices});

  CharterDetails.fromJson(json) {
    status = json['status'];
    charterServices = [];
    if (json['data'] != null) json['data'].forEach((v) => charterServices?.add(CharterService.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (charterServices != null) map['data'] = charterServices?.map((v) => v.toJson()).toList();
    return map;
  }
}
