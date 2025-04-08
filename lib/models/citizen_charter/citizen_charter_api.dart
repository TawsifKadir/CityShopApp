import 'package:grs/models/citizen_charter/charter_details.dart';
import 'package:grs/models/citizen_charter/vision.dart';

class CitizenCharterApi {
  Vision? vision;
  CharterDetails? charterDetails;

  CitizenCharterApi({this.vision, this.charterDetails});

  CitizenCharterApi.fromJson(json) {
    vision = json['visions'] != null ? Vision.fromJson(json['visions']) : null;
    charterDetails = json['CitizenCharterDetailsInfo'] != null ? CharterDetails.fromJson(json['CitizenCharterDetailsInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (vision != null) map['visions'] = vision?.toJson();
    if (charterDetails != null) map['CitizenCharterDetailsInfo'] = charterDetails?.toJson();
    return map;
  }
}
