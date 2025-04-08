import 'package:grs/di.dart';
import 'package:grs/extensions/list_ext.dart';
import 'package:grs/models/citizen_profile/citizen_profile.dart';
import 'package:grs/models/officer_profile/employee_info.dart';
import 'package:grs/models/officer_profile/officer_profile.dart';
import 'package:grs/models/officer_profile/organogram_info.dart';
import 'package:grs/models/officer_profile/user_office_info.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/keys.dart';

class ProfileHelper {
  bool get isCitizen {
    var authStatus = sl<StorageService>().getAuthStatus;
    var moduleType = sl<StorageService>().getModule;
    return authStatus && moduleType == 'citizen';
  }

  bool get isOfficer {
    var authStatus = sl<StorageService>().getAuthStatus;
    var moduleType = sl<StorageService>().getModule;
    return authStatus && moduleType == 'officer';
  }

  // Citizen
  CitizenProfile get citizenProfile {
    var context = navigatorKey.currentState?.context;
    if (context == null) return CitizenProfile();
    var profileInfo = sl<StorageService>().getCitizenProfile;
    return profileInfo;
  }

  // Officer
  OfficerProfile? get officerProfile {
    var context = navigatorKey.currentState?.context;
    if (context == null) return null;
    var profileInfo = sl<StorageService>().getOfficerProfile;
    return profileInfo;
  }

  EmployeeInfo get employee {
    var context = navigatorKey.currentState?.context;
    if (context == null) return EmployeeInfo();
    var profileInfo = sl<StorageService>().getProfileInfo;
    return profileInfo.employeeInfo ?? EmployeeInfo();
  }

  OrganogramInfo get organogram {
    var context = navigatorKey.currentState?.context;
    if (context == null) return OrganogramInfo();
    var organogramData = sl<StorageService>().getOrganogram;
    return organogramData;
  }

  UserOfficeInfo get officeInfo {
    var context = navigatorKey.currentState?.context;
    if (context == null) return UserOfficeInfo();
    var profileInfo = sl<StorageService>().getProfileInfo;
    var officeData = profileInfo.officeInfo.haveList;
    return officeData ? profileInfo.officeInfo!.first : UserOfficeInfo();
  }
}
