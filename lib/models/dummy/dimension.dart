class Dimension {
  double mobile;
  double? tab;

  Dimension({required this.mobile, this.tab});

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['mobile'] = mobile;
    map['tab'] = tab;
    return map;
  }
}
