class OfficerProfile {
  int? id;
  String? username;
  String? userAlias;
  bool? active;
  int? employeeRecordId;
  String? lastPasswordChange;
  dynamic failedAttemptLimitExceedTime;

  OfficerProfile({
    this.id,
    this.username,
    this.userAlias,
    this.active,
    this.employeeRecordId,
    this.lastPasswordChange,
    this.failedAttemptLimitExceedTime,
  });

  OfficerProfile.fromJson(json) {
    id = json['id'];
    username = json['username'];
    userAlias = json['user_alias'];
    active = json['active'];
    employeeRecordId = json['employee_record_id'];
    lastPasswordChange = json['last_password_change'];
    failedAttemptLimitExceedTime = json['failed_attempt_limit_exceed_time'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['username'] = username;
    map['user_alias'] = userAlias;
    map['active'] = active;
    map['employee_record_id'] = employeeRecordId;
    map['last_password_change'] = lastPasswordChange;
    map['failed_attempt_limit_exceed_time'] = failedAttemptLimitExceedTime;
    return map;
  }
}
