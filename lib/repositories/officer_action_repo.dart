import 'package:grs/models/dummy/signature_file.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/libraries/toasts.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/dummy/proof_file.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/api_url.dart';
import 'package:grs/utils/keys.dart';
import 'package:grs/view_models/complain/appeal_complains_view_model.dart';
import 'package:grs/view_models/complain/officer_complains_view_model.dart';
import 'package:grs/view_models/complain_details/appeal_complain_details_view_model.dart';
import 'package:grs/view_models/complain_details/officer_complain_details_view_model.dart';

class OfficerActionRepository {
  Future<bool> sendForOpinion(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().sendForOpinion;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  // Future<bool> subordinateOfficeGro({required ActionTypePref typePref, required Map<String, dynamic> body}) async {
  //   var endpoint = typePref == ActionTypePref.appeal ? sl<ApiUrl>().sendAppealOpinion : sl<ApiUrl>().sendForOpinion;
  //   var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
  //   if (apiResponse.status == 200) {
  //     sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
  //     var complain = Complain.fromJson(apiResponse.response['data']);
  //     return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
  //   } else {
  //     return false;
  //   }
  // }

  Future<bool> subordinateOfficeGro({required ActionTypePref typePref, required Map<String, String> body}) async {
    var endpoint = typePref == ActionTypePref.appeal ? sl<ApiUrl>().sendAppealOpinion : sl<ApiUrl>().sendForOpinion;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    // var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> giveOpinion(ActionTypePref typePref, Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().giveOpinion;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Your opinion sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> startInvestigation({required ActionTypePref typePref, required Map<String, String> body}) async {
    var endpoint = sl<ApiUrl>().startInvestigation;
    // var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    // if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Complain sent for investigation successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> submitInvestigation(ActionTypePref typePref, Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().submitInvestigation;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Investigation report submitted successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> requestDocument({required ActionTypePref typePref, required Map<String, String> body}) async {
    var endpoint = sl<ApiUrl>().requestDocument;
    // var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    // if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Your request sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> sendToAnotherOffice(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().sendToAnotherOffice;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      var message = apiResponse.response['message'];
      var invalidSetup = message != null && message == 'Your selected office is not setup.';
      if (invalidSetup) sl<Toasts>().warningToast(message: 'Your selected office is not setup yet'.translate, isTop: false);
      if (invalidSetup) return false;
      var complain = Complain.fromJson(apiResponse.response['data']);
      sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
      return _setComplainData(complain);
    } else {
      var message = apiResponse.response['message'];
      var invalidSetup = message != null && message == 'Your selected office is not setup.';
      if (invalidSetup) sl<Toasts>().warningToast(message: 'Your selected office is not setup yet'.translate, isTop: false);
      return false;
    }
  }

  Future<bool> closeComplain(ActionTypePref typePref, Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().closeComplain;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Complain closed successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> rejectComplain(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().rejectComplain;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Complain rejected successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> sendToSubordinateOffice(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().sendToSubordinateOffice;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);

    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Complain sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> sendToAppealOfficer(Map<String, String> body) async {
    var endpoint = sl<ApiUrl>().sendToAppealOfficer;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);

    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Complain sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> providingService(ActionTypePref typePref, Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().guidelinesToProvidingService;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Guidelines sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return typePref == ActionTypePref.appeal ? _setAppealData(complain) : _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> hearingNotice({var body}) async {
    var endpoint = sl<ApiUrl>().hearingNotice;
    // var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Hearing notice sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> takeHearing(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().takeHearing;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      return false;
    }
  }

  Future<bool> approveOrDisapprove(Map<String, String> body, List<SignatureFile> signatureFiles) async {
    var endpoint = sl<ApiUrl>().approveOrDisApprove;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (signatureFiles.haveList) request.files.addAll(await _getMultipartFiles2(signatureFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    // var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Request sent successfully'.translate, isTop: false);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      sl<Toasts>().warningToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: true);
      return false;
    }
  }

  Future<bool> sendForPermission(Map<String, String> body) async {
    var endpoint = sl<ApiUrl>().sendForPermission;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Permission Request sent successfully'.translate, isTop: false);
      return _refreshComplainData();
    } else {
      return false;
    }
  }

  Future<bool> givePermission({var body}) async {
    var endpoint = sl<ApiUrl>().givePermission;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Permission Given successfully'.translate, isTop: false);
      return _refreshComplainData();
    } else {
      return false;
    }
  }

  bool _setAppealData(Complain complain) {
    var context = navigatorKey.currentState?.context;
    if (context == null) return true;
    Provider.of<AppealComplainsViewModel>(context, listen: false).updateComplainInfo(complain);
    Provider.of<AppealComplainDetailsViewModel>(context, listen: false).updateComplainInfo(complain);
    return true;
  }

  bool _setComplainData(Complain complain) {
    var context = navigatorKey.currentState?.context;
    if (context == null) return true;
    Provider.of<OfficerComplainsViewModel>(context, listen: false).updateComplainInfo(complain);
    Provider.of<OfficerComplainDetailsViewModel>(context, listen: false).updateComplainInfo(complain);
    return true;
  }

  bool _refreshComplainData() {
    var context = navigatorKey.currentState?.context;
    if (context == null) return true;
    Provider.of<OfficerComplainsViewModel>(context, listen: false).refreshAllComplains();
    return true;
  }

  Future<List<http.MultipartFile>> _getMultipartFiles(List<ProofFile> proofFiles) async {
    List<http.MultipartFile> multipartFiles = [];
    for (ProofFile item in proofFiles) {
      multipartFiles.add(await http.MultipartFile.fromPath('files[]', item.file.path));
    }
    return multipartFiles;
  }

  Future<List<http.MultipartFile>> _getMultipartFiles2(List<SignatureFile> signatureFiles) async {
    List<http.MultipartFile> multipartFiles = [];
    for (SignatureFile item in signatureFiles) {
      multipartFiles.add(await http.MultipartFile.fromPath('files[]', item.file.path));
    }
    return multipartFiles;
  }

  Map<String, String> get _getMultipartHeaders {
    Map<String, String> multipartHeaders = {};
    multipartHeaders['Accept'] = 'application/json';
    multipartHeaders['Content-Type'] = 'application/json';
    multipartHeaders['Authorization'] = 'Bearer ${sl<StorageService>().getToken}';
    return multipartHeaders;
  }
}
