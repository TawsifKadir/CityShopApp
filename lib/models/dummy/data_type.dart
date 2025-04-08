import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class DataType {
  String labelBn;
  String labelEn;
  String value;

  DataType({required this.labelBn, required this.labelEn, required this.value});

  String get label => sl<StorageService>().getLanguage == 'bn' ? labelBn : labelEn;

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['label_bn'] = labelBn;
    map['label_en'] = labelEn;
    map['value'] = value;
    return map;
  }
}

var citizen_module = DataType(labelEn: 'Complainant Login', labelBn: 'অভিযোগকারী লগইন', value: 'citizen');
var officer_module = DataType(labelEn: 'Administrative Login', labelBn: 'প্রশাসনিক লগইন', value: 'officer');

final List<DataType> complain_categories = [
  DataType(labelEn: 'General', labelBn: 'সাধারণ', value: '1'),
  DataType(labelEn: 'Safety Net', labelBn: 'সামাজিক সুরক্ষা ভাতা', value: '2'),
];

final List<DataType> gender_types = [
  DataType(labelEn: 'Male', labelBn: 'পুরুষ', value: 'MALE'),
  DataType(labelEn: 'Female', labelBn: 'নারী', value: 'FEMALE'),
  DataType(labelEn: 'Others', labelBn: 'অন্যান্য', value: 'OTHERS'),
];

final List<DataType> suggestion_subjects = [
  DataType(labelEn: 'Service Simplification', labelBn: 'সেবা সহজিকরন', value: 'SERVICE_SIMPLIFICATION'),
  DataType(labelEn: 'Law and Regulation Reforms', labelBn: 'আইন, বিধি, সংস্কার', value: 'LAW_REFORMS'),
  DataType(labelEn: 'New Idea', labelBn: 'নতুন আইডিয়া', value: 'NEW_IDEA'),
];

final List<DataType> probable_effects = [
  DataType(labelEn: 'Service Quality Will Increase', labelBn: 'সেবার গুনগত মান বৃদ্ধি পাবে', value: 'BETTER_SERVICE'),
  DataType(labelEn: 'Time Cost and Conveyance Will Be Minimized', labelBn: 'সময়, ব্যায় ও যাতায়াত হ্রাস পাবে', value: 'LESS_TIME_EXPENSE'),
  DataType(labelEn: 'Corruption Will Be Minimized', labelBn: 'দুর্নীতি হ্রাস পাবে', value: 'LESS_CORRUPTION'),
  DataType(labelEn: 'Other', labelBn: 'অন্যান্য', value: 'OTHER'),
];

final List<DataType> identity_types = [
  DataType(labelEn: 'National Id', labelBn: 'জাতীয় পরিচয়পত্র নম্বর', value: 'NID'),
  DataType(labelEn: 'Birth Certificate Number', labelBn: 'জন্ম নিবন্ধন সনদ নম্বর', value: 'BCN'),
  DataType(labelEn: 'Passport Number', labelBn: 'পাসপোর্ট নম্বর', value: 'PASSPORT'),
];

final List<DataType> language_types = [
  DataType(labelEn: 'Bangla', labelBn: 'বাংলা', value: 'bn'),
  DataType(labelEn: 'English', labelBn: 'ইংরেজি', value: 'en'),
];

final List<DataType> settlement_types = [
  DataType(
    labelEn: 'Allegations have been found to be true',
    labelBn: 'অভিযোগের সত্যতা পাওয়া গিয়েছে',
    value: 'CLOSED_ACCUSATION_PROVED',
  ),
  DataType(
    labelEn: 'The allegations were not substantiated',
    labelBn: 'অভিযোগের সত্যতা পাওয়া যায় নি',
    value: 'CLOSED_ACCUSATION_INCORRECT',
  ),
  DataType(labelEn: 'Other', labelBn: 'অন্যান্য', value: 'CLOSED_OTHERS'),
];
