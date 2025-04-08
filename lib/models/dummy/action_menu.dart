import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class ActionMenu {
  String? icon;
  String labelBn;
  String labelEn;
  String value;

  ActionMenu({required this.labelBn, required this.labelEn, required this.value, this.icon});

  String get label => sl<StorageService>().getLanguage == 'bn' ? labelBn : labelEn;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['label_bn'] = labelBn;
    map['label_en'] = labelEn;
    map['value'] = value;
    return map;
  }
}

// Officer Menus
var send_for_opinion =
    ActionMenu(labelBn: 'মতামতের জন্য নিজ দপ্তরে প্রেরণ', labelEn: 'Forward to Service Officer in self office', value: 'send_opinion');
var give_opinion = ActionMenu(labelEn: 'Give Opinion', labelBn: 'মতামত প্রদান', value: 'give_opinion');

var another_office = ActionMenu(labelEn: 'Forward to Another Office', labelBn: 'অন্য দপ্তরে প্রেরণ', value: 'another_office');
var subordinate_office =
    ActionMenu(labelEn: 'Forward to Subordinate Office', labelBn: 'আওতাধীন দপ্তরে প্রেরণ', value: 'subordinate_office');
var subordinate_office_gro = ActionMenu(
    labelEn: "Forward to Subordinate Office's GRO", labelBn: 'মতামতের জন্য আওতাধীন দপ্তরে প্রেরণ', value: 'subordinate_office_gro');

var to_appeal_officer = ActionMenu(labelEn: 'Send to Appeal Officer', labelBn: 'আপিল অফিসারের নিকট প্রেরণ', value: 'to_appeal_officer');
var provide_services = ActionMenu(
    labelEn: 'Give guidelines to providing services', labelBn: 'সেবা প্রদান নির্দেশনা', value: 'guidelines_to_providing_services');

var send_for_permission =
    ActionMenu(labelEn: 'Send for permission', labelBn: 'অফিস প্রধানের অনুমতির জন্য প্রেরণ', value: 'send_for_permission');
var give_permission = ActionMenu(labelEn: 'Give permission', labelBn: 'অনুমতি দিন', value: 'give_permission');
var start_investigation = ActionMenu(labelEn: 'Start Investigation', labelBn: 'তদন্ত কার্যক্রম', value: 'start_investigation');
var investigation_report = ActionMenu(labelEn: 'Provide Investigation Report', labelBn: 'তদন্ত কার্যক্রম', value: 'submit_investigation');
var request_document = ActionMenu(labelEn: 'Request Document', labelBn: 'সাক্ষ্য-প্রমাণের অনুরোধ', value: 'request_document');

var hearing_notice = ActionMenu(labelEn: 'Hearing Notice', labelBn: 'শুনানীতে উপস্থিতির নির্দেশ', value: 'hearing_notice');
var take_hearing = ActionMenu(labelEn: 'Take Hearing', labelBn: 'শুনানী গ্রহণ', value: 'take_hearing');

var reject = ActionMenu(labelEn: 'Reject', labelBn: 'নথিজাত', value: 'reject');
var close_complain = ActionMenu(labelEn: 'Close complain', labelBn: 'অভিযোগ নিষ্পত্তি', value: 'close');

var provide_more_evidence = ActionMenu(labelEn: 'Provide More Evidence', labelBn: 'অতিরিক্ত সংযুক্তি', value: 'provide_more_evidence');
var approve_disapprove = ActionMenu(labelEn: 'Approve/Disapprove', labelBn: 'সহমত/দ্বিমত প্রকাশ', value: 'approve_disapprove');

// Citizen Menus
var rating = ActionMenu(labelEn: 'Ratings', labelBn: 'রেটিং', value: 'ratings');
var appeal = ActionMenu(labelEn: 'Appeal', labelBn: 'আপিল', value: 'appeal');
var hearing_date = ActionMenu(labelEn: 'See Date of Hearing', labelBn: 'শুনানির তারিখ দেখুন', value: 'hearing_date');
var evidence_material =
    ActionMenu(labelEn: 'Provide Evidence Material', labelBn: 'সাক্ষ্য-প্রমানের/তদন্তের উপাদান প্রদান', value: 'evidence_material');
