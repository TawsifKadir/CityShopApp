import 'package:grs/models/officer_profile/change_pass.dart';

class UserNotification {
  UserNotification({this.changePass});

  UserNotification.fromJson(json) {
    changePass = json['forcefully_change_password'] != null ? ChangePass.fromJson(json['forcefully_change_password']) : null;
  }

  ChangePass? changePass;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (changePass != null) map['forcefully_change_password'] = changePass?.toJson();
    return map;
  }
}
