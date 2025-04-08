import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/citizen_profile/citizen_profile_api.dart';
import 'package:grs/models/officer_profile/officer_profile_api.dart';
import 'package:grs/models/officer_profile/organogram_info.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/utils/api_url.dart';

class AuthRepository {
  // Officer
  Future<bool> signOut() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  Future<OfficerProfileApi?> administrativeLogin({required Map<String, dynamic> body}) async {
    var endpoint = sl<ApiUrl>().administrativeLogin;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.http);
    if (apiResponse.status == 200) {
      sl<AuthService>().storeRememberMeData(body);
      var profileApi = OfficerProfileApi.fromJson(apiResponse.response['data']);
      var organogramInfo = _getOrganogramData(apiResponse.response['data']['user_info']['organogram_info']);
      sl<AuthService>().storeOfficerProfileData(profileApi, organogramInfo);
      return profileApi;
    } else if (apiResponse.status == 300) {
      var message = 'Sorry your head office could not be found. Please contact the ICT Wing of the Cabinet Division'.translate;
      sl<Toasts>().warningToast(message: message, isTop: false);
      return null;
    } else {
      sl<Toasts>().warningToast(message: 'Invalid username or password'.translate, isTop: false);
      return null;
    }
  }

  OrganogramInfo? _getOrganogramData(organogram) {
    if (organogram == null) return null;
    List<OrganogramInfo> organogramList = [];
    organogram.forEach((key, value) => organogramList.add(OrganogramInfo.fromJson(value)));
    return organogramList.haveList ? organogramList.first : null;
  }

  // Citizen
  Future<bool> checkUser(String mobile) async {
    var endpoint = '${sl<ApiUrl>().checkUser}$mobile';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] != null) sl<Toasts>().errorToast(message: 'User already exist'.translate, isTop: false);
      return apiResponse.response['data'] == null ? false : true;
    } else {
      return false;
    }
  }

  Future<bool> signUp({required Map<String, dynamic> body}) async {
    var endpoint = sl<ApiUrl>().userSignUp;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.http);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Registration successful'.translate, isTop: false);
      return true;
    } else {
      sl<Toasts>().warningToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: false);
      return false;
    }
  }

  Future<CitizenProfileApi?> citizenSignIn({var body, var cred}) async {
    var endpoint = sl<ApiUrl>().citizenLogin;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.http);
    if (apiResponse.status == 200) {
      var profileApi = CitizenProfileApi.fromJson(apiResponse.response['data']);
      sl<AuthService>().storeRememberMeData(cred);
      sl<AuthService>().storeCitizenProfileData(profileApi);
      return profileApi;
    } else if (apiResponse.status == 300) {
      sl<Toasts>().warningToast(message: 'Invalid username or password'.translate, isTop: false);
      return null;
    } else {
      sl<Toasts>().warningToast(message: 'Invalid username or password'.translate, isTop: false);
      return null;
    }
  }

  Future<bool> forgotPassword(String mobile) async {
    var endpoint = '${sl<ApiUrl>().forgotPassword}$mobile';
    var apiResponse = await sl<ApiInterceptor>().putRequest(endpoint: endpoint, header: Header.http);
    if(apiResponse.status == 200){
      if(apiResponse.response['status'] == 'success'){
        sl<Toasts>().successToast(message: 'Pin code reset successful. The new pin code will be sent via SMS and email'.translate, isTop: false);
        return true;
      }else{
        sl<Toasts>().warningToast(message: 'There are no users of this phone number'.translate, isTop: false);
        return false;
      }
    }else{
      sl<Toasts>().warningToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: false);
      return false;
    }
  }
}
