import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/models/blacklist/blacklist.dart';
import 'package:grs/models/blacklist/blacklist_api.dart';
import 'package:grs/utils/api_url.dart';
import 'package:http/http.dart' as http;
import '../service/storage_service.dart';

class BlacklistRepository {
  Future<Blacklist?> saveAsBlacklist(var body) async {
    var endpoint = sl<ApiUrl>().saveAsBlacklist;
    http.MultipartRequest request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.fields.addAll(body);
    request.headers.addAll(_getMultipartHeaders);
    var apiResponse = await sl<ApiInterceptor>().multipartRequest(request: request);
    if (apiResponse.status == 200) {
      return Blacklist.fromJson(apiResponse.response['data']);
    } else {
      return null;
    }
  }

  Future<List<Blacklist>> getAllBlackLists(String endpoint) async {
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var blacklistApi = BlacklistApi.fromJson(apiResponse.response);
      return blacklistApi.blacklists.haveList ? blacklistApi.blacklists! : [];
    } else {
      return [];
    }
  }

  Future<int?> blacklistStatusChange(int id, int status) async {
    var endpoint = '${sl<ApiUrl>().blacklistStatus}$id?blacklisted=$status';
    var apiResponse = await sl<ApiInterceptor>().postRequest(endpoint: endpoint, header: Header.auth);
    return apiResponse.status == 200 ? apiResponse.response['data'] : null;
  }

  Map<String, String> get _getMultipartHeaders {
    Map<String, String> multipartHeaders = {};
    multipartHeaders['Accept'] = 'application/json';
    multipartHeaders['Content-Type'] = 'application/json';
    multipartHeaders['Authorization'] = 'Bearer ${sl<StorageService>().getToken}';
    return multipartHeaders;
  }
}
