import 'package:flutter_tts/flutter_tts.dart';

import 'package:grs/di.dart';
import 'package:grs/service/storage_service.dart';

class TextToSpeak {
  FlutterTts flutterTts = FlutterTts();

  Future<void> startSpeaking(String text) async {
    var language = sl<StorageService>().getLanguage;
    var locale = language == 'bn' ? 'bn_BD' : 'en_US';
    var languageLabel = language == 'bn' ? 'Bangla' : 'English';
    await flutterTts.setLanguage(locale);
    await flutterTts.setVoice({'name': languageLabel, 'locale': locale});
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }
}
