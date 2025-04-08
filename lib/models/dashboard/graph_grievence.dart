class GraphGrievance {
  String? month;
  int? totalComplaint;
  int? closedComplaint;
  int? timePassedComplaint;
  int? year;

  GraphGrievance({this.month, this.totalComplaint, this.closedComplaint, this.timePassedComplaint, this.year});

  GraphGrievance.fromJson(json) {
    month = json['month'];
    totalComplaint = json['total_complaint'];
    closedComplaint = json['closed_complaint'];
    timePassedComplaint = json['time_passed_complaint'];
    year = json['year'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['month'] = month;
    map['total_complaint'] = totalComplaint;
    map['closed_complaint'] = closedComplaint;
    map['time_passed_complaint'] = timePassedComplaint;
    map['year'] = year;
    return map;
  }
}
