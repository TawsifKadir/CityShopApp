import 'package:flutter/material.dart';

import 'package:fl_chart/fl_chart.dart';

import 'package:grs/constants/colors.dart';
import 'package:grs/constants/fonts.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/models/dashboard/graph_grievence.dart';
import 'package:grs/models/dashboard/graph_model.dart';
import 'package:grs/utils/text_styles.dart';

class LineChartView extends StatelessWidget {
  final String graphType;
  final GraphModel graphModel;
  final List<GraphGrievance> charts;

  const LineChartView({required this.graphType, required this.graphModel, required this.charts});

  @override
  Widget build(BuildContext context) {
    var padding = const EdgeInsets.only(left: 8, right: 24);
    return Container(height: 220, padding: padding, child: LineChart(_sampleData2(context), curve: Curves.easeIn));
  }

  LineChartData _sampleData2(BuildContext context) {
    return LineChartData(
      minX: 0,
      minY: 0,
      maxX: graphModel.maxX,
      maxY: graphModel.maxY,
      lineTouchData: _lineTouchData,
      borderData: _borderData,
      lineBarsData: _lineBarsData,
      titlesData: _titlesData(context),
    );
  }

  List<LineChartBarData> get _lineBarsData {
    if (graphType == 'total') {
      return [_total_chart_data];
    } else if (graphType == 'resolved') {
      return [_resolved_chart_data];
    } else if (graphType == 'time_passed') {
      return [_time_passed_ChartData];
    } else {
      return [_total_chart_data, _resolved_chart_data, _time_passed_ChartData];
    }
  }

  FlBorderData get _borderData {
    var t_border = BorderSide(color: primary.withOpacity(0.3));
    return FlBorderData(show: true, border: Border(bottom: t_border, left: t_border, right: t_border, top: t_border));
  }

  FlTitlesData _titlesData(BuildContext context) {
    var left = AxisTitles(sideTitles: _leftTitles);
    var bottom = AxisTitles(sideTitles: _bottomTitles);
    return FlTitlesData(leftTitles: left, bottomTitles: bottom, topTitles: const AxisTitles(), rightTitles: const AxisTitles());
  }

  SideTitles get _leftTitles {
    double interval = graphModel.maxY > 0 ? graphModel.maxY / 5 : 1.0;
    return SideTitles(getTitlesWidget: _leftTitleWidgets, showTitles: true, interval: interval, reservedSize: 40);
  }

  Widget _leftTitleWidgets(double value, TitleMeta meta) {
    return Text(
      '${value.round()}',
      textAlign: TextAlign.center,
      style: sl<TextStyles>().text14_400(black),
    );
  }

  SideTitles get _bottomTitles {
    double interval = graphModel.maxX > 0 ? graphModel.maxX / 5 : 1.0;
    return SideTitles(showTitles: true, reservedSize: 24, interval: interval, getTitlesWidget: _bottomTitleWidgets);
  }

  Widget _bottomTitleWidgets(double value, TitleMeta meta) {
    var month = charts[value.toInt()].month ?? '';
    return SideTitleWidget(axisSide: meta.axisSide, child: Text(month.translate, style: sl<TextStyles>().text14_400(black)));
  }

  LineChartBarData get _total_chart_data {
    return LineChartBarData(
      isCurved: true,
      color: blue,
      barWidth: 1.5,
      isStrokeCapRound: true,
      spots: graphModel.total,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: blue.withOpacity(0.12)),
    );
  }

  LineChartBarData get _resolved_chart_data {
    return LineChartBarData(
      isCurved: true,
      color: teal,
      barWidth: 1.5,
      isStrokeCapRound: true,
      spots: graphModel.resolved,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: teal.withOpacity(0.12)),
    );
  }

  LineChartBarData get _time_passed_ChartData {
    return LineChartBarData(
      isCurved: true,
      color: amber,
      barWidth: 1.5,
      isStrokeCapRound: true,
      spots: graphModel.time_passed,
      dotData: const FlDotData(show: false),
      belowBarData: BarAreaData(show: true, color: amber.withOpacity(0.12)),
    );
  }

  LineTouchData get _lineTouchData {
    var padding = const EdgeInsets.symmetric(horizontal: 06, vertical: 04);
    return LineTouchData(
      getTouchLineEnd: (_, __) => double.infinity,
      touchTooltipData: LineTouchTooltipData(
        tooltipMargin: 4,
        tooltipRoundedRadius: 5,
        tooltipPadding: padding,
        fitInsideVertically: true,
        fitInsideHorizontally: true,
        showOnTopOfTheChartBoxArea: true,
        tooltipBgColor: _getBackgroundColor,
        tooltipHorizontalAlignment: FLHorizontalAlignment.right,
        getTooltipItems: (chartList) {
          List<LineTooltipItem> tooltips = [];
          for (int index = 0; index < chartList.length; index++) {
            var spot = chartList[index].y.ceil();
            var label = _getTitle(index);
            var value = sl<Formatters>().localizeNumber(spot > 9 ? '$spot' : '0$spot');
            var lineItem = LineTooltipItem('$label: $value', textAlign: TextAlign.start, const TextStyle(color: black, fontWeight: w900));
            tooltips.add(lineItem);
          }
          return tooltips;
        },
      ),
    );
  }

  Color get _getBackgroundColor {
    if (graphType == 'total') {
      return blue.withOpacity(0.1);
    } else if (graphType == 'resolved') {
      return teal.withOpacity(0.1);
    } else if (graphType == 'time_passed') {
      return amber.withOpacity(0.1);
    } else {
      return teal.withOpacity(0.1);
    }
  }

  String _getTitle(int index) {
    if (index == 0) {
      return 'Total Grievance'.translate;
    } else if (index == 1) {
      return 'Time Passed'.translate;
    } else {
      return 'Resolved'.translate;
    }
  }
}
