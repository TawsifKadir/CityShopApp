class GroOfficer {
  int? unit;
  int? employeeRecord;
  dynamic joiningDate;
  int? office;
  int? id;
  String? designation;
  int? organogram;
  dynamic lastDate;
  bool? status;
  int? officeHead;
  String? officeNameEn;
  String? officeNameBn;
  String? unitNameEn;
  String? unitNameBn;
  int? officeMinistryId;
  String? ministryNameBng;
  String? ministryNameEng;
  String? ministryShortName;
  String? ministryReferenceCode;
  int? refOriginUnitOrganogramId;
  String? nameBng;
  String? name;
  String? mobile;
  String? email;
  String? username;

  GroOfficer({
    this.unit,
    this.employeeRecord,
    this.joiningDate,
    this.office,
    this.id,
    this.designation,
    this.organogram,
    this.lastDate,
    this.status,
    this.officeHead,
    this.officeNameEn,
    this.officeNameBn,
    this.unitNameEn,
    this.unitNameBn,
    this.officeMinistryId,
    this.ministryNameBng,
    this.ministryNameEng,
    this.ministryShortName,
    this.ministryReferenceCode,
    this.refOriginUnitOrganogramId,
    this.nameBng,
    this.name,
    this.mobile,
    this.email,
    this.username,
  });

  GroOfficer.fromJson(json) {
    unit = json['unit'];
    employeeRecord = json['employeeRecord'];
    joiningDate = json['joiningDate'];
    office = json['office'];
    id = json['id'];
    designation = json['designation'];
    organogram = json['organogram'];
    lastDate = json['lastDate'];
    status = json['status'];
    officeHead = json['officeHead'];
    officeNameEn = json['officeNameEn'];
    officeNameBn = json['officeNameBn'];
    unitNameEn = json['unitNameEn'];
    unitNameBn = json['unitNameBn'];
    officeMinistryId = json['officeMinistryId'];
    ministryNameBng = json['ministryNameBng'];
    ministryNameEng = json['ministryNameEng'];
    ministryShortName = json['ministryShortName'];
    ministryReferenceCode = json['ministryReferenceCode'];
    refOriginUnitOrganogramId = json['refOriginUnitOrganogramId'];
    nameBng = json['name_bng'];
    name = json['name'];
    mobile = json['mobile'];
    email = json['email'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['unit'] = unit;
    map['employeeRecord'] = employeeRecord;
    map['joiningDate'] = joiningDate;
    map['office'] = office;
    map['id'] = id;
    map['designation'] = designation;
    map['organogram'] = organogram;
    map['lastDate'] = lastDate;
    map['status'] = status;
    map['officeHead'] = officeHead;
    map['officeNameEn'] = officeNameEn;
    map['officeNameBn'] = officeNameBn;
    map['unitNameEn'] = unitNameEn;
    map['unitNameBn'] = unitNameBn;
    map['officeMinistryId'] = officeMinistryId;
    map['ministryNameBng'] = ministryNameBng;
    map['ministryNameEng'] = ministryNameEng;
    map['ministryShortName'] = ministryShortName;
    map['ministryReferenceCode'] = ministryReferenceCode;
    map['refOriginUnitOrganogramId'] = refOriginUnitOrganogramId;
    map['name_bng'] = nameBng;
    map['name'] = name;
    map['mobile'] = mobile;
    map['email'] = email;
    map['username'] = username;
    return map;
  }
}
