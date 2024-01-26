import 'package:speech_to_text/speech_recognition_error.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextSingleton {
  static final SpeechToTextSingleton _singleton =
      SpeechToTextSingleton._internal();
  late stt.SpeechToText _speechToText;

  factory SpeechToTextSingleton() {
    return _singleton;
  }

  SpeechToTextSingleton._internal() {
    _speechToText = stt.SpeechToText();
  }

  Future<bool> initSpeechToText(
      {void Function(SpeechRecognitionError)? onError,
      void Function(String)? onStatus}) async {
    bool hasSpeech =
        await _speechToText.initialize(onError: onError, onStatus: onStatus);

    return hasSpeech;
  }

  stt.SpeechToText get speechToText => _speechToText;
}
