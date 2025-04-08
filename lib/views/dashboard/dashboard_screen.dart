import 'package:flutter/material.dart';
import 'package:grs/components/app_loaders/refresh_loader.dart';

import 'package:provider/provider.dart';

import 'package:grs/components/app_loaders/screen_loader.dart';
import 'package:grs/components/app_menus/back_menu.dart';
import 'package:grs/components/app_menus/language_menu.dart';
import 'package:grs/components/list_views/dashboard/service_complain_count_list.dart';
import 'package:grs/constants/colors.dart';
import 'package:grs/core_widgets/linear_progressbar.dart';
import 'package:grs/core_widgets/responsive.dart';
import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/libraries/formatters.dart';
import 'package:grs/library_widgets/line_chart_view.dart';
import 'package:grs/library_widgets/pie_chart_view.dart';
import 'package:grs/models/dashboard/line_graph_type.dart';
import 'package:grs/utils/app_config.dart';
import 'package:grs/utils/size_config.dart';
import 'package:grs/utils/text_styles.dart';
import 'package:grs/view_models/dashboard/dashboard_view_model.dart';

class DashboardScreen extends StatefulWidget {
  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var viewModel = DashboardViewModel();
  var modelData = DashboardViewModel();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) => viewModel.initViewModel());
    super.initState();
  }

  @override
  void didChangeDependencies() {
    viewModel = Provider.of<DashboardViewModel>(context, listen: false);
    modelData = Provider.of<DashboardViewModel>(context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    viewModel.disposeViewModel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        leading: const BackMenu(),
        automaticallyImplyLeading: false,
        title: Text('Dashboard'.translate),
        actions: [Center(child: LanguageMenu()), const SizedBox(width: appbarAction)],
      ),
      body: Container(
        width: SizeConfig.width,
        height: SizeConfig.height,
        child: Stack(children: [Responsive(mobile: _mobileView(context)), if (modelData.loader.common) ScreenLoader()]),
      ),
    );
  }

  Widget _mobileView(BuildContext context) {
    if (modelData.loader.initial) return const SizedBox.shrink();
    var radius = BorderRadius.circular(06);
    var border = Border.all(color: primary.withOpacity(0.2));
    var dashboard = modelData.dashboard;
    var totalComplaint = sl<Formatters>().localizeNumber('${dashboard.totalComplaint ?? 0}');
    var appealComplaint = sl<Formatters>().localizeNumber('${dashboard.totalAppeal ?? 0}');
    return CustomRefreshContainer(
      onRefresh: () async {
        await viewModel.refreshDashboardData();
      },
      child: ListView(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
        children: [
          const SizedBox(height: 16),
          Container(
            width: SizeConfig.width,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(color: white, borderRadius: radius, border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Total Grievance'.translate, style: sl<TextStyles>().text16_600(black)),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 06, vertical: 02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(04), color: blue.withOpacity(0.05)),
                      child: Text(totalComplaint, style: sl<TextStyles>().text15_600(blue)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: PieChartView(
                        total: dashboard.totalComplaint ?? 1,
                        ongoing: dashboard.runningComplaint ?? 0,
                        resolved: dashboard.closedComplaint ?? 0,
                        timePassed: dashboard.timePassedComplaint ?? 0,
                        touchIndex: modelData.totalTouchIndex,
                        touchCallback: viewModel.totalTouchCallback,
                      ),
                    ),
                    Expanded(child: Container()),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _complainItem(color: teal, label: 'Ongoing'.translate, value: '${dashboard.runningComplaint ?? 0}'),
                          const SizedBox(height: 10),
                          _complainItem(color: amber, label: 'Over Due'.translate, value: '${dashboard.timePassedComplaint ?? 0}'),
                          const SizedBox(height: 10),
                          _complainItem(color: red, label: 'Resolved'.translate, value: '${dashboard.closedComplaint ?? 0}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: SizeConfig.width,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(color: white, borderRadius: radius, border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Appealed Grievance'.translate, style: sl<TextStyles>().text16_600(black)),
                    const Spacer(),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 06, vertical: 02),
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(04), color: red.withOpacity(0.05)),
                      child: Text(appealComplaint, style: sl<TextStyles>().text15_600(red)),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: PieChartView(
                        total: dashboard.totalAppeal ?? 1,
                        ongoing: dashboard.runningAppeal ?? 0,
                        resolved: dashboard.closedAppeal ?? 0,
                        timePassed: dashboard.timePassedAppeal ?? 0,
                        touchIndex: modelData.appliedTouchIndex,
                        touchCallback: viewModel.appliedTouchCallback,
                      ),
                    ),
                    Expanded(child: Container()),
                    Expanded(
                      flex: 10,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _complainItem(color: teal, label: 'Ongoing'.translate, value: '${dashboard.runningAppeal ?? 0}'),
                          const SizedBox(height: 10),
                          _complainItem(color: amber, label: 'Over Due'.translate, value: '${dashboard.timePassedAppeal ?? 0}'),
                          const SizedBox(height: 10),
                          _complainItem(color: red, label: 'Resolved'.translate, value: '${dashboard.closedAppeal ?? 0}'),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: SizeConfig.width,
            margin: const EdgeInsets.symmetric(horizontal: 24),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(color: white, borderRadius: radius, border: border),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _LinearRatingItem(title: 'Grievance Disposal Rate'.translate, color: green, value: dashboard.grievanceDisposalRate ?? 0),
                const SizedBox(height: 12),
                _LinearRatingItem(title: 'Appeal Rate'.translate, color: blue, value: dashboard.appealRate ?? 0),
                const SizedBox(height: 12),
                _LinearRatingItem(title: 'Total Response'.translate, color: primary, value: dashboard.totalResponse ?? 0),
                const SizedBox(height: 12),
                _LinearRatingItem(title: 'Average Rating'.translate, color: amber, value: dashboard.averageRating ?? 0),
              ],
            ),
          ),
          if (modelData.dashboard.graphGrievanceList.haveList) const SizedBox(height: 20),
          if (modelData.dashboard.graphGrievanceList.haveList)
            Container(
              height: 38,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: white, borderRadius: radius, border: Border.all(color: primary.withOpacity(0.5))),
              child: Row(
                children: [
                  Expanded(flex: 3, child: _GraphTypeCard(graphType: all_chart)),
                  Container(height: 38, width: 1, color: primary.withOpacity(0.5)),
                  Expanded(flex: 5, child: _GraphTypeCard(graphType: total_grievance)),
                  Container(height: 38, width: 1, color: primary.withOpacity(0.5)),
                  Expanded(flex: 6, child: _GraphTypeCard(graphType: resolved_grievance)),
                  Container(height: 38, width: 1, color: primary.withOpacity(0.5)),
                  Expanded(flex: 7, child: _GraphTypeCard(graphType: time_passed)),
                ],
              ),
            ),
          if (modelData.dashboard.graphGrievanceList.haveList) const SizedBox(height: 20),
          if (modelData.dashboard.graphGrievanceList.haveList)
            LineChartView(
              graphModel: modelData.graphModel,
              charts: modelData.dashboard.graphGrievanceList ?? [],
              graphType: modelData.selectedGraphType,
            ),
          if (modelData.dashboard.graphGrievanceList.haveList) const SizedBox(height: 24),
          if (modelData.dashboard.graphGrievanceList.haveList)
            Container(
              width: double.infinity,
              alignment: Alignment.center,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(height: 10, width: 10, decoration: const BoxDecoration(color: blue, shape: BoxShape.circle)),
                  const SizedBox(width: 04),
                  Text('Total Grievance'.translate, style: sl<TextStyles>().text14_600(black)),
                  const SizedBox(width: 16),
                  Container(height: 10, width: 10, decoration: const BoxDecoration(color: teal, shape: BoxShape.circle)),
                  const SizedBox(width: 04),
                  Text('Resolved'.translate, style: sl<TextStyles>().text14_600(black)),
                  const SizedBox(width: 16),
                  Container(height: 10, width: 10, decoration: const BoxDecoration(color: amber, shape: BoxShape.circle)),
                  const SizedBox(width: 04),
                  Text('Time Passed'.translate, style: sl<TextStyles>().text14_600(black)),
                ],
              ),
            ),
          if (modelData.dashboard.serviceGrievanceList.haveList) const SizedBox(height: 24),
          if (modelData.dashboard.serviceGrievanceList.haveList)
            Container(
              width: SizeConfig.width,
              margin: const EdgeInsets.symmetric(horizontal: 24),
              decoration: BoxDecoration(color: white, borderRadius: radius, border: border),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 04),
                  _serviceGrievanceHeader(context),
                  const SizedBox(height: 04),
                  ServiceGrievanceList(serviceList: modelData.dashboard.serviceGrievanceList!),
                ],
              ),
            ),
          SizedBox(height: SizeConfig.bottomNotch ? 24 : 20),
        ],
      ),
    );
  }

  /*Widget _graphStatusItem(String title, Color color) {
    return Row()
  }*/

  Widget _serviceGrievanceHeader(BuildContext context) {
    return Container(
      color: white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 08, horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 32, child: Text('#', style: sl<TextStyles>().text15_600(black))),
          const SizedBox(width: 6),
          Expanded(child: Text('Service Name'.translate, style: sl<TextStyles>().text15_600(black))),
          const SizedBox(width: 10),
          Text('Complaints'.translate, style: sl<TextStyles>().text15_600(black)),
        ],
      ),
    );
  }

  Widget _complainItem({required String label, required String value, required Color color}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(height: 3, width: 16, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4))),
        const SizedBox(width: 08),
        Expanded(child: Text(label, maxLines: 1, overflow: TextOverflow.ellipsis, style: sl<TextStyles>().text15_400(black))),
        const SizedBox(width: 12),
        Text(sl<Formatters>().localizeNumber(value), style: sl<TextStyles>().text15_600(black)),
      ],
    );
  }
}

class _GraphTypeCard extends StatelessWidget {
  final LineGraphType graphType;
  _GraphTypeCard({required this.graphType});

  @override
  Widget build(BuildContext context) {
    var modelData = Provider.of<DashboardViewModel>(context);
    var viewModel = Provider.of<DashboardViewModel>(context, listen: false);
    var radius = const Radius.circular(08);
    var topLeft = graphType.isFirst ? radius : Radius.zero;
    var bottomLeft = graphType.isFirst ? radius : Radius.zero;
    var topRight = graphType.isLast ? radius : Radius.zero;
    var bottomRight = graphType.isLast ? radius : Radius.zero;
    var borderRadius = BorderRadius.only(topLeft: topLeft, bottomLeft: bottomLeft, topRight: topRight, bottomRight: bottomRight);
    var selected = graphType.value == modelData.selectedGraphType;
    return InkWell(
      onTap: () => viewModel.selectGraphType(graphType.value),
      child: Container(
        height: 38,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: selected ? primary : primary.withOpacity(0.02), borderRadius: borderRadius),
        child: Text(graphType.label, style: sl<TextStyles>().text15_600(selected ? white : black)),
      ),
    );
  }
}

class _LinearRatingItem extends StatelessWidget {
  final String title;
  final double value;
  final Color color;

  _LinearRatingItem({required this.title, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    var percentage = sl<Formatters>().localizeNumber('${value.round()}');
    var label = Text(title, style: sl<TextStyles>().text16_600(black));
    return Column(
      children: [
        Row(children: [label, const Spacer(), Text('$percentage%', style: sl<TextStyles>().text16_600(black))]),
        const SizedBox(height: 12),
        LinearProgressbar(background: color.withOpacity(0.2), height: 8, valueColor: color, separator: 100, total: value),
      ],
    );
  }
}
