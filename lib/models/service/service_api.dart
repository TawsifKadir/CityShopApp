import 'package:grs/models/service/service.dart';

class ServiceApi {
  String? status;
  List<Service>? serviceList;

  ServiceApi({this.status, this.serviceList});

  ServiceApi.fromJson(json) {
    status = json['status'];
    serviceList = [];
    if (json['data'] != null) json['data'].forEach((v) => serviceList?.add(Service.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (serviceList != null) map['data'] = serviceList?.map((v) => v.toJson()).toList();
    return map;
  }
}
