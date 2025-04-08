class OrganogramInfo {
  int? id;
  int? officeId;
  int? officeUnitId;
  int? superiorUnitId;
  int? superiorDesignationId;
  int? refOriginUnitOrgId;
  int? refSupOriginUnitDesigId;
  int? refSupOriginUnitId;
  String? designationEng;
  String? designationBng;
  String? shortNameEng;
  String? shortNameBng;
  int? designationLevel;
  int? designationSequence;
  dynamic designationDescription;
  bool? status;
  bool? isAdmin;
  bool? isUnitAdmin;
  bool? isUnitHead;
  bool? isOfficeHead;
  int? createdBy;
  int? modifiedBy;
  String? created;
  String? modified;

  OrganogramInfo({
    this.id,
    this.officeId,
    this.officeUnitId,
    this.superiorUnitId,
    this.superiorDesignationId,
    this.refOriginUnitOrgId,
    this.refSupOriginUnitDesigId,
    this.refSupOriginUnitId,
    this.designationEng,
    this.designationBng,
    this.shortNameEng,
    this.shortNameBng,
    this.designationLevel,
    this.designationSequence,
    this.designationDescription,
    this.status,
    this.isAdmin,
    this.isUnitAdmin,
    this.isUnitHead,
    this.isOfficeHead,
    this.createdBy,
    this.modifiedBy,
    this.created,
    this.modified,
  });

  OrganogramInfo.fromJson(json) {
    id = json['id'];
    officeId = json['office_id'];
    officeUnitId = json['office_unit_id'];
    superiorUnitId = json['superior_unit_id'];
    superiorDesignationId = json['superior_designation_id'];
    refOriginUnitOrgId = json['ref_origin_unit_org_id'];
    refSupOriginUnitDesigId = json['ref_sup_origin_unit_desig_id'];
    refSupOriginUnitId = json['ref_sup_origin_unit_id'];
    designationEng = json['designation_eng'];
    designationBng = json['designation_bng'];
    shortNameEng = json['short_name_eng'];
    shortNameBng = json['short_name_bng'];
    designationLevel = json['designation_level'];
    designationSequence = json['designation_sequence'];
    designationDescription = json['designation_description'];
    status = json['status'];
    isAdmin = json['is_admin'];
    isUnitAdmin = json['is_unit_admin'];
    isUnitHead = json['is_unit_head'];
    isOfficeHead = json['is_office_head'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    created = json['created'];
    modified = json['modified'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_id'] = officeId;
    map['office_unit_id'] = officeUnitId;
    map['superior_unit_id'] = superiorUnitId;
    map['superior_designation_id'] = superiorDesignationId;
    map['ref_origin_unit_org_id'] = refOriginUnitOrgId;
    map['ref_sup_origin_unit_desig_id'] = refSupOriginUnitDesigId;
    map['ref_sup_origin_unit_id'] = refSupOriginUnitId;
    map['designation_eng'] = designationEng;
    map['designation_bng'] = designationBng;
    map['short_name_eng'] = shortNameEng;
    map['short_name_bng'] = shortNameBng;
    map['designation_level'] = designationLevel;
    map['designation_sequence'] = designationSequence;
    map['designation_description'] = designationDescription;
    map['status'] = status;
    map['is_admin'] = isAdmin;
    map['is_unit_admin'] = isUnitAdmin;
    map['is_unit_head'] = isUnitHead;
    map['is_office_head'] = isOfficeHead;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['created'] = created;
    map['modified'] = modified;
    return map;
  }
}
