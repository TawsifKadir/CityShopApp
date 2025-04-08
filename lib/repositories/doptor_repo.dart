import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/app_helper.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/doptor_apis/divitional_office.dart';
import 'package:grs/models/doptor_apis/divitional_office_api.dart';
import 'package:grs/models/doptor_apis/ministry.dart';
import 'package:grs/models/doptor_apis/ministry_api.dart';
import 'package:grs/models/doptor_apis/office.dart';
import 'package:grs/models/doptor_apis/office_api.dart';
import 'package:grs/models/doptor_apis/office_by_layer.dart';
import 'package:grs/models/doptor_apis/origin.dart';
import 'package:grs/models/service/service.dart';
import 'package:grs/models/service/service_api.dart';
import 'package:grs/models/subordinate_office/sub_ordinate_office.dart';
import 'package:grs/models/subordinate_office/subordinate_office_api.dart';
import 'package:grs/service/app_api_status.dart';
import 'package:grs/utils/api_url.dart';

class DoptorRepository {
  Future<List<SubordinateOffice>> getSubOrdinateOffice(int? grievanceId) async {
    var organogramId = sl<ProfileHelper>().organogram.id;
    var endpoint = '${sl<ApiUrl>().subordinateOffice}$grievanceId';
    // var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<AppApiStatus>().subordinateOfficers = true;
      var officeApi = SubordinateOfficeApi.fromJson(apiResponse.response);
      if (!officeApi.subordinateOffices.haveList) return [];
      return officeApi.subordinateOffices!;
    } else {
      if (apiResponse.status == 300) sl<AppApiStatus>().subordinateOfficers = true;
      return [];
    }
  }

  Future<List<Office>> searchableOfficeList(String queryText) async {
    var queryLang = sl<AppHelper>().detectLanguage(queryText) == 'en' ? 'name' : 'nameBn';
    var endpoint = '${sl<ApiUrl>().allOfficeBySearch}$queryLang=$queryText';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] == null || apiResponse.response['data'] == 'No data found.') return [];
      var officeApi = OfficeApi.fromJson(apiResponse.response);
      return officeApi.officeList.haveList ? officeApi.officeList! : [];
    } else if (apiResponse.status == 300) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<Ministry>> allMinistries() async {
    var endpoint = sl<ApiUrl>().allMinistries;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      sl<AppApiStatus>().ministries = true;
      var officeApi = MinistryApi.fromJson(apiResponse.response);
      return officeApi.ministryList.haveList ? officeApi.ministryList! : [];
    } else if (apiResponse.status == 300) {
      sl<AppApiStatus>().ministries = true;
      sl<Toasts>().toastMessage(message: 'No ministry level found'.translate, isTop: false);
      return [];
    } else {
      return [];
    }
  }

  Future<List<Origin>> originsByLayer(int layerLevel) async {
    var endpoint = '${sl<ApiUrl>().originsByLayer}$layerLevel';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      List<Origin> originList = [];
      if (apiResponse.response['data'] == null) return originList;
      apiResponse.response['data'].forEach((value) => originList.add(Origin.fromJson(value)));
      // apiResponse.response['data'].forEach((key, value) => originList.add(Origin.fromJson(value)));
      if (originList.haveList) originList.sort((item1, item2) => (item1.id ?? 0).compareTo(item2.id ?? 0));
      return originList;
    } else if (apiResponse.status == 300) {
      sl<Toasts>().toastMessage(message: 'No office origins found'.translate, isTop: false);
      return [];
    } else {
      return [];
    }
  }

  Future<List<DivitionalOffice>> divisionalOfficesByLayer() async {
    var endpoint = sl<ApiUrl>().divisionalOfficeByLayer;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] == null) return [];
      var divisionalOfficeApi = DivitionalOfficeApi.fromJson(apiResponse.response);
      return divisionalOfficeApi.divitionalOffices!;
    } else if (apiResponse.status == 300) {
      sl<Toasts>().toastMessage(message: 'No divisional office found'.translate, isTop: false);
      return [];
    } else {
      return [];
    }
  }

  Future<List<OfficeByLayer>> officesByLayer(int layerLevel) async {
    var endpoint = '${sl<ApiUrl>().officesByLayer}$layerLevel';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      List<OfficeByLayer> layerOfficeList = [];
      if (apiResponse.response['data'] == null) return layerOfficeList;
      apiResponse.response['data'].forEach((key, value) => layerOfficeList.add(OfficeByLayer.fromJson(value)));
      return layerOfficeList;
    } else if (apiResponse.status == 300) {
      sl<Toasts>().toastMessage(message: 'No office found'.translate, isTop: false);
      return [];
    } else {
      return [];
    }
  }

  Future<List<Service>> getServiceListByOffice(int officeId) async {
    var endpoint = '${sl<ApiUrl>().services}$officeId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var invalidService = apiResponse.response['data'] == null || apiResponse.response['data'] == 'No data found.';
      if (invalidService) return [];
      var serviceApi = ServiceApi.fromJson(apiResponse.response);
      return serviceApi.serviceList.haveList ? serviceApi.serviceList! : [];
    } else {
      return [];
    }
  }

  Future<List<Service>> getServiceListByArea(String endpoint) async {
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var invalidService = apiResponse.response['data'] == null || apiResponse.response['data'] == 'No data found.';
      if (invalidService) return [];
      var serviceApi = ServiceApi.fromJson(apiResponse.response);
      return serviceApi.serviceList.haveList ? serviceApi.serviceList! : [];
    } else {
      return [];
    }
  }

  Future<Office?> getOfficeInfoByServiceArea(String endpoint) async {
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var invalidOffice = apiResponse.response['data'] == null || apiResponse.response['data'] == 'No data found.';
      if (invalidOffice) return null;
      return Office.fromJson(apiResponse.response['data']);
    } else {
      return null;
    }
  }
}
