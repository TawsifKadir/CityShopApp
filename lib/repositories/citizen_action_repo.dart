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
import 'package:grs/view_models/complain/citizen_complains_view_model.dart';
import 'package:grs/view_models/complain_details/citizen_complain_details_view_model.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class CitizenActionRepository {
  Future<bool> seeHearingDate(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().hearingDate;
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

  Future<bool> sendForAppeal(Map<String, String> body, List<ProofFile> proofFiles) async {
    var endpoint = sl<ApiUrl>().sendForAppeal;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    if (proofFiles.haveList) request.files.addAll(await _getMultipartFiles(proofFiles));
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Appeal request sent successfully'.translate, isTop: true);
      var complain = Complain.fromJson(apiResponse.response['data']);
      return _setComplainData(complain);
    } else {
      sl<Toasts>().errorToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: true);
      return false;
    }
  }

  Future<bool> evidenceMaterial({required List<ProofFile> proofFiles, var body}) async {
    var endpoint = sl<ApiUrl>().evidenceMaterial;
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

  Future<bool> sendComplainRating(var body) async {
    var endpoint = sl<ApiUrl>().complainRating;
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, body: body, header: Header.auth);
    if (apiResponse.status == 200) {
      sl<Toasts>().successToast(message: 'Your rating submitted successfully'.translate, isTop: true);
      return true;
    } else if (apiResponse.status == 300) {
      sl<Toasts>().errorToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: true);
      return false;
    } else {
      sl<Toasts>().errorToast(message: 'Unexpected error occurred. Please try again'.translate, isTop: true);
      return false;
    }
  }

  bool _setComplainData(Complain complain) {
    var context = navigatorKey.currentState?.context;
    if (context == null) return true;
    Provider.of<CitizenComplainsViewModel>(context, listen: false).updateComplainInfo(complain);
    Provider.of<CitizenComplainDetailsViewModel>(context, listen: false).updateComplainInfo(complain);
    return true;
  }

  Future<List<http.MultipartFile>> _getMultipartFiles(List<ProofFile> proofFiles) async {
    List<http.MultipartFile> multipartFiles = [];
    for (ProofFile item in proofFiles) {
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
