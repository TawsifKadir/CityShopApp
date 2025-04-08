class DummyMinistry {
  int? id;
  String? name;
  List<DummyOfficer>? officers;
  bool? isExpanded;

  DummyMinistry({this.id, this.name, this.officers, this.isExpanded = false});

  DummyMinistry.fromJson(json) {
    id = json['id'];
    name = json['name'];
    officers = [];
    if (json['items'] != null) json['items'].forEach((v) => officers?.add(DummyOfficer.fromJson(v)));
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    if (officers != null) map['items'] = officers?.map((v) => v.toJson()).toList();
    return map;
  }
}

class DummyOfficer {
  int? id;
  String? name;
  String? designation;
  int? parentIndex;
  bool? selected;

  DummyOfficer({this.id, this.name, this.designation, this.selected = false});

  DummyOfficer.fromJson(json) {
    id = json['id'];
    name = json['name'];
    designation = json['designation'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['designation'] = designation;
    return map;
  }
}

final List<DummyMinistry> dummyMinistries = [
  DummyMinistry(id: 1, name: 'Ministry of Finance', officers: _dummyOfficers),
  DummyMinistry(id: 2, name: 'Ministry of Health', officers: _dummyOfficers),
  DummyMinistry(id: 3, name: 'Ministry of Education', officers: _dummyOfficers),
  DummyMinistry(id: 4, name: 'Ministry of Transportation', officers: _dummyOfficers),
  DummyMinistry(id: 5, name: 'Ministry of Energy', officers: _dummyOfficers),
  DummyMinistry(id: 6, name: 'Ministry of Environment', officers: _dummyOfficers),
  DummyMinistry(id: 7, name: 'Ministry of Defense', officers: _dummyOfficers),
];

final List<DummyOfficer> _dummyOfficers = [
  DummyOfficer(id: 1, name: 'John Smith', designation: 'Minister'),
  DummyOfficer(id: 2, name: 'Sarah Johnson', designation: 'Deputy Minister'),
  DummyOfficer(id: 3, name: 'Michael Brown', designation: 'Chief Economist'),
];
