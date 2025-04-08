import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/extensions/string_ext.dart';
import 'package:grs/helpers/profile_helper.dart';
import 'package:grs/helpers/sort_helper.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/models/dummy/complain_menu.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/api_url.dart';

class ComplainHelper {
  final int SIZE = 10;

  String complainListApiUrl(ComplainMenu menu, int page) {
    var baseUrl = sl<ApiUrl>().allComplains;
    if (menu.value == 'arrival') {
      return '$baseUrl/to-employee?page=$page&size=$SIZE';
    } else if (menu.value == 'dispatched') {
      return '$baseUrl/from-employee?page=$page&size=$SIZE';
    } else if (menu.value == 'resolved') {
      return '$baseUrl/closed_grievances?page=$page&size=$SIZE';
    } else if (menu.value == 'another-office') {
      return '$baseUrl/forwarded_to_other_office?page=$page&size=$SIZE';
    } else if (menu.value == 'overdue') {
      return '$baseUrl/expired_grievances?page=$page&size=$SIZE';
    } else if (menu.value == 'copy') {
      return '$baseUrl/cc?page=$page&size=$SIZE';
    } else {
      return '$baseUrl/to-employee?page=$page&size=$SIZE';
    }
  }

  String appealListApiUrl(ComplainMenu menu, int page) {
    var baseUrl = sl<ApiUrl>().allComplains;
    if (menu.value == 'arrival') {
      return '$baseUrl/incoming-appeal?page=$page&size=$SIZE';
    } else if (menu.value == 'dispatched') {
      return '$baseUrl/sent-appeal?page=$page&size=$SIZE';
    } else if (menu.value == 'resolved') {
      return '$baseUrl/closed-appeal?page=$page&size=$SIZE';
    } else {
      return '$baseUrl/incoming-appeal?page=$page&size=$SIZE';
    }
  }

  List<Complain> filterComplains(List<Complain> complains, String searchKey) {
    if (!complains.haveList) return [];
    if (searchKey.isEmpty) return complains;
    var key = searchKey.toKey;
    var filteredComplains = complains.where((item) {
      return item.trackingNumber.toKey.contains(key) ||
          item.subject.toKey.contains(key) ||
          item.submissionDate.toKey.contains(key) ||
          item.currentStatus.toKey.contains(key);
    }).toList();
    if (!filteredComplains.haveList) return [];
    var sortedComplains = sl<SortHelper>().sortComplainId(filteredComplains);
    if (!sortedComplains.haveList) return [];
    sortedComplains.toSet().toList();
    return sortedComplains;
  }
}
