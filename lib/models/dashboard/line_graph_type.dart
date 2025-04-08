import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class LineGraphType {
  String value;
  String labelBn;
  String labelEn;
  bool isFirst;
  bool isLast;

  String get label => sl<StorageService>().getLanguage == 'bn' ? labelBn : labelEn;

  LineGraphType({
    required this.value,
    required this.labelBn,
    required this.labelEn,
    required this.isFirst,
    required this.isLast,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['labelBn'] = labelBn;
    map['labelEn'] = labelEn;
    map['value'] = value;
    map['isFirst'] = isFirst;
    map['isLast'] = isLast;
    return map;
  }
}

LineGraphType all_chart = LineGraphType(labelBn: 'সকল', labelEn: 'All', value: 'all', isFirst: true, isLast: false);
LineGraphType total_grievance = LineGraphType(labelBn: 'মোট', labelEn: 'Total', value: 'total', isFirst: false, isLast: false);
LineGraphType resolved_grievance =
    LineGraphType(labelBn: 'নিষ্পত্তিকৃত', labelEn: 'Resolved', value: 'resolved', isFirst: false, isLast: false);
LineGraphType time_passed =
    LineGraphType(labelBn: 'সময় অতিক্রান্ত', labelEn: 'Time Passed', value: 'time_passed', isFirst: false, isLast: true);
