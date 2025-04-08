class MovementInfo {
  int? id;
  String? submissionDate;
  dynamic submissionDateBn;
  String? complaintType;
  dynamic complaintTypeBn;
  String? currentStatus;
  dynamic currentStatusBn;
  String? subject;
  String? details;
  String? trackingNumber;
  String? trackingNumberBn;
  int? complainantId;
  int? isGrsUser;
  int? officeId;
  dynamic serviceId;
  dynamic serviceIdBeforeForward;
  dynamic currentAppealOfficeId;
  dynamic currentAppealOfficeUnitOrganogramId;
  dynamic sendToAoOfficeId;
  int? isAnonymous;
  String? caseNumber;
  String? otherService;
  String? otherServiceBeforeForward;
  dynamic serviceReceiver;
  dynamic serviceReceiverRelation;
  dynamic groDecision;
  dynamic groIdentifiedComplaintCause;
  dynamic groSuggestion;
  dynamic aoDecision;
  dynamic aoIdentifiedComplaintCause;
  dynamic aoSuggestion;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic modifiedBy;
  int? status;
  dynamic rating;
  dynamic appealRating;
  dynamic isRatingGiven;
  dynamic isAppealRatingGiven;
  dynamic feedbackComments;
  dynamic appealFeedbackComments;
  dynamic sourceOfGrievance;
  int? isOfflineComplaint;
  int? isSelfMotivatedGrievance;
  dynamic uploaderOfficeUnitOrganogramId;

  MovementInfo({
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
  });

  MovementInfo.fromJson(json) {
    id = json['id'];
    submissionDate = json['submission_date'];
    submissionDateBn = json['submission_date_bn'];
    complaintType = json['complaint_type'];
    complaintTypeBn = json['complaint_type_bn'];
    currentStatus = json['current_status'];
    currentStatusBn = json['current_status_bn'];
    subject = json['subject'];
    details = json['details'];
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
    return map;
  }
}
