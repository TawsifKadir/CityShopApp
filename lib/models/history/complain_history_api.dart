import 'package:grs/models/history/complain_history.dart';

class ComplainHistoryApi {
  String? status;
  List<ComplainHistory>? histories;

  ComplainHistoryApi({this.status, this.histories});

  ComplainHistoryApi.fromJson(json) {
    status = json['status'];
    histories = [];
    if (json['data'] != null) json['data'].forEach((v) => histories?.add(ComplainHistory.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (histories != null) map['data'] = histories?.map((v) => v.toJson()).toList();
    return map;
  }
}
