import 'package:fl_chart/fl_chart.dart';

import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/dashboard/graph_grievence.dart';

class GraphHelper {
  Map<String, double> getMaxValues(Map<String, List<FlSpot>> spots) {
    List<FlSpot> total = spots['total']!;
    List<FlSpot> resolved = spots['resolved']!;
    List<FlSpot> time_passed = spots['time_passed']!;

    var max_total_x = total.reduce((item1, item2) => item1.x > item2.x ? item1 : item2).x;
    var max_total_y = total.reduce((item1, item2) => item1.y > item2.y ? item1 : item2).y;

    var max_resolved_x = resolved.reduce((item1, item2) => item1.x > item2.x ? item1 : item2).x;
    var max_resolved_y = resolved.reduce((item1, item2) => item1.y > item2.y ? item1 : item2).y;

    var max_time_passed_x = time_passed.reduce((item1, item2) => item1.x > item2.x ? item1 : item2).x;
    var max_time_passed_y = time_passed.reduce((item1, item2) => item1.y > item2.y ? item1 : item2).y;

    var maxList_x = [max_total_x, max_resolved_x, max_time_passed_x];
    var maxList_y = [max_total_y, max_resolved_y, max_time_passed_y];

    var max_x = maxList_x.reduce((item1, item2) => item1 > item2 ? item1 : item2);
    var max_y = maxList_y.reduce((item1, item2) => item1 > item2 ? item1 : item2);
    return {'max_x': max_x, 'max_y': max_y + 10};
  }

  Map<String, List<FlSpot>> getSpots(List<GraphGrievance> graphData) {
    if (!graphData.haveList) return {'total': [], 'resolved': [], 'time_passed': []};
    List<FlSpot> total = [];
    List<FlSpot> resolved = [];
    List<FlSpot> timePassed = [];
    graphData.asMap().entries.forEach((item) {
      var xAxisValue = item.key.toDouble();
      total.add(FlSpot(xAxisValue, _getYAxisValue(item.value.totalComplaint)));
      resolved.add(FlSpot(xAxisValue, _getYAxisValue(item.value.closedComplaint)));
      timePassed.add(FlSpot(xAxisValue, _getYAxisValue(item.value.timePassedComplaint)));
    });
    return {'total': total, 'resolved': resolved, 'time_passed': timePassed};
  }

  double _getYAxisValue(int? chartValue) => chartValue == null ? 0.0 : chartValue.toDouble();
}
