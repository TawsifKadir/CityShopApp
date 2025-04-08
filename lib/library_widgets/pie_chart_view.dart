import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/di.dart';
import 'package:grs/libraries/formatters.dart';

class PieChartView extends StatelessWidget {
  final int total;
  final int ongoing;
  final int timePassed;
  final int resolved;
  final int touchIndex;
  final Function(FlTouchEvent, PieTouchResponse?)? touchCallback;

  PieChartView({
    required this.touchIndex,
    required this.touchCallback,
    required this.total,
    required this.ongoing,
    required this.timePassed,
    required this.resolved,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: PieChart(
        PieChartData(
          sectionsSpace: 0,
          borderData: FlBorderData(show: false),
          centerSpaceRadius: 35,
          pieTouchData: PieTouchData(touchCallback: touchCallback),
          sections: ongoing < 1 && timePassed < 1 && resolved < 1 ? [_errorData] : _pieChartsData,
        ),
      ),
    );
  }

  List<PieChartSectionData> get _pieChartsData => [
        if (ongoing > 0) _ongoingData,
        if (timePassed > 0) _timePassedData,
        if (resolved > 0) _resolvedData,
      ];

  PieChartSectionData get _ongoingData {
    var isTouched = 0 == touchIndex;
    var value = (100 / total) * ongoing;
    return PieChartSectionData(
      radius: isTouched ? 45 : 35,
      value: value,
      color: teal,
      title: '${sl<Formatters>().localizeNumber('${value.round()}')}%',
      titleStyle: TextStyle(fontSize: isTouched ? 20 : 15, fontWeight: FontWeight.w700, color: white),
    );
  }

  PieChartSectionData get _timePassedData {
    var listIndex = ongoing < 1 ? 0 : 1;
    var isTouched = listIndex == touchIndex;
    var value = (100 / total) * timePassed;
    return PieChartSectionData(
      radius: isTouched ? 45 : 35,
      color: amber,
      value: value,
      title: '${sl<Formatters>().localizeNumber('${value.round()}')}%',
      titleStyle: TextStyle(fontSize: isTouched ? 20 : 15, fontWeight: FontWeight.w700, color: white),
    );
  }

  PieChartSectionData get _resolvedData {
    var listIndex = 2;
    if (ongoing < 1 && timePassed < 1) {
      listIndex = 0;
    } else if (ongoing < 1) {
      listIndex = 1;
    } else if (timePassed < 1) {
      listIndex = 1;
    }

    var isTouched = listIndex == touchIndex;
    var value = (100 / total) * resolved;
    return PieChartSectionData(
      radius: isTouched ? 45 : 35,
      value: value,
      color: red,
      title: '${sl<Formatters>().localizeNumber('${value.round()}')}%',
      titleStyle: TextStyle(fontSize: isTouched ? 20 : 15, fontWeight: FontWeight.w700, color: white),
    );
  }

  PieChartSectionData get _errorData {
    var isTouched = 0 == touchIndex;
    return PieChartSectionData(radius: isTouched ? 45 : 35, color: Colors.deepOrange.withOpacity(0.5), value: 100, showTitle: false);
  }
}
