import 'package:grs/models/branch/branch_office.dart';

class Branch {
  int? id;
  String? label;
  List<BranchOffice>? branchOfficeList;

  Branch({this.id, this.label, this.branchOfficeList});

  Branch.fromJson(json) {
    id = json['id'];
    label = json['label'];
    branchOfficeList = [];
    if (json['nodes'] != null) json['nodes'].forEach((v) => branchOfficeList?.add(BranchOffice.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    if (branchOfficeList != null) map['nodes'] = branchOfficeList?.map((v) => v.toJson()).toList();
    return map;
  }
}
