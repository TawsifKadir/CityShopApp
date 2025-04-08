import 'package:grs/models/branch/branch.dart';

class BranchApi {
  String? status;
  List<Branch>? branchList;

  BranchApi({this.status, this.branchList});

  BranchApi.fromJson(json) {
    status = json['status'];
    branchList = [];
    if (json['data'] != null) json['data'].forEach((v) => branchList?.add(Branch.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    if (branchList != null) map['data'] = branchList?.map((v) => v.toJson()).toList();
    return map;
  }
}
