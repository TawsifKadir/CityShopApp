import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class CharterService {
  int? id;
  int? officeId;
  int? officeOriginId;
  int? serviceId;
  int? soOfficeId;
  int? soOfficeUnitId;
  int? soOfficeUnitOrganogramId;
  String? serviceNameBng;
  String? serviceNameEng;
  String? serviceProcedureBng;
  String? serviceProcedureEng;
  String? documentsAndLocationBng;
  String? documentsAndLocationEng;
  String? paymentMethodBng;
  String? paymentMethodEng;
  int? serviceTime;
  dynamic serviceType;
  dynamic isDisabledForAdmin;
  int? status;
  int? originStatus;
  dynamic createdAt;
  dynamic modifiedAt;
  dynamic createdBy;
  dynamic modifiedBy;

  String get service_name => sl<StorageService>().getLanguage == 'bn' ? serviceNameBng ?? '' : serviceNameEng ?? '';
  String get service_procedure => sl<StorageService>().getLanguage == 'bn' ? serviceProcedureBng ?? '' : serviceProcedureEng ?? '';
  // String get service_time => sl<StorageService>().getLanguage == 'bn' ? serviceProcedureBng ?? '' : serviceProcedureEng ?? '';
  String get service_doc => sl<StorageService>().getLanguage == 'bn' ? documentsAndLocationBng ?? '' : documentsAndLocationEng ?? '';
  String get payment_method => sl<StorageService>().getLanguage == 'bn' ? paymentMethodBng ?? '' : paymentMethodEng ?? '';

  CharterService({
    this.id,
    this.officeId,
    this.officeOriginId,
    this.serviceId,
    this.soOfficeId,
    this.soOfficeUnitId,
    this.soOfficeUnitOrganogramId,
    this.serviceNameBng,
    this.serviceNameEng,
    this.serviceProcedureBng,
    this.serviceProcedureEng,
    this.documentsAndLocationBng,
    this.documentsAndLocationEng,
    this.paymentMethodBng,
    this.paymentMethodEng,
    this.serviceTime,
    this.serviceType,
    this.isDisabledForAdmin,
    this.status,
    this.originStatus,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
  });

  CharterService.fromJson(json) {
    id = json['id'];
    officeId = json['office_id'];
    officeOriginId = json['office_origin_id'];
    serviceId = json['service_id'];
    soOfficeId = json['so_office_id'];
    soOfficeUnitId = json['so_office_unit_id'];
    soOfficeUnitOrganogramId = json['so_office_unit_organogram_id'];
    serviceNameBng = json['service_name_bng'];
    serviceNameEng = json['service_name_eng'];
    serviceProcedureBng = json['service_procedure_bng'];
    serviceProcedureEng = json['service_procedure_eng'];
    documentsAndLocationBng = json['documents_and_location_bng'];
    documentsAndLocationEng = json['documents_and_location_eng'];
    paymentMethodBng = json['payment_method_bng'];
    paymentMethodEng = json['payment_method_eng'];
    serviceTime = json['service_time'];
    serviceType = json['service_type'];
    isDisabledForAdmin = json['is_disabled_for_admin'];
    status = json['status'];
    originStatus = json['origin_status'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_id'] = officeId;
    map['office_origin_id'] = officeOriginId;
    map['service_id'] = serviceId;
    map['so_office_id'] = soOfficeId;
    map['so_office_unit_id'] = soOfficeUnitId;
    map['so_office_unit_organogram_id'] = soOfficeUnitOrganogramId;
    map['service_name_bng'] = serviceNameBng;
    map['service_name_eng'] = serviceNameEng;
    map['service_procedure_bng'] = serviceProcedureBng;
    map['service_procedure_eng'] = serviceProcedureEng;
    map['documents_and_location_bng'] = documentsAndLocationBng;
    map['documents_and_location_eng'] = documentsAndLocationEng;
    map['payment_method_bng'] = paymentMethodBng;
    map['payment_method_eng'] = paymentMethodEng;
    map['service_time'] = serviceTime;
    map['service_type'] = serviceType;
    map['is_disabled_for_admin'] = isDisabledForAdmin;
    map['status'] = status;
    map['origin_status'] = originStatus;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    return map;
  }
}
