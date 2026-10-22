import 'package:flutter_tts/flutter_tts.dart';

import '../domain/speech_synthesizer.dart';

class FlutterTtsSynthesizer implements SpeechSynthesizer {
  FlutterTtsSynthesizer(this._tts);

  final FlutterTts _tts;

  Future<void> initialize() async {
    await _tts.setLanguage('pt-BR');
    await _tts.setSpeechRate(0.4);
    await _tts.awaitSpeakCompletion(true);
  }

  @override
  Future<void> speak(String text) async {
    await _tts.speak(text);
  }

  @override
  Future<void> stop() async {
    await _tts.stop();
  }
}