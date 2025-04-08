import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/models/dashboard/graph_grievence.dart';
import 'package:grs/models/dashboard/office_grievence.dart';
import 'package:grs/models/dashboard/service_grievence.dart';

const _serviceGrievance = 'service_wise_grievance_list';
const _graphGrievance = 'graph_wise_grievance_list';
const _officeGrievance = 'office_wise_greivance_list';

class Dashboard {
  int? totalComplaint;
  int? runningComplaint;
  int? closedComplaint;
  int? timePassedComplaint;
  int? totalAppeal;
  int? runningAppeal;
  int? timePassedAppeal;
  int? closedAppeal;
  double? grievanceDisposalRate;
  double? appealRate;
  double? totalResponse;
  double? averageRating;
  List<ServiceGrievance>? serviceGrievanceList;
  List<GraphGrievance>? graphGrievanceList;
  List<OfficeGrievance>? officeGrievanceList;
  List<int>? groOfficeIds;

  Dashboard({
    this.totalComplaint,
    this.runningComplaint,
    this.closedComplaint,
    this.timePassedComplaint,
    this.totalAppeal,
    this.runningAppeal,
    this.timePassedAppeal = 0,
    this.closedAppeal = 0,
    this.grievanceDisposalRate = 0,
    this.appealRate = 0,
    this.totalResponse = 0,
    this.averageRating = 0,
    this.serviceGrievanceList = const [],
    this.graphGrievanceList = const [],
    this.officeGrievanceList = const [],
    this.groOfficeIds = const [],
  });

  Dashboard.fromJson(json) {
    totalComplaint = json['total_complaint'];
    runningComplaint = json['running_complaint'];
    closedComplaint = json['closed_complaint'];
    timePassedComplaint = json['time_passed_complaint'];
    totalAppeal = json['total_appeal'];
    runningAppeal = json['running_appeal'];
    timePassedAppeal = json['time_passed_appeal'];
    closedAppeal = json['closed_appeal'];
    grievanceDisposalRate = json['grievance_disposal_rate'] == null ? 0 : '${json['grievance_disposal_rate']}'.parseDouble;
    appealRate = json['appeal_rate'] == null ? 0 : '${json['appeal_rate']}'.parseDouble;
    totalResponse = json['total_response'] == null ? 0 : '${json['total_response']}'.parseDouble;
    averageRating = json['average_rating'] == null ? 0 : '${json['average_rating']}'.parseDouble;
    serviceGrievanceList = [];
    if (json[_serviceGrievance] != null) json[_serviceGrievance].forEach((v) => serviceGrievanceList?.add(ServiceGrievance.fromJson(v)));
    graphGrievanceList = [];
    if (json[_graphGrievance] != null) json[_graphGrievance].forEach((v) => graphGrievanceList?.add(GraphGrievance.fromJson(v)));
    officeGrievanceList = [];
    if (json[_officeGrievance] != null) json[_officeGrievance].forEach((v) => officeGrievanceList?.add(OfficeGrievance.fromJson(v)));
    groOfficeIds = [];
    groOfficeIds = json['officeGroOfficeIds'] != null ? json['officeGroOfficeIds'].cast<int>() : [];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['total_complaint'] = totalComplaint;
    map['running_complaint'] = runningComplaint;
    map['closed_complaint'] = closedComplaint;
    map['time_passed_complaint'] = timePassedComplaint;
    map['total_appeal'] = totalAppeal;
    map['running_appeal'] = runningAppeal;
    map['time_passed_appeal'] = timePassedAppeal;
    map['closed_appeal'] = closedAppeal;
    map['grievance_disposal_rate'] = grievanceDisposalRate;
    map['appeal_rate'] = appealRate;
    map['total_response'] = totalResponse;
    map['average_rating'] = averageRating;
    if (serviceGrievanceList.haveList) map[_serviceGrievance] = serviceGrievanceList?.map((v) => v.toJson()).toList();
    if (graphGrievanceList.haveList) map[_graphGrievance] = graphGrievanceList?.map((v) => v.toJson()).toList();
    if (officeGrievanceList.haveList) map[_officeGrievance] = officeGrievanceList?.map((v) => v.toJson()).toList();
    map['officeGroOfficeIds'] = groOfficeIds;
    return map;
  }
}
