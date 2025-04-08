import 'qualification.dart';

class QualificationApi {
  String? status;
  List<Qualification>? qualifications;

  QualificationApi({this.status, this.qualifications});

  QualificationApi.fromJson(json) {
    status = json['status'];
    qualifications = [];
    if (json['data'] != null) json['data'].forEach((v) => qualifications!.add(Qualification.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (qualifications != null) map['data'] = qualifications!.map((v) => v.toJson()).toList();
    return map;
  }
}
