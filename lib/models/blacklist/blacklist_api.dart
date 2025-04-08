import 'package:grs/models/blacklist/blacklist.dart';

class BlacklistApi {
  String? status;
  List<Blacklist>? blacklists;

  BlacklistApi({this.status, this.blacklists});

  BlacklistApi.fromJson(json) {
    status = json['status'];
    blacklists = [];
    if (json['data'] != null) json['data'].forEach((v) => blacklists?.add(Blacklist.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (blacklists != null) map['data'] = blacklists?.map((v) => v.toJson()).toList();
    return map;
  }
}
