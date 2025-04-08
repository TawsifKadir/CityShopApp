import 'package:grs/models/service/service.dart';

class ServiceGrievance {
  int? serviceId;
  int? count;
  Service? service;

  ServiceGrievance({this.serviceId, this.count, this.service});

  ServiceGrievance.fromJson(json) {
    serviceId = json['service_id'];
    count = json['count'];
    service = json['service_detail'] != null ? Service.fromJson(json['service_detail']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['service_id'] = serviceId;
    map['count'] = count;
    if (service != null) map['service_detail'] = service?.toJson();
    return map;
  }
}
