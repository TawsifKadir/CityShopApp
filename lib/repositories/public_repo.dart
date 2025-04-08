import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/citizen_charter/citizen_charter_api.dart';
import 'package:grs/models/country/country.dart';
import 'package:grs/models/country/country_api.dart';
import 'package:grs/models/district/district.dart';
import 'package:grs/models/district/district_api.dart';
import 'package:grs/models/occupation/occupation.dart';
import 'package:grs/models/occupation/occupation_api.dart';
import 'package:grs/models/qualification/qualification.dart';
import 'package:grs/models/qualification/qualification_api.dart';
import 'package:grs/models/safety_net/safety_net.dart';
import 'package:grs/models/safety_net/safety_net_api.dart';
import 'package:grs/service/app_api_status.dart';
import 'package:grs/utils/api_url.dart';

class PublicRepository {
  Future<List<Occupation>> allOccupations() async {
    var endpoint = sl<ApiUrl>().occupations;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var occupationApi = OccupationApi.fromJson(apiResponse.response);
      return occupationApi.occupations.haveList ? occupationApi.occupations! : [];
    } else if (apiResponse.status == 300) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<Qualification>> allQualifications() async {
    var endpoint = sl<ApiUrl>().qualifications;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var qualificationApi = QualificationApi.fromJson(apiResponse.response);
      return qualificationApi.qualifications.haveList ? qualificationApi.qualifications! : [];
    } else if (apiResponse.status == 300) {
      return [];
    } else {
      return [];
    }
  }

  Future<List<Country>> allNationalities() async {
    var endpoint = sl<ApiUrl>().nationalities;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var nationalitiesApi = CountryApi.fromJson(apiResponse.response);
      return nationalitiesApi.nationalities.haveList ? nationalitiesApi.nationalities! : [];
    } else if (apiResponse.status == 300) {
      return [];
    } else {
      return [];
    }
  }

  Future<CitizenCharterApi?> citizenCharterInfo(int officeId) async {
    var endpoint = '${sl<ApiUrl>().charterInfo}$officeId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] == null) return null;
      var charterInfo = CitizenCharterApi.fromJson(apiResponse.response['data']);
      return charterInfo;
    } else {
      return null;
    }
  }

  Future<bool> saveImprovementFeedback(var body) async {
    var endpoint = sl<ApiUrl>().saveSuggestion;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.http);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Improvement feedback sent successfully'.translate, isTop: false);
      return true;
    } else {
      return false;
    }
  }

  Future<List<SafetyNet>> getSafetyNets() async {
    var endpoint = sl<ApiUrl>().safety_nets;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var safetyNetApi = SafetyNetApi.fromJson(apiResponse.response);
      sl<AppApiStatus>().safetyNets = true;
      if (!safetyNetApi.safetyNets.haveList) return [];
      return safetyNetApi.safetyNets!;
    } else {
      if (apiResponse.status == 300) sl<AppApiStatus>().safetyNets = true;
      return [];
    }
  }

  Future<List<District>> getDivisions() async {
    var endpoint = sl<ApiUrl>().divisions;
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var districtApi = DistrictApi.fromJson(apiResponse.response);
      sl<AppApiStatus>().divisions = true;
      if (!districtApi.districts.haveList) return [];
      return districtApi.districts!;
    } else {
      if (apiResponse.status == 300) sl<AppApiStatus>().divisions = true;
      return [];
    }
  }

  Future<List<District>> getDistricts(String endpoint) async {
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      var districtApi = DistrictApi.fromJson(apiResponse.response);
      if (!districtApi.districts.haveList) return [];
      return districtApi.districts!;
    } else {
      return [];
    }
  }
}
