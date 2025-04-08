import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/models/branch/branch_api.dart';
import 'package:grs/models/branch/branch_office.dart';
import 'package:grs/models/gro_officers/gro_officer.dart';
import 'package:grs/models/history/complain_history.dart';
import 'package:grs/models/history/complain_history_api.dart';
import 'package:grs/models/service/service.dart';
import 'package:grs/models/service/service_api.dart';
import 'package:grs/service/app_api_status.dart';
import 'package:grs/utils/api_url.dart';

class ActionDataRepository {
  Future<List<BranchOffice>> getBranches() async {
    var officeId = sl<ProfileHelper>().officeInfo.officeId;
    var endpoint = '${sl<ApiUrl>().branches}$officeId';
    // var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<AppApiStatus>().branchOfficers = true;
      var branchApi = BranchApi.fromJson(apiResponse.response);
      if (!branchApi.branchList.haveList) return [];
      var branch = branchApi.branchList!.first;
      return branch.branchOfficeList.haveList ? branch.branchOfficeList! : [];
    } else {
      if (apiResponse.status == 300) sl<AppApiStatus>().branchOfficers = true;
      return [];
    }
  }

  Future<List<Service>> getServiceListByProfileOffice() async {
    var officeId = sl<ProfileHelper>().officeInfo.officeId;
    var endpoint = '${sl<ApiUrl>().services}$officeId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var serviceApi = ServiceApi.fromJson(apiResponse.response);
      return serviceApi.serviceList.haveList ? serviceApi.serviceList! : [];
    } else {
      return [];
    }
  }

  Future<List<ComplainHistory>> movementOfficersList(int complainId) async {
    var endpoint = '${sl<ApiUrl>().movementOfficers}$complainId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var historyApi = ComplainHistoryApi.fromJson(apiResponse.response);
      return historyApi.histories.haveList ? historyApi.histories! : [];
    } else {
      return [];
    }
  }

  Future<GroOfficer?> getGroOfficer(int complainId) async {
    var endpoint = '${sl<ApiUrl>().groInfo}$complainId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] == null) return null;
      return GroOfficer.fromJson(apiResponse.response['data']);
    } else {
      return null;
    }
  }
}
