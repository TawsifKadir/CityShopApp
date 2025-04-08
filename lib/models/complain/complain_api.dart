import 'package:grs/models/complain/complain.dart';

class ComplainApi {
  String? status;
  List<Complain>? complains;
  int? totalPages;

  ComplainApi({this.status, this.complains});

  ComplainApi.fromJson(json) {
    status = json['status'];
    complains = [];
    totalPages = json['noOfPages'] ?? 0;
    if (json['data'] != null) json['data'].forEach((v) => complains?.add(Complain.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['noOfPages'] = totalPages ?? 0;
    if (complains != null) map['data'] = complains?.map((v) => v.toJson()).toList();
    return map;
  }
}
