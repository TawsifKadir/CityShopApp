import 'package:grs/models/branch/officer.dart';
import 'package:grs/models/history/complain_history.dart';

class ActionDataHelper {
  bool checkCommitteeHead(List<Officer> officers) {
    var result = false;
    officers.forEach((item) => item.isCommitteeHead != null && item.isCommitteeHead! ? result = true : null);
    return result;
  }

  bool checkRecipients(List<Officer> officers) {
    var result = false;
    officers.forEach((item) => item.isRecipient != null && item.isRecipient! ? result = true : null);
    return result;
  }

  List<int> checkMovementOfficers(List<ComplainHistory> officers) {
    List<int> employeeRecordIds = [];
    officers.forEach((item) => item.isSelected != null && item.isSelected! ? employeeRecordIds.add(item.toEmployeeRecordId!) : null);
    return employeeRecordIds;
  }

  List<Map<String, int>> checkMovementOfficersWithOrganogramId(List<ComplainHistory> officers) {
    List<Map<String, int>> result = [];

    officers.forEach((item) {
      if (item.isSelected != null && item.isSelected!) {
        result.add({
          'employeeRecordId': item.toEmployeeRecordId!,
          'officeUnitOrganogramId': item.toOfficeUnitOrganogramId!,
        });
      }
    });
    return result;
  }

}
