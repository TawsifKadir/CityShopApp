import 'package:grs/models/citizen_profile/citizen_profile.dart';

class CitizenProfileApi {
  CitizenProfile? profile;
  String? token;

  CitizenProfileApi({this.profile, this.token});

  CitizenProfileApi.fromJson(json) {
    profile = json['user_info'] != null ? CitizenProfile.fromJson(json['user_info']) : null;
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (profile != null) map['user_info'] = profile?.toJson();
    map['token'] = token;
    return map;
  }
}
