import 'package:fl_chart/fl_chart.dart';

class GraphModel {
  double maxX;
  double maxY;
  List<FlSpot> total;
  List<FlSpot> resolved;
  List<FlSpot> time_passed;

  GraphModel({
    required this.maxX,
    required this.maxY,
    required this.total,
    required this.resolved,
    required this.time_passed,
  });

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['maxX'] = maxX;
    map['maxY'] = maxY;
    map['total'] = total;
    map['resolved'] = resolved;
    map['time_passed'] = time_passed;
    return map;
  }
}

GraphModel dummyGraphModel = GraphModel(maxX: 0, maxY: 0, total: [], resolved: [], time_passed: []);
