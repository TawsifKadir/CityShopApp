import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/complain/attachment.dart';
import 'package:grs/models/officer_profile/officer_profile.dart';
import 'package:grs/service/storage_service.dart';

class Complain {
  int? id;
  String? submissionDate;
  String? submissionDateBn;
  String? complaintType;
  String? complaintTypeBn;
  String? currentStatus;
  String? currentStatusBn;
  String? subject;
  String? details;
  String? trackingNumber;
  String? trackingNumberBn;
  int? complainantId;
  int? isGrsUser;
  int? officeId;
  dynamic serviceId;
  dynamic serviceIdBeforeForward;
  int? currentAppealOfficeId;
  int? currentAppealOfficeUnitOrganogramId;
  dynamic sendToAoOfficeId;
  int? isAnonymous;
  String? caseNumber;
  String? otherService;
  String? otherServiceBeforeForward;
  dynamic serviceReceiver;
  dynamic serviceReceiverRelation;
  String? groDecision;
  String? groIdentifiedComplaintCause;
  String? groSuggestion;
  String? aoDecision;
  String? aoIdentifiedComplaintCause;
  String? aoSuggestion;
  String? createdAt;
  String? updatedAt;
  int? createdBy;
  dynamic modifiedBy;
  int? status;
  dynamic rating;
  dynamic appealRating;
  int? isRatingGiven;
  dynamic isAppealRatingGiven;
  String? feedbackComments;
  dynamic appealFeedbackComments;
  String? sourceOfGrievance;
  int? isOfflineComplaint;
  int? isSelfMotivatedGrievance;
  dynamic uploaderOfficeUnitOrganogramId;
  String? possibleCloseDate;
  String? possibleCloseDateBn;
  int? isEvidenceProvide;
  int? isSeeHearingDate;
  OfficerProfile? complainedUser;
  List<Attachment>? attachmentInfo;

  Complain({
    this.id,
    this.submissionDate,
    this.submissionDateBn,
    this.complaintType,
    this.complaintTypeBn,
    this.currentStatus,
    this.currentStatusBn,
    this.subject,
    this.details,
    this.trackingNumber,
    this.trackingNumberBn,
    this.complainantId,
    this.isGrsUser,
    this.officeId,
    this.serviceId,
    this.serviceIdBeforeForward,
    this.currentAppealOfficeId,
    this.currentAppealOfficeUnitOrganogramId,
    this.sendToAoOfficeId,
    this.isAnonymous,
    this.caseNumber,
    this.otherService,
    this.otherServiceBeforeForward,
    this.serviceReceiver,
    this.serviceReceiverRelation,
    this.groDecision,
    this.groIdentifiedComplaintCause,
    this.groSuggestion,
    this.aoDecision,
    this.aoIdentifiedComplaintCause,
    this.aoSuggestion,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.rating,
    this.appealRating,
    this.isRatingGiven,
    this.isAppealRatingGiven,
    this.feedbackComments,
    this.appealFeedbackComments,
    this.sourceOfGrievance,
    this.isOfflineComplaint,
    this.isSelfMotivatedGrievance,
    this.uploaderOfficeUnitOrganogramId,
    this.possibleCloseDate,
    this.possibleCloseDateBn,
    this.isEvidenceProvide,
    this.isSeeHearingDate,
    this.complainedUser,
    this.attachmentInfo,
  });

  String get complain_details => details == null ? '' : details!.removeHtml;
  String get case_number => sl<Formatters>().localizeNumber(caseNumber);

  String get tracking_number {
    var langCoe = sl<StorageService>().getLanguage;
    if (langCoe == 'en') return trackingNumber ?? '';
    return trackingNumberBn != null && trackingNumberBn!.trim().length > 0
        ? trackingNumberBn ?? ''
        : sl<Formatters>().localizeNumber(trackingNumber).replaceAll(',', '');
  }

  bool get showCitizenAction {
    var userId = sl<ProfileHelper>().citizenProfile.id;
    var complainStatus = currentStatus ?? '';
    var officerStatus = complainStatus == 'CLOSED_OTHERS' ||
        complainStatus == 'CLOSED_ACCUSATION_INCORRECT' ||
        complainStatus == 'CLOSED_ACCUSATION_PROVED';
    var appealStatus = complainStatus == 'APPEAL_CLOSED_OTHERS' ||
        complainStatus == 'APPEAL_CLOSED_ACCUSATION_INCORRECT' ||
        complainStatus == 'APPEAL_CLOSED_ACCUSATION_PROVED';
    // var isRating = (officerStatus || appealStatus) && (isRatingGiven == null || isRatingGiven == 0);
    var isRating = false;
    var isAppeal = (complainStatus == 'CLOSED_ACCUSATION_INCORRECT' ||
        complainStatus == 'CLOSED' ||
        complainStatus == 'REJECTED') &&
        (isAppealRatingGiven == null || isAppealRatingGiven == 0);
    var isFile = (complainStatus == 'INV_NOTICE_FILE' || complainStatus == 'INV_NOTICE_FILE_APPEAL') &&
        (isEvidenceProvide == null || isEvidenceProvide == 0);
    var isHearing = (complainStatus == 'INV_NOTICE_HEARING' || complainStatus == 'INV_NOTICE_HEARING_APPEAL') &&
        (isSeeHearingDate == null || isSeeHearingDate == 0);
    return userId != null && (isRating || isAppeal || isFile || isHearing);
  }

  Complain.fromJson(json) {
    id = json['id'];
    submissionDate = json['submission_date'];
    submissionDateBn = json['submission_date_bn'];
    complaintType = json['complaint_type'];
    complaintTypeBn = json['complaint_type_bn'];
    currentStatus = json['current_status'];
    currentStatusBn = json['current_status_bn'];
    subject = json['subject'] != null ? sl<Formatters>().removeHtml(json['subject']) : null;
    details = json['details'] != null ? sl<Formatters>().removeHtml(json['details']) : null;
    trackingNumber = json['tracking_number'];
    trackingNumberBn = json['tracking_number_bn'];
    complainantId = json['complainant_id'];
    isGrsUser = json['is_grs_user'];
    officeId = json['office_id'];
    serviceId = json['service_id'];
    serviceIdBeforeForward = json['service_id_before_forward'];
    currentAppealOfficeId = json['current_appeal_office_id'];
    currentAppealOfficeUnitOrganogramId = json['current_appeal_office_unit_organogram_id'];
    sendToAoOfficeId = json['send_to_ao_office_id'];
    isAnonymous = json['is_anonymous'];
    caseNumber = json['case_number'];
    otherService = json['other_service'];
    otherServiceBeforeForward = json['other_service_before_forward'];
    serviceReceiver = json['service_receiver'];
    serviceReceiverRelation = json['service_receiver_relation'];
    groDecision = json['gro_decision'];
    groIdentifiedComplaintCause = json['gro_identified_complaint_cause'];
    groSuggestion = json['gro_suggestion'];
    aoDecision = json['ao_decision'];
    aoIdentifiedComplaintCause = json['ao_identified_complaint_cause'];
    aoSuggestion = json['ao_suggestion'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    status = json['status'];
    rating = json['rating'];
    appealRating = json['appeal_rating'];
    isRatingGiven = json['is_rating_given'];
    isAppealRatingGiven = json['is_appeal_rating_given'];
    feedbackComments = json['feedback_comments'];
    appealFeedbackComments = json['appeal_feedback_comments'];
    sourceOfGrievance = json['source_of_grievance'];
    isOfflineComplaint = json['is_offline_complaint'];
    isSelfMotivatedGrievance = json['is_self_motivated_grievance'];
    uploaderOfficeUnitOrganogramId = json['uploader_office_unit_organogram_id'];
    possibleCloseDate = json['possible_close_date'];
    possibleCloseDateBn = json['possible_close_date_bn'];
    isEvidenceProvide = json['is_evidence_provide'] ?? 0;
    isSeeHearingDate = json['is_see_hearing_date'] ?? 0;
    complainedUser = json['complainant_info'] != null ? OfficerProfile.fromJson(json['complainant_info']) : null;
    // attachmentInfo = json['complaint_attachment_info'] != null ? Attachment.fromJson(json['complaint_attachment_info']) : null;
    attachmentInfo = json['complaint_attachment_info'] != null && (json['complaint_attachment_info'] as List).isNotEmpty
        ? List<Attachment>.from(
        (json['complaint_attachment_info'] as List).map((item) => Attachment.fromJson(item))
        ) : [];
  }

  String get format_status {
    if (currentStatus == null || currentStatus == '') return '';
    var langCoe = sl<StorageService>().getLanguage;
    if (currentStatus == 'NEW') {
      return langCoe == 'en' ? 'New' : 'নতুন';
    } else if (currentStatus == 'CELL_NEW') {
      return langCoe == 'en' ? 'New' : 'নতুন';
    } else if (currentStatus == 'INV_HEARING') {
      return langCoe == 'en' ? 'Inquiry Hearing Accepted' : 'তদন্ত শুনানি গৃহীত';
    } else if (currentStatus == 'INV_HEARING_APPEAL') {
      return langCoe == 'en' ? 'Inquiry Hearing Accepted' : 'তদন্ত শুনানি গৃহীত';
    } else if (currentStatus == 'FORWARDED_IN') {
      return langCoe == 'en' ? 'Dispatch to Subordinate Office' : 'আওতাধীন দপ্তরে প্রেরণ';
    } else if (currentStatus == 'FORWARDED_OUT') {
      return langCoe == 'en' ? 'Sent to Another Office' : 'অন্য দপ্তরে প্রেরিত';
    } else if (currentStatus == 'ACCEPTED') {
      return langCoe == 'en' ? 'Accepted' : 'গৃহীত';
    } else if (currentStatus == 'REJECTED') {
      return langCoe == 'en' ? 'Rejected' : 'নথিজাত';
    } else if (currentStatus == 'APPEAL_REJECTED') {
      return langCoe == 'en' ? 'Rejected' : 'নথিজাত';
    } else if (currentStatus == 'IN_REVIEW') {
      return langCoe == 'en' ? 'In Review' : 'পর্যালোচনা';
    } else if (currentStatus == 'APPEAL_IN_REVIEW') {
      return langCoe == 'en' ? 'Review' : 'পর্যালোচনা';
    } else if (currentStatus == 'APPEAL') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (currentStatus == 'APPEAL_STATEMENT_ASKED') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (currentStatus == 'APPEAL_STATEMENT_ANSWERED') {
      return langCoe == 'en' ? 'Appealed' : 'আপিলকৃত';
    } else if (currentStatus == 'INVESTIGATION') {
      return langCoe == 'en' ? 'Investigation' : 'তদন্ত';
    } else if (currentStatus == 'INVESTIGATION_APPEAL') {
      return langCoe == 'en' ? 'Investigation' : 'তদন্ত';
    } else if (currentStatus == 'INV_NOTICE_FILE') {
      return langCoe == 'en' ? 'Additional Attachments' : 'অতিরিক্ত সংযুক্তি';
    } else if (currentStatus == 'INV_NOTICE_FILE_APPEAL') {
      return langCoe == 'en' ? 'Additional Attachments' : 'অতিরিক্ত সংযুক্তি';
    } else if (currentStatus == 'INV_NOTICE_HEARING') {
      return langCoe == 'en' ? 'Notice of Inquiry Hearing' : 'তদন্ত শুনানি নোটিশ';
    } else if (currentStatus == 'INV_NOTICE_HEARING_APPEAL') {
      return langCoe == 'en' ? 'Notice of Inquiry Hearing' : 'তদন্ত শুনানি নোটিশ';
    } else if (currentStatus == 'INV_REPORT') {
      return langCoe == 'en' ? 'Investigation Report' : 'তদন্ত প্রতিবেদন';
    } else if (currentStatus == 'INV_REPORT_APPEAL') {
      return langCoe == 'en' ? 'Investigation Report' : 'তদন্ত প্রতিবেদন';
    } else if (currentStatus == 'FORWARDED_TO_AO') {
      return langCoe == 'en' ? 'Referred to Appellate Officer' : 'আপিল অফিসারের কাছে প্রেরিত';
    } else if (currentStatus == 'PERMISSION_REPLIED') {
      return langCoe == 'en' ? 'Permission Received Reply' : 'অনুমতি উত্তর প্রাপ্ত';
    } else if (currentStatus == 'PERMISSION_ASKED') {
      return langCoe == 'en' ? 'Sent for Permission' : 'অনুমতির জন্য প্রেরিত';
    } else if (currentStatus == 'STATEMENT_ASKED') {
      return langCoe == 'en' ? 'Sent for Opinion' : 'মতামতের জন্য প্রেরিত';
    } else if (currentStatus == 'STATEMENT_ANSWERED') {
      return langCoe == 'en' ? 'Opinion Received' : 'মতামত প্রাপ্ত';
    } else if (currentStatus == 'GIVE_GUIDANCE') {
      return langCoe == 'en' ? 'Directed to Provide Services' : 'সেবা প্রদানের জন্য নির্দেশিত';
    } else if (currentStatus == 'APPEAL_GIVE_GUIDANCE') {
      return langCoe == 'en' ? 'Directed to Provide Services' : 'সেবা প্রদানের জন্য নির্দেশিত';
    } else if (currentStatus == 'GIVE_GUIDANCE_POST_INVESTIGATION') {
      return langCoe == 'en' ? 'Guidelines for Investigation' : 'তদন্তের জন্য নির্দেশিকা';
    } else if (currentStatus == 'RECOMMEND_DEPARTMENTAL_ACTION') {
      return langCoe == 'en' ? 'Departmental Action Recommended' : 'বিভাগীয় ব্যবস্থা গ্রহণের সুপারিশকৃত';
    } else if (currentStatus == 'APPEAL_RECOMMMEND_DETARTMENTAL_ACTION') {
      return langCoe == 'en' ? 'Departmental Action Recommended' : 'বিভাগীয় ব্যবস্থা গ্রহণের সুপারিশকৃত';
    } else if (currentStatus == 'REQUEST_TESTIMONY') {
      return langCoe == 'en' ? 'Instruction of Evidence' : 'সাক্ষ্য-প্রমাণের নির্দেশ';
    } else if (currentStatus == 'APPEAL_REQUEST_TESTIMONY') {
      return langCoe == 'en' ? 'Instruction of Evidence' : 'সাক্ষ্য-প্রমাণের নির্দেশ';
    } else if (currentStatus == 'TESTIMONY_GIVEN') {
      return langCoe == 'en' ? 'Evidence Sent' : 'সাক্ষ্য-প্রমাণ প্রেরিত';
    } else if (currentStatus == 'APPEAL_GIVE_GUIDANCE_POST_INVESTIGATION') {
      return langCoe == 'en' ? 'Guidelines for Investigating Appeals' : 'আপীল তদন্তের জন্য নির্দেশিকা';
    } else if (currentStatus == 'CELL_MEETING_PRESENTED') {
      return langCoe == 'en' ? 'Presented at Cell Meeting' : 'সেল মিটিং এ উপস্থাপিত';
    } else if (currentStatus == 'CELL_MEETING_ACCEPTED') {
      return langCoe == 'en' ? 'Adopted in Cell Meeting' : 'সেল সভায় গৃহীত';
    } else if (currentStatus == 'CLOSED_SERVICE_GIVEN') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'CLOSED_ANSWER_OK') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'CLOSED_INSTRUCTION_EXECUTED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'CLOSED_ACCUSATION_INCORRECT') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_SERVICE_GIVEN') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_ANSWER_OK') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_ACCUSATION_INCORRECT') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'CLOSED_ACCUSATION_PROVED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_ACCUSATION_PROVED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_INSTRUCTION_EXECUTED') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'APPEAL_CLOSED_OTHERS') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else if (currentStatus == 'CLOSED_OTHERS') {
      return langCoe == 'en' ? 'Close' : 'নিষ্পত্তি';
    } else {
      return '';
    }
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['submission_date'] = submissionDate;
    map['submission_date_bn'] = submissionDateBn;
    map['complaint_type'] = complaintType;
    map['complaint_type_bn'] = complaintTypeBn;
    map['current_status'] = currentStatus;
    map['current_status_bn'] = currentStatusBn;
    map['subject'] = subject;
    map['details'] = details;
    map['tracking_number'] = trackingNumber;
    map['tracking_number_bn'] = trackingNumberBn;
    map['complainant_id'] = complainantId;
    map['is_grs_user'] = isGrsUser;
    map['office_id'] = officeId;
    map['service_id'] = serviceId;
    map['service_id_before_forward'] = serviceIdBeforeForward;
    map['current_appeal_office_id'] = currentAppealOfficeId;
    map['current_appeal_office_unit_organogram_id'] = currentAppealOfficeUnitOrganogramId;
    map['send_to_ao_office_id'] = sendToAoOfficeId;
    map['is_anonymous'] = isAnonymous;
    map['case_number'] = caseNumber;
    map['other_service'] = otherService;
    map['other_service_before_forward'] = otherServiceBeforeForward;
    map['service_receiver'] = serviceReceiver;
    map['service_receiver_relation'] = serviceReceiverRelation;
    map['gro_decision'] = groDecision;
    map['gro_identified_complaint_cause'] = groIdentifiedComplaintCause;
    map['gro_suggestion'] = groSuggestion;
    map['ao_decision'] = aoDecision;
    map['ao_identified_complaint_cause'] = aoIdentifiedComplaintCause;
    map['ao_suggestion'] = aoSuggestion;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['status'] = status;
    map['rating'] = rating;
    map['appeal_rating'] = appealRating;
    map['is_rating_given'] = isRatingGiven;
    map['is_appeal_rating_given'] = isAppealRatingGiven;
    map['feedback_comments'] = feedbackComments;
    map['appeal_feedback_comments'] = appealFeedbackComments;
    map['source_of_grievance'] = sourceOfGrievance;
    map['is_offline_complaint'] = isOfflineComplaint;
    map['is_self_motivated_grievance'] = isSelfMotivatedGrievance;
    map['uploader_office_unit_organogram_id'] = uploaderOfficeUnitOrganogramId;
    map['possible_close_date'] = possibleCloseDate;
    map['possible_close_date_bn'] = possibleCloseDateBn;
    map['is_evidence_provide'] = isEvidenceProvide;
    map['is_see_hearing_date'] = isSeeHearingDate;
    if (complainedUser != null) map['complainant_info'] = complainedUser?.toJson();
    // if (attachmentInfo != null) map['complaint_attachment_info'] = attachmentInfo?.toJson();
    if (attachmentInfo != null) map['complaint_attachment_info'] = attachmentInfo?.map((attachment) => attachment.toJson()).toList();
    return map;
  }
}
