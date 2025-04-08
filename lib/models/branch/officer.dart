class Officer {
  int? id;
  int? officeId;
  String? officeNameBng;
  int? officeUnitOrganogramId;
  int? officeUnitId;
  dynamic employeeRecordId;
  String? label;
  String? designation;
  String? unitNameBng;
  String? name;
  String? nameEn;
  bool? selected;
  bool? isCommitteeHead;
  bool? isRecipient;

  Officer({
    this.id,
    this.officeId,
    this.officeNameBng,
    this.officeUnitOrganogramId,
    this.officeUnitId,
    this.employeeRecordId,
    this.label,
    this.designation,
    this.unitNameBng,
    this.name,
    this.nameEn,
    this.selected = false,
    this.isCommitteeHead = false,
    this.isRecipient = false,
  });

  Officer.fromJson(json) {
    id = json['id'];
    officeId = json['office_id'];
    officeNameBng = json['office_name_bng'];
    officeUnitOrganogramId = json['office_unit_organogram_id'];
    officeUnitId = json['office_unit_id'];
    employeeRecordId = json['employee_record_id'];
    label = json['label'];
    designation = json['designation'];
    unitNameBng = json['unit_name_bng'];
    name = json['name'];
    nameEn = json['name_en'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['office_id'] = officeId;
    map['office_name_bng'] = officeNameBng;
    map['office_unit_organogram_id'] = officeUnitOrganogramId;
    map['office_unit_id'] = officeUnitId;
    map['employee_record_id'] = employeeRecordId;
    map['label'] = label;
    map['designation'] = designation;
    map['unit_name_bng'] = unitNameBng;
    map['name'] = name;
    map['name_en'] = nameEn;
    map['selected'] = selected;
    map['isCommitteeHead'] = isCommitteeHead;
    map['isRecipient'] = isRecipient;
    return map;
  }
}
