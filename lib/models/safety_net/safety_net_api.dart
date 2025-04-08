import 'package:grs/models/safety_net/safety_net.dart';

class SafetyNetApi {
  String? status;
  List<SafetyNet>? safetyNets;

  SafetyNetApi({this.status, this.safetyNets});

  SafetyNetApi.fromJson(json) {
    status = json['status'];
    safetyNets = [];
    if (json['data'] != null) json['data'].forEach((v) => safetyNets?.add(SafetyNet.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (safetyNets != null) map['data'] = safetyNets?.map((v) => v.toJson()).toList();
    return map;
  }
}
