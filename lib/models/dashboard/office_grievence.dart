class OfficeGrievance {
  int? id;
  String? officeNameBng;
  int? officeTotalComplaint;
  int? officeRunningComplaint;
  int? sentToAnotherOffice;
  int? officeTimePassedComplaint;
  dynamic officeTimePassedComplaintRate;
  int? officeClosedComplaint;
  dynamic oficeGrievanceDisposalRate;
  int? officeTotalAppeal;
  dynamic officeAppealRate;
  int? officeRunningAppeal;
  int? officeClosedAppeal;
  int? officeTimePassedAppeal;
  int? sentToAnotherOfficeAppeal;

  OfficeGrievance({
    this.id,
    this.officeNameBng,
    this.officeTotalComplaint,
    this.officeRunningComplaint,
    this.sentToAnotherOffice,
    this.officeTimePassedComplaint,
    this.officeTimePassedComplaintRate,
    this.officeClosedComplaint,
    this.oficeGrievanceDisposalRate,
    this.officeTotalAppeal,
    this.officeAppealRate,
    this.officeRunningAppeal,
    this.officeClosedAppeal,
    this.officeTimePassedAppeal,
    this.sentToAnotherOfficeAppeal,
  });

  OfficeGrievance.fromJson(json) {
    id = json['id'];
    officeNameBng = json['office_name_bng'];
    officeTotalComplaint = json['office_total_complaint'] ?? 0;
    officeRunningComplaint = json['office_running_complaint'] ?? 0;
    sentToAnotherOffice = json['sent_to_another_office'] ?? 0;
    officeTimePassedComplaint = json['office_time_passed_complaint'];
    officeTimePassedComplaintRate = json['office_time_passed_complaint_rate'];
    officeClosedComplaint = json['office_closed_complaint'];
    oficeGrievanceDisposalRate = json['ofice_grievance_disposal_rate'];
    officeTotalAppeal = json['office_total_appeal'];
    officeAppealRate = json['office_appeal_rate'];
    officeRunningAppeal = json['office_running_appeal'];
    officeClosedAppeal = json['office_closed_appeal'];
    officeTimePassedAppeal = json['office_time_passed_appeal'];
    sentToAnotherOfficeAppeal = json['sent_to_another_office_appeal'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_name_bng'] = officeNameBng;
    map['office_total_complaint'] = officeTotalComplaint;
    map['office_running_complaint'] = officeRunningComplaint;
    map['sent_to_another_office'] = sentToAnotherOffice;
    map['office_time_passed_complaint'] = officeTimePassedComplaint;
    map['office_time_passed_complaint_rate'] = officeTimePassedComplaintRate;
    map['office_closed_complaint'] = officeClosedComplaint;
    map['ofice_grievance_disposal_rate'] = oficeGrievanceDisposalRate;
    map['office_total_appeal'] = officeTotalAppeal;
    map['office_appeal_rate'] = officeAppealRate;
    map['office_running_appeal'] = officeRunningAppeal;
    map['office_closed_appeal'] = officeClosedAppeal;
    map['office_time_passed_appeal'] = officeTimePassedAppeal;
    map['sent_to_another_office_appeal'] = sentToAnotherOfficeAppeal;
    return map;
  }
}
