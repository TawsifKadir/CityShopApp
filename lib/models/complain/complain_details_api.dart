import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/complain/complained_user.dart';
import 'package:grs/models/doptor_apis/office.dart';

class ComplainDetailsApi {
  ComplainedUser? complainedUser;
  Complain? complain;
  Office? office;

  ComplainDetailsApi({this.complain, this.office, this.complainedUser});

  ComplainDetailsApi.fromJson(json) {
    complainedUser = json['complainant_info'] != null ? ComplainedUser.fromJson(json['complainant_info']) : null;
    complain = json['allComplaintDetails'] != null ? Complain.fromJson(json['allComplaintDetails']) : null;
    office = json['doptoroffice'] != null ? Office.fromJson(json['doptoroffice']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (complainedUser != null) map['complainant_info'] = complainedUser?.toJson();
    if (complain != null) map['allComplaintDetails'] = complain?.toJson();
    if (office != null) map['doptoroffice'] = office?.toJson();
    return map;
  }
}
