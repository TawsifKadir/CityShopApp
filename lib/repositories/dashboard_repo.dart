import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/models/dashboard/dashboard.dart';
import 'package:grs/service/app_api_status.dart';
import 'package:grs/utils/api_url.dart';

class DashboardRepository {
  Future<Dashboard> dashboardData() async {
    var officeId = sl<ProfileHelper>().officeInfo.officeId;
    var organogramId = sl<ProfileHelper>().officeInfo.officeUnitOrganogramId ?? '';
    var endpoint = '${sl<ApiUrl>().dashboard}$officeId&organogram_id=$organogramId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<AppApiStatus>().dashboard = true;
      if (apiResponse.response['data'] == null) return Dashboard();
      return Dashboard.fromJson(apiResponse.response['data']);
    } else if (apiResponse.status == 300) {
      sl<AppApiStatus>().dashboard = true;
      return Dashboard();
    } else {
      return Dashboard();
    }
  }
}
