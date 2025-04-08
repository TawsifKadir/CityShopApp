import 'package:grs/models/branch/branch_office.dart';

class SubordinateOffice {
  int? id;
  String? label;
  List<BranchOffice>? branchOffices;
  bool? isExpanded;

  SubordinateOffice({this.id, this.label, this.branchOffices, this.isExpanded = false});

  SubordinateOffice.fromJson(json) {
    id = json['id'];
    label = json['label'];
    branchOffices = [];
    if (json['nodes'] != null) json['nodes'].forEach((v) => branchOffices?.add(BranchOffice.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['label'] = label;
    if (branchOffices != null) map['nodes'] = branchOffices?.map((v) => v.toJson()).toList();
    return map;
  }
}
