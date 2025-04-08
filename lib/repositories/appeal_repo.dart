import 'package:grs/di.dart';
import 'package:grs/enum/enums.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/interceptors/api_interceptor.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/history/complain_history.dart';
import 'package:grs/models/history/complain_history_api.dart';
import 'package:grs/utils/api_url.dart';

class AppealRepository {
  Future<List<ComplainHistory>> appealHistories(Complain complain) async {
    var endpoint = '${sl<ApiUrl>().appealHistory}${complain.id}';
    var apiResponse = await sl<ApiInterceptor>().getRequest(endpoint: endpoint, header: Header.auth);
    if (apiResponse.status == 200) {
      var historyApi = ComplainHistoryApi.fromJson(apiResponse.response);
      return historyApi.histories.haveList ? historyApi.histories! : [];
    } else {
      return [];
    }
  }
}
