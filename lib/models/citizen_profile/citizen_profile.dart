class CitizenProfile {
  int? id;
  String? name;
  String? identificationValue;
  String? identificationType;
  String? mobileNumber;
  String? email;
  String? birthDate;
  String? occupation;
  String? educationalQualification;
  dynamic gender;
  String? username;
  int? nationalityId;
  dynamic presentAddressStreet;
  dynamic presentAddressHouse;
  dynamic presentAddressDivisionId;
  dynamic presentAddressDivisionNameBng;
  dynamic presentAddressDivisionNameEng;
  dynamic presentAddressDistrictId;
  dynamic presentAddressDistrictNameBng;
  dynamic presentAddressDistrictNameEng;
  dynamic presentAddressTypeId;
  dynamic presentAddressTypeNameBng;
  dynamic presentAddressTypeNameEng;
  dynamic presentAddressTypeValue;
  dynamic presentAddressPostalCode;
  dynamic isBlacklisted;
  String? permanentAddressStreet;
  String? permanentAddressHouse;
  dynamic permanentAddressDivisionId;
  dynamic permanentAddressDivisionNameBng;
  dynamic permanentAddressDivisionNameEng;
  dynamic permanentAddressDistrictId;
  dynamic permanentAddressDistrictNameBng;
  dynamic permanentAddressDistrictNameEng;
  dynamic permanentAddressTypeId;
  dynamic permanentAddressTypeNameBng;
  dynamic permanentAddressTypeNameEng;
  dynamic permanentAddressTypeValue;
  dynamic permanentAddressPostalCode;
  dynamic foreignPermanentAddressZipcode;
  dynamic foreignPermanentAddressState;
  dynamic foreignPermanentAddressCity;
  dynamic foreignPermanentAddressLine2;
  dynamic foreignPermanentAddressLine1;
  dynamic foreignPresentAddressZipcode;
  dynamic foreignPresentAddressState;
  dynamic foreignPresentAddressCity;
  dynamic foreignPresentAddressLine2;
  dynamic foreignPresentAddressLine1;
  int? isAuthenticated;
  String? createdAt;
  String? updatedAt;
  dynamic createdBy;
  dynamic modifiedBy;
  dynamic status;
  dynamic presentAddressCountryId;
  int? permanentAddressCountryId;
  dynamic blacklisterOfficeId;
  dynamic blacklisterOfficeName;
  dynamic blacklistReason;
  dynamic isRequested;

  CitizenProfile({
    this.id,
    this.name,
    this.identificationValue,
    this.identificationType,
    this.mobileNumber,
    this.email,
    this.birthDate,
    this.occupation,
    this.educationalQualification,
    this.gender,
    this.username,
    this.nationalityId,
    this.presentAddressStreet,
    this.presentAddressHouse,
    this.presentAddressDivisionId,
    this.presentAddressDivisionNameBng,
    this.presentAddressDivisionNameEng,
    this.presentAddressDistrictId,
    this.presentAddressDistrictNameBng,
    this.presentAddressDistrictNameEng,
    this.presentAddressTypeId,
    this.presentAddressTypeNameBng,
    this.presentAddressTypeNameEng,
    this.presentAddressTypeValue,
    this.presentAddressPostalCode,
    this.isBlacklisted,
    this.permanentAddressStreet,
    this.permanentAddressHouse,
    this.permanentAddressDivisionId,
    this.permanentAddressDivisionNameBng,
    this.permanentAddressDivisionNameEng,
    this.permanentAddressDistrictId,
    this.permanentAddressDistrictNameBng,
    this.permanentAddressDistrictNameEng,
    this.permanentAddressTypeId,
    this.permanentAddressTypeNameBng,
    this.permanentAddressTypeNameEng,
    this.permanentAddressTypeValue,
    this.permanentAddressPostalCode,
    this.foreignPermanentAddressZipcode,
    this.foreignPermanentAddressState,
    this.foreignPermanentAddressCity,
    this.foreignPermanentAddressLine2,
    this.foreignPermanentAddressLine1,
    this.foreignPresentAddressZipcode,
    this.foreignPresentAddressState,
    this.foreignPresentAddressCity,
    this.foreignPresentAddressLine2,
    this.foreignPresentAddressLine1,
    this.isAuthenticated,
    this.createdAt,
    this.updatedAt,
    this.createdBy,
    this.modifiedBy,
    this.status,
    this.presentAddressCountryId,
    this.permanentAddressCountryId,
    this.blacklisterOfficeId,
    this.blacklisterOfficeName,
    this.blacklistReason,
    this.isRequested,
  });

  CitizenProfile.fromJson(json) {
    id = json['id'];
    name = json['name'];
    identificationValue = json['identification_value'];
    identificationType = json['identification_type'];
    mobileNumber = json['mobile_number'];
    email = json['email'];
    birthDate = json['birth_date'];
    occupation = json['occupation'];
    educationalQualification = json['educational_qualification'];
    gender = json['gender'];
    username = json['username'];
    nationalityId = json['nationality_id'];
    presentAddressStreet = json['present_address_street'];
    presentAddressHouse = json['present_address_house'];
    presentAddressDivisionId = json['present_address_division_id'];
    presentAddressDivisionNameBng = json['present_address_division_name_bng'];
    presentAddressDivisionNameEng = json['present_address_division_name_eng'];
    presentAddressDistrictId = json['present_address_district_id'];
    presentAddressDistrictNameBng = json['present_address_district_name_bng'];
    presentAddressDistrictNameEng = json['present_address_district_name_eng'];
    presentAddressTypeId = json['present_address_type_id'];
    presentAddressTypeNameBng = json['present_address_type_name_bng'];
    presentAddressTypeNameEng = json['present_address_type_name_eng'];
    presentAddressTypeValue = json['present_address_type_value'];
    presentAddressPostalCode = json['present_address_postal_code'];
    isBlacklisted = json['is_blacklisted'];
    permanentAddressStreet = json['permanent_address_street'];
    permanentAddressHouse = json['permanent_address_house'];
    permanentAddressDivisionId = json['permanent_address_division_id'];
    permanentAddressDivisionNameBng = json['permanent_address_division_name_bng'];
    permanentAddressDivisionNameEng = json['permanent_address_division_name_eng'];
    permanentAddressDistrictId = json['permanent_address_district_id'];
    permanentAddressDistrictNameBng = json['permanent_address_district_name_bng'];
    permanentAddressDistrictNameEng = json['permanent_address_district_name_eng'];
    permanentAddressTypeId = json['permanent_address_type_id'];
    permanentAddressTypeNameBng = json['permanent_address_type_name_bng'];
    permanentAddressTypeNameEng = json['permanent_address_type_name_eng'];
    permanentAddressTypeValue = json['permanent_address_type_value'];
    permanentAddressPostalCode = json['permanent_address_postal_code'];
    foreignPermanentAddressZipcode = json['foreign_permanent_address_zipcode'];
    foreignPermanentAddressState = json['foreign_permanent_address_state'];
    foreignPermanentAddressCity = json['foreign_permanent_address_city'];
    foreignPermanentAddressLine2 = json['foreign_permanent_address_line2'];
    foreignPermanentAddressLine1 = json['foreign_permanent_address_line1'];
    foreignPresentAddressZipcode = json['foreign_present_address_zipcode'];
    foreignPresentAddressState = json['foreign_present_address_state'];
    foreignPresentAddressCity = json['foreign_present_address_city'];
    foreignPresentAddressLine2 = json['foreign_present_address_line2'];
    foreignPresentAddressLine1 = json['foreign_present_address_line1'];
    isAuthenticated = json['is_authenticated'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdBy = json['created_by'];
    modifiedBy = json['modified_by'];
    status = json['status'];
    presentAddressCountryId = json['present_address_country_id'];
    permanentAddressCountryId = json['permanent_address_country_id'];
    blacklisterOfficeId = json['blacklister_office_id'];
    blacklisterOfficeName = json['blacklister_office_name'];
    blacklistReason = json['blacklist_reason'];
    isRequested = json['is_requested'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['identification_value'] = identificationValue;
    map['identification_type'] = identificationType;
    map['mobile_number'] = mobileNumber;
    map['email'] = email;
    map['birth_date'] = birthDate;
    map['occupation'] = occupation;
    map['educational_qualification'] = educationalQualification;
    map['gender'] = gender;
    map['username'] = username;
    map['nationality_id'] = nationalityId;
    map['present_address_street'] = presentAddressStreet;
    map['present_address_house'] = presentAddressHouse;
    map['present_address_division_id'] = presentAddressDivisionId;
    map['present_address_division_name_bng'] = presentAddressDivisionNameBng;
    map['present_address_division_name_eng'] = presentAddressDivisionNameEng;
    map['present_address_district_id'] = presentAddressDistrictId;
    map['present_address_district_name_bng'] = presentAddressDistrictNameBng;
    map['present_address_district_name_eng'] = presentAddressDistrictNameEng;
    map['present_address_type_id'] = presentAddressTypeId;
    map['present_address_type_name_bng'] = presentAddressTypeNameBng;
    map['present_address_type_name_eng'] = presentAddressTypeNameEng;
    map['present_address_type_value'] = presentAddressTypeValue;
    map['present_address_postal_code'] = presentAddressPostalCode;
    map['is_blacklisted'] = isBlacklisted;
    map['permanent_address_street'] = permanentAddressStreet;
    map['permanent_address_house'] = permanentAddressHouse;
    map['permanent_address_division_id'] = permanentAddressDivisionId;
    map['permanent_address_division_name_bng'] = permanentAddressDivisionNameBng;
    map['permanent_address_division_name_eng'] = permanentAddressDivisionNameEng;
    map['permanent_address_district_id'] = permanentAddressDistrictId;
    map['permanent_address_district_name_bng'] = permanentAddressDistrictNameBng;
    map['permanent_address_district_name_eng'] = permanentAddressDistrictNameEng;
    map['permanent_address_type_id'] = permanentAddressTypeId;
    map['permanent_address_type_name_bng'] = permanentAddressTypeNameBng;
    map['permanent_address_type_name_eng'] = permanentAddressTypeNameEng;
    map['permanent_address_type_value'] = permanentAddressTypeValue;
    map['permanent_address_postal_code'] = permanentAddressPostalCode;
    map['foreign_permanent_address_zipcode'] = foreignPermanentAddressZipcode;
    map['foreign_permanent_address_state'] = foreignPermanentAddressState;
    map['foreign_permanent_address_city'] = foreignPermanentAddressCity;
    map['foreign_permanent_address_line2'] = foreignPermanentAddressLine2;
    map['foreign_permanent_address_line1'] = foreignPermanentAddressLine1;
    map['foreign_present_address_zipcode'] = foreignPresentAddressZipcode;
    map['foreign_present_address_state'] = foreignPresentAddressState;
    map['foreign_present_address_city'] = foreignPresentAddressCity;
    map['foreign_present_address_line2'] = foreignPresentAddressLine2;
    map['foreign_present_address_line1'] = foreignPresentAddressLine1;
    map['is_authenticated'] = isAuthenticated;
    map['created_at'] = createdAt;
    map['updated_at'] = updatedAt;
    map['created_by'] = createdBy;
    map['modified_by'] = modifiedBy;
    map['status'] = status;
    map['present_address_country_id'] = presentAddressCountryId;
    map['permanent_address_country_id'] = permanentAddressCountryId;
    map['blacklister_office_id'] = blacklisterOfficeId;
    map['blacklister_office_name'] = blacklisterOfficeName;
    map['blacklist_reason'] = blacklistReason;
    map['is_requested'] = isRequested;
    return map;
  }
}
