import 'package:grs/models/country/country.dart';

class CountryApi {
  String? status;
  List<Country>? nationalities;

  CountryApi({this.status, this.nationalities});

  CountryApi.fromJson(json) {
    status = json['status'];
    nationalities = [];
    if (json['data'] != null) json['data'].forEach((v) => nationalities?.add(Country.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (nationalities != null) map['data'] = nationalities?.map((v) => v.toJson()).toList();
    return map;
  }
}
