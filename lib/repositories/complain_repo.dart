import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/citizen_profile/citizen_profile.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/complain/complain_api.dart';
import 'package:grs/models/complain/complain_details_api.dart';
import 'package:grs/models/dummy/proof_file.dart';
import 'package:grs/models/history/complain_history.dart';
import 'package:grs/models/history/complain_history_api.dart';
import 'package:grs/service/auth_service.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/api_url.dart';
import 'package:http/http.dart' as http;

class ComplainRepository {
  int ? totalPages;

  final Map<int, int> _menuPageNumbers = {};
  final Map<int, int> _menuTotalPageNumbers = {};
  final Map<int, int> _menuAppealPageNumbers = {};
  final Map<int, int> _menuAppealTotalPageNumbers = {};

  // Method to get the page number for a given menu (default to 1 if not set)
  int getPageNumberForMenu(int menuIndex) {
    return _menuPageNumbers[menuIndex] ?? 1;  // Default to page 1
  }

  int getPageNumberForAppealMenu(int menuIndex) {
    return _menuAppealPageNumbers[menuIndex] ?? 1;  // Default to page 1
  }

  // Method to set the page number for a given menu
  void setPageNumberForMenu(int menuIndex, int page) {
    _menuPageNumbers[menuIndex] = page;
  }

  void setPageNumberForAppealMenu(int menuIndex, int page) {
    _menuAppealPageNumbers[menuIndex] = page;
  }

  void updatePageNumber(int menuIndex, int newPage) {
    setPageNumberForMenu(menuIndex, newPage);
  }

  void updateAppealPageNumber(int menuIndex, int newPage) {
    setPageNumberForAppealMenu(menuIndex, newPage);
  }

  int getTotalPageNumberForMenu(int menuIndex) {
    return _menuTotalPageNumbers[menuIndex] ?? 1;  // Default to page 1
  }

  int getTotalPageNumberForAppealMenu(int menuIndex) {
    return _menuAppealTotalPageNumbers[menuIndex] ?? 1;  // Default to page 1
  }

  // Method to set the page number for a given menu
  void setTotalPageNumberForMenu(int menuIndex) {
    _menuTotalPageNumbers[menuIndex] = totalPages ?? 1;
  }

  void setTotalPageNumberForAppealMenu(int menuIndex) {
    _menuAppealTotalPageNumbers[menuIndex] = totalPages ?? 1;
  }

  void updateTotalPageNumber(int menuIndex) {
    setTotalPageNumberForMenu(menuIndex);
  }

  void updateTotalAppealPageNumber(int menuIndex) {
    setTotalPageNumberForAppealMenu(menuIndex);
  }

  Future<Complain?> trackComplain(String trackingId) async {
    var endpoint = '${sl<ApiUrl>().trackComplain}$trackingId';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response == null || apiResponse.response['data'] == null) {
        sl<Toasts>().successToast(message: 'No complain found'.translate, isTop: true);
        return null;
      }
      return Complain.fromJson(apiResponse.response['data']);
    } else if (apiResponse.status == 300) {
      sl<Toasts>().successToast(message: 'No complain found'.translate, isTop: true);
      return null;
    } else {
      return null;
    }
  }

  Future<List<Complain>> allComplains(String endpoint) async {
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var complainApi = ComplainApi.fromJson(apiResponse.response);
      totalPages = (complainApi.totalPages == 0) ? 1 : complainApi.totalPages;
      return complainApi.complains.haveList ? complainApi.complains! : [];
    } else {
      totalPages = 1;
      return [];
    }
  }

  Future<ComplainDetailsApi?> complainDetails(Complain complain) async {
    var endpoint = '${sl<ApiUrl>().complainDetails}${complain.id}';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      if (apiResponse.response == null) return null;
      return ComplainDetailsApi.fromJson(apiResponse.response['data']);
    } else if (apiResponse.status == 300) {
      return null;
    } else {
      return null;
    }
  }

  Future<List<ComplainHistory>> officerComplainMovement(Complain complain) async {
    var endpoint = '${sl<ApiUrl>().officerComplainMovement}${complain.id}';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var historyApi = ComplainHistoryApi.fromJson(apiResponse.response);
      return historyApi.histories.haveList ? historyApi.histories! : [];
    } else {
      return [];
    }
  }

  Future<List<ComplainHistory>> citizenComplainMovement(Complain complain) async {
    var endpoint = '${sl<ApiUrl>().citizenComplainMovement}${complain.id}';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var historyApi = ComplainHistoryApi.fromJson(apiResponse.response);
      return historyApi.histories.haveList ? historyApi.histories! : [];
    } else {
      return [];
    }
  }

  Future<Complain?> createComplainApi(Map<String, String> body, List<ProofFile> proofFiles) async {
    var authStatus = sl<AuthService>().authStatus;
    var endpoint = authStatus ? sl<ApiUrl>().createComplain : sl<ApiUrl>().createPublicComplain;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Your complain registered successfully'.translate, isTop: true);
      return Complain();
    } else if (apiResponse.status == 300) {
      var defaultMessage = "Right now, we can't accept your complaint. Please contact the help desk.".translate;
      var invalidGro = apiResponse.response['message'] == 'No GRO found';
      var message = invalidGro ? 'No GRO found'.translate : defaultMessage;
      sl<Toasts>().warningToast(message: message, isTop: true);
      return null;
    } else {
      return null;
    }
  }

  Future<List<http.MultipartFile>> _getMultipartFiles(List<ProofFile> proofFiles) async {
    List<http.MultipartFile> multipartFiles = [];
    for (ProofFile item in proofFiles) {
      multipartFiles.add(await http.MultipartFile.fromPath('files[]', item.file.path));
    }
    return multipartFiles;
  }

  Map<String, String> get _getMultipartHeaders {
    var authStatus = sl<AuthService>().authStatus;
    Map<String, String> multipartHeaders = {};
    multipartHeaders['Accept'] = 'application/json';
    multipartHeaders['Content-Type'] = 'application/json';
    if (authStatus) multipartHeaders['Authorization'] = 'Bearer ${sl<StorageService>().getToken}';
    return multipartHeaders;
  }

  Future<CitizenProfile?> checkUser(String mobile) async {
    var endpoint = '${sl<ApiUrl>().checkUser}$mobile';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.http);
    if (apiResponse.status == 200) {
      if (apiResponse.response['data'] == null) return null;
      return CitizenProfile.fromJson(apiResponse.response['data']);
    } else {
      return null;
    }
  }
}
