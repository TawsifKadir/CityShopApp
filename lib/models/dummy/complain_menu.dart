import 'package:grs/di.dart';
import 'package:grs/models/complain/complain.dart';
import 'package:grs/service/storage_service.dart';
import 'package:grs/utils/assets.dart';

class ComplainMenu {
  String icon;
  String labelBn;
  String labelEn;
  String value;
  int page;
  bool moreComplains;
  bool paginationLoader;
  List<Complain> complains;

  ComplainMenu({
    required this.icon,
    required this.labelBn,
    required this.labelEn,
    required this.value,
    required this.page,
    required this.moreComplains,
    required this.paginationLoader,
    required this.complains,
  });

  String get label => sl<StorageService>().getLanguage == 'bn' ? labelBn : labelEn;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['label_bn'] = labelBn;
    map['label_en'] = labelEn;
    map['value'] = value;
    return map;
  }
}

final List<ComplainMenu> complainMenuList = [
  ComplainMenu(
    page: 1,
    icon: Assets.arrow_circle_down_outline,
    labelBn: 'আগত',
    labelEn: 'Incoming',
    value: 'arrival',
    moreComplains: true,
    paginationLoader: false,
    complains: [],
  ),
  ComplainMenu(
    page: 1,
    complains: [],
    labelBn: 'প্রেরিত',
    labelEn: 'Dispatched',
    value: 'dispatched',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.arrow_circle_right_outline,
  ),
  ComplainMenu(
    page: 1,
    complains: [],
    labelBn: 'নিষ্পত্তিকৃত',
    labelEn: 'Resolved',
    value: 'resolved',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.check_circle_outline,
  ),
  ComplainMenu(
    page: 1,
    labelBn: 'অন্য দপ্তরে প্রেরিত',
    labelEn: 'Sent To Another Office',
    complains: [],
    value: 'another-office',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.bin_outline,
  ),
  ComplainMenu(
    page: 1,
    complains: [],
    value: 'overdue',
    labelEn: 'Overdue',
    labelBn: 'সময় অতিক্রান্ত',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.timer_outline,
  ),
  ComplainMenu(
    page: 1,
    value: 'copy',
    labelEn: 'Copy',
    labelBn: 'অনুলিপি',
    complains: [],
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.copy_outline,
  ),
];

final List<ComplainMenu> appealMenuList = [
  ComplainMenu(
    page: 1,
    complains: [],
    labelBn: 'আগত',
    labelEn: 'Incoming',
    value: 'arrival',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.arrow_circle_down_outline,
  ),
  ComplainMenu(
    page: 1,
    complains: [],
    labelBn: 'প্রেরিত',
    labelEn: 'Sent',
    value: 'dispatched',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.arrow_circle_right_outline,
  ),
  ComplainMenu(
    page: 1,
    complains: [],
    labelBn: 'নিষ্পত্তিকৃত',
    labelEn: 'Resolved',
    value: 'resolved',
    moreComplains: true,
    paginationLoader: false,
    icon: Assets.check_circle_outline,
  )
];
