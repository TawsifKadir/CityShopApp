import 'package:grs/models/officer_profile/officer_profile_info.dart';

class OfficerProfileApi {
  OfficerProfileInfo? profileInfo;
  String? userType;
  String? token;

  OfficerProfileApi({this.profileInfo, this.userType, this.token});

  OfficerProfileApi.fromJson(json) {
    profileInfo = json['user_info'] != null ? OfficerProfileInfo.fromJson(json['user_info']) : null;
    userType = json['user_type'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profileInfo != null) map['user_info'] = profileInfo?.toJson();
    map['user_type'] = userType;
    map['token'] = token;
    return map;
  }
}
