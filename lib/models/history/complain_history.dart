import 'package:grs/di.dart';
import 'package:grs/models/history/movement_info.dart';
import 'package:grs/service/storage_service.dart';

class ComplainHistory {
  int? id;
  int? complaintId;
  String? note;
  String? action;
  int? toEmployeeRecordId;
  int? fromEmployeeRecordId;
  int? toOfficeUnitOrganogramId;
  int? fromOfficeUnitOrganogramId;
  int? toOfficeId;
  int? fromOfficeId;
  int? toOfficeUnitId;
  int? fromOfficeUnitId;
  int? isCurrent;
  int? isCc;
  int? isCommitteeHead;
  int? isCommitteeMember;
  String? toEmployeeNameBng;
  String? fromEmployeeNameBng;
  String? toEmployeeNameEng;
  String? fromEmployeeNameEng;
  String? toEmployeeDesignationBng;
  String? fromEmployeeDesignationBng;
  String? toOfficeNameBng;
  String? fromOfficeNameBng;
  String? toEmployeeUnitNameBng;
  String? fromEmployeeUnitNameBng;
  String? fromEmployeeUsername;
  String? fromEmployeeSignature;
  String? createdAt;
  String? modifiedAt;
  dynamic createdBy;
  dynamic modifiedBy;
  dynamic status;
  dynamic deadlineDate;
  String? currentStatus;
  int? isSeen;
  String? assignedRole;
  MovementInfo? movementInfo;
  bool? isSelected;

  String get to_employee_name => sl<StorageService>().getLanguage == 'bn' ? toEmployeeNameBng ?? '' : toEmployeeNameEng ?? '';

  ComplainHistory({
    this.id,
    this.complaintId,
    this.note,
    this.action,
    this.toEmployeeRecordId,
    this.fromEmployeeRecordId,
    this.toOfficeUnitOrganogramId,
    this.fromOfficeUnitOrganogramId,
    this.toOfficeId,
    this.fromOfficeId,
    this.toOfficeUnitId,
    this.fromOfficeUnitId,
    this.isCurrent,
    this.isCc,
    this.isCommitteeHead,
    this.isCommitteeMember,
    this.toEmployeeNameBng,
    this.fromEmployeeNameBng,
    this.toEmployeeNameEng,
    this.fromEmployeeNameEng,
    this.toEmployeeDesignationBng,
    this.fromEmployeeDesignationBng,
    this.toOfficeNameBng,
    this.fromOfficeNameBng,
    this.toEmployeeUnitNameBng,
    this.fromEmployeeUnitNameBng,
    this.fromEmployeeUsername,
    this.fromEmployeeSignature,
    this.createdAt,
    this.modifiedAt,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.deadlineDate,
    this.currentStatus,
    this.isSeen,
    this.assignedRole,
    this.movementInfo,
    this.isSelected = false,
  });

  ComplainHistory.fromJson(json) {
    id = json['id'];
    complaintId = json['complaint_id'];
    note = json['note'];
    action = json['action'];
    toEmployeeRecordId = json['to_employee_record_id'];
    fromEmployeeRecordId = json['from_employee_record_id'];
    toOfficeUnitOrganogramId = json['to_office_unit_organogram_id'];
    fromOfficeUnitOrganogramId = json['from_office_unit_organogram_id'];
    toOfficeId = json['to_office_id'];
    fromOfficeId = json['from_office_id'];
    toOfficeUnitId = json['to_office_unit_id'];
    fromOfficeUnitId = json['from_office_unit_id'];
    isCurrent = json['is_current'];
    isCc = json['is_cc'];
    isCommitteeHead = json['is_committee_head'];
    isCommitteeMember = json['is_committee_member'];
    toEmployeeNameBng = json['to_employee_name_bng'];
    fromEmployeeNameBng = json['from_employee_name_bng'];
    toEmployeeNameEng = json['to_employee_name_eng'];
    fromEmployeeNameEng = json['from_employee_name_eng'];
    toEmployeeDesignationBng = json['to_employee_designation_bng'];
    fromEmployeeDesignationBng = json['from_employee_designation_bng'];
    toOfficeNameBng = json['to_office_name_bng'];
    fromOfficeNameBng = json['from_office_name_bng'];
    toEmployeeUnitNameBng = json['to_employee_unit_name_bng'];
    fromEmployeeUnitNameBng = json['from_employee_unit_name_bng'];
    fromEmployeeUsername = json['from_employee_username'];
    fromEmployeeSignature = json['from_employee_signature'];
    createdAt = json['created_at'];
    modifiedAt = json['modified_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    status = json['status'];
    deadlineDate = json['deadline_date'];
    currentStatus = json['current_status'];
    isSeen = json['is_seen'];
    assignedRole = json['assigned_role'];
    movementInfo = json['complaint_movement_info'] != null ? MovementInfo.fromJson(json['complaint_movement_info']) : null;
  }

  String get format_action_status {
    if (action == null || action == '') return '';
    var langCoe = sl<StorageService>().getLanguage;
    if (action == 'NEW') {
      return langCoe == 'en' ? 'New' : 'নতুন';
    } else if (action == 'CELL_NEW') {
      return langCoe == 'en' ? 'New' : 'নতুন';
    } else if (action == 'INV_HEARING') {
      return langCoe == 'en' ? 'Inquiry Hearing Accepted' : 'তদন্ত শুনানি গৃহীত';
    } else if (action == 'INV_HEARING_APPEAL') {
      return langCoe == 'en' ? 'Inquiry Hearing Accepted' : 'তদন্ত শুনানি গৃহীত';
    } else if (action == 'FORWARDED_IN') {
      return langCoe == 'en' ? 'Dispatch to Subordinate Office' : 'আওতাধীন দপ্তরে প্রেরণ';
    } else if (action == 'FORWARDED_OUT') {
      return langCoe == 'en' ? 'Sent to Another Office' : 'অন্য দপ্তরে প্রেরিত';
    } else if (action == 'ACCEPTED') {
      return langCoe == 'en' ? 'Accepted' : 'গৃহীত';
    } else if (action == 'REJECTED') {
      return langCoe == 'en' ? 'Rejected' : 'নথিজাত';
    } else if (action == 'APPEAL_REJECTED') {
      return langCoe == 'en' ? 'Rejected' : 'নথিজাত';
    } else if (action == 'IN_REVIEW') {
      return langCoe == 'en' ? 'In Review' : 'পর্যালোচনা';
    } else if (action == 'APPEAL_IN_REVIEW') {
      return langCoe == 'en' ? 'Review' : 'পর্যালোচনা';
    } else if (action == 'APPEAL') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (action == 'APPEAL_STATEMENT_ANSWERED') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (action == 'APPEAL_STATEMENT_ASKED') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (action == 'INVESTIGATION') {
      return langCoe == 'en' ? 'Investigation' : 'তদন্ত';
    } else if (action == 'INVESTIGATION_APPEAL') {
      return langCoe == 'en' ? 'Investigation' : 'তদন্ত';
    } else if (action == 'INV_NOTICE_FILE') {
      return langCoe == 'en' ? 'Additional Attachments' : 'অতিরিক্ত সংযুক্তি';
    } else if (action == 'INV_NOTICE_FILE_APPEAL') {
      return langCoe == 'en' ? 'Additional Attachments' : 'অতিরিক্ত সংযুক্তি';
    } else if (action == 'INV_NOTICE_HEARING') {
      return langCoe == 'en' ? 'Notice of Inquiry Hearing' : 'তদন্ত শুনানি নোটিশ';
    } else if (action == 'INV_NOTICE_HEARING_APPEAL') {
      return langCoe == 'en' ? 'Notice of Inquiry Hearing' : 'তদন্ত শুনানি নোটিশ';
    } else if (action == 'INV_REPORT') {
      return langCoe == 'en' ? 'Investigation Report' : 'তদন্ত প্রতিবেদন';
    } else if (action == 'INV_REPORT_APPEAL') {
      return langCoe == 'en' ? 'Investigation Report' : 'তদন্ত প্রতিবেদন';
    } else if (action == 'FORWARDED_TO_AO') {
      return langCoe == 'en' ? 'Referred to Appellate Officer' : 'আপিল অফিসারের কাছে প্রেরিত';
    } else if (action == 'PERMISSION_REPLIED') {
      return langCoe == 'en' ? 'Permission Received Reply' : 'অনুমতি উত্তর প্রাপ্ত';
    } else if (action == 'PERMISSION_ASKED') {
      return langCoe == 'en' ? 'Sent for Permission' : 'অনুমতির জন্য প্রেরিত';
    } else if (action == 'STATEMENT_ASKED') {
      return langCoe == 'en' ? 'Sent for Opinion' : 'মতামতের জন্য প্রেরিত';
    } else if (action == 'STATEMENT_ANSWERED') {
      return langCoe == 'en' ? 'Opinion Received' : 'মতামত প্রাপ্ত';
    } else if (action == 'GIVE_GUIDANCE') {
      return langCoe == 'en' ? 'Directed to Provide Services' : 'সেবা প্রদানের জন্য নির্দেশিত';
    } else if (action == 'APPEAL_GIVE_GUIDANCE') {
      return langCoe == 'en' ? 'Directed to Provide Services' : 'সেবা প্রদানের জন্য নির্দেশিত';
    } else if (action == 'GIVE_GUIDANCE_POST_INVESTIGATION') {
      return langCoe == 'en' ? 'Guidelines for Investigation' : 'তদন্তের জন্য নির্দেশিকা';
    } else if (action == 'RECOMMEND_DEPARTMENTAL_ACTION') {
      return langCoe == 'en' ? 'Departmental Action Recommended' : 'বিভাগীয় ব্যবস্থা গ্রহণের সুপারিশকৃত';
    } else if (action == 'APPEAL_RECOMMMEND_DETARTMENTAL_ACTION') {
      return langCoe == 'en' ? 'Departmental Action Recommended' : 'বিভাগীয় ব্যবস্থা গ্রহণের সুপারিশকৃত';
    } else if (action == 'REQUEST_TESTIMONY') {
      return langCoe == 'en' ? 'Instruction of Evidence' : 'সাক্ষ্য-প্রমাণের নির্দেশ';
    } else if (action == 'APPEAL_REQUEST_TESTIMONY') {
      return langCoe == 'en' ? 'Instruction of Evidence' : 'সাক্ষ্য-প্রমাণের নির্দেশ';
    } else if (action == 'TESTIMONY_GIVEN') {
      return langCoe == 'en' ? 'Evidence Sent' : 'সাক্ষ্য-প্রমাণ প্রেরিত';
    } else if (action == 'APPEAL_GIVE_GUIDANCE_POST_INVESTIGATION') {
      return langCoe == 'en' ? 'Guidelines for Investigating Appeals' : 'আপীল তদন্তের জন্য নির্দেশিকা';
    } else if (action == 'CELL_MEETING_PRESENTED') {
      return langCoe == 'en' ? 'Presented at Cell Meeting' : 'সেল মিটিং এ উপস্থাপিত';
    } else if (action == 'CELL_MEETING_ACCEPTED') {
      return langCoe == 'en' ? 'Adopted in Cell Meeting' : 'সেল সভায় গৃহীত';
    } else if (action == 'CLOSED_SERVICE_GIVEN') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'CLOSED_ANSWER_OK') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'CLOSED_INSTRUCTION_EXECUTED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'CLOSED_ACCUSATION_INCORRECT') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_SERVICE_GIVEN') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_ANSWER_OK') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_ACCUSATION_INCORRECT') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'CLOSED_ACCUSATION_PROVED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_ACCUSATION_PROVED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_INSTRUCTION_EXECUTED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'APPEAL_CLOSED_OTHERS') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (action == 'CLOSED_OTHERS') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else {
      return '';
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['complaint_id'] = complaintId;
    map['note'] = note;
    map['action'] = action;
    map['to_employee_record_id'] = toEmployeeRecordId;
    map['from_employee_record_id'] = fromEmployeeRecordId;
    map['to_office_unit_organogram_id'] = toOfficeUnitOrganogramId;
    map['from_office_unit_organogram_id'] = fromOfficeUnitOrganogramId;
    map['to_office_id'] = toOfficeId;
    map['from_office_id'] = fromOfficeId;
    map['to_office_unit_id'] = toOfficeUnitId;
    map['from_office_unit_id'] = fromOfficeUnitId;
    map['is_current'] = isCurrent;
    map['is_cc'] = isCc;
    map['is_committee_head'] = isCommitteeHead;
    map['is_committee_member'] = isCommitteeMember;
    map['to_employee_name_bng'] = toEmployeeNameBng;
    map['from_employee_name_bng'] = fromEmployeeNameBng;
    map['to_employee_name_eng'] = toEmployeeNameEng;
    map['from_employee_name_eng'] = fromEmployeeNameEng;
    map['to_employee_designation_bng'] = toEmployeeDesignationBng;
    map['from_employee_designation_bng'] = fromEmployeeDesignationBng;
    map['to_office_name_bng'] = toOfficeNameBng;
    map['from_office_name_bng'] = fromOfficeNameBng;
    map['to_employee_unit_name_bng'] = toEmployeeUnitNameBng;
    map['from_employee_unit_name_bng'] = fromEmployeeUnitNameBng;
    map['from_employee_username'] = fromEmployeeUsername;
    map['from_employee_signature'] = fromEmployeeSignature;
    map['created_at'] = createdAt;
    map['modified_at'] = modifiedAt;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['status'] = status;
    map['deadline_date'] = deadlineDate;
    map['current_status'] = currentStatus;
    map['is_seen'] = isSeen;
    map['assigned_role'] = assignedRole;
    if (movementInfo != null) map['complaint_movement_info'] = movementInfo?.toJson();
    return map;
  }
}
