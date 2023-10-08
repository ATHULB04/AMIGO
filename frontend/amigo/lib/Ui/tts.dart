import 'package:flutter_tts/flutter_tts.dart';

class TextToSpeech {
  static FlutterTts tts = FlutterTts();
  static initTTS() async {
    await tts.setLanguage("en-US");
  }

  static speak() async {
    print("hello world");

    await tts.speak("hello world");
  }
}
