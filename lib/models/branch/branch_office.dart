import 'package:grs/models/branch/officer.dart';

class BranchOffice {
  int? id;
  String? label;
  List<Officer>? officers;
  bool? isExpanded;

  BranchOffice({this.id, this.label, this.officers, this.isExpanded = false});

  BranchOffice.fromJson(json) {
    id = json['id'];
    label = json['label'];
    officers = [];
    if (json['nodes'] != null) json['nodes'].forEach((v) => officers?.add(Officer.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    if (officers != null) map['nodes'] = officers?.map((v) => v.toJson()).toList();
    return map;
  }
}
