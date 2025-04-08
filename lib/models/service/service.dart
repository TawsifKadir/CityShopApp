import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class Service {
  int? id;
  int? officeOriginId;
  int? officeOriginUnitId;
  int? officeOriginUnitOrganogramId;
  String? officeOriginNameBng;
  String? officeOriginNameEng;
  String? serviceType;
  String? serviceNameBng;
  String? serviceNameEng;
  String? serviceProcedureBng;
  String? serviceProcedureEng;
  String? documentsAndLocationBng;
  String? documentsAndLocationEng;
  String? paymentMethodBng;
  String? paymentMethodEng;
  int? serviceTime;
  int? status;
  dynamic createdBy;
  dynamic modifiedBy;
  String? createdAt;
  String? modifiedAt;

  Service({
    this.id,
    this.officeOriginId,
    this.officeOriginUnitId,
    this.officeOriginUnitOrganogramId,
    this.officeOriginNameBng,
    this.officeOriginNameEng,
    this.serviceType,
    this.serviceNameBng,
    this.serviceNameEng,
    this.serviceProcedureBng,
    this.serviceProcedureEng,
    this.documentsAndLocationBng,
    this.documentsAndLocationEng,
    this.paymentMethodBng,
    this.paymentMethodEng,
    this.serviceTime,
    this.status,
    this.createdBy,
    this.modifiedBy,
    this.createdAt,
    this.modifiedAt,
  });

  String get service_name => sl<StorageService>().getLanguage == 'bn' ? serviceNameBng ?? '' : serviceNameEng ?? '';

  Service.fromJson(json) {
    id = json['id'];
    officeOriginId = json['office_origin_id'];
    officeOriginUnitId = json['office_origin_unit_id'];
    officeOriginUnitOrganogramId = json['office_origin_unit_organogram_id'];
    officeOriginNameBng = json['office_origin_name_bng'];
    officeOriginNameEng = json['office_origin_name_eng'];
    serviceType = json['service_type'];
    serviceNameBng = json['service_name_bng'];
    serviceNameEng = json['service_name_eng'];
    serviceProcedureBng = json['service_procedure_bng'];
    serviceProcedureEng = json['service_procedure_eng'];
    documentsAndLocationBng = json['documents_and_location_bng'];
    documentsAndLocationEng = json['documents_and_location_eng'];
    paymentMethodBng = json['payment_method_bng'];
    paymentMethodEng = json['payment_method_eng'];
    serviceTime = json['service_time'];
    status = json['status'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_origin_id'] = officeOriginId;
    map['office_origin_unit_id'] = officeOriginUnitId;
    map['office_origin_unit_organogram_id'] = officeOriginUnitOrganogramId;
    map['office_origin_name_bng'] = officeOriginNameBng;
    map['office_origin_name_eng'] = officeOriginNameEng;
    map['service_type'] = serviceType;
    map['service_name_bng'] = serviceNameBng;
    map['service_name_eng'] = serviceNameEng;
    map['service_procedure_bng'] = serviceProcedureBng;
    map['service_procedure_eng'] = serviceProcedureEng;
    map['documents_and_location_bng'] = documentsAndLocationBng;
    map['documents_and_location_eng'] = documentsAndLocationEng;
    map['payment_method_bng'] = paymentMethodBng;
    map['payment_method_eng'] = paymentMethodEng;
    map['service_time'] = serviceTime;
    map['status'] = status;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    return map;
  }
}
