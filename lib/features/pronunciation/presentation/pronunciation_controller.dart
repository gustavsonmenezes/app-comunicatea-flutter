import 'package:flutter/foundation.dart';

import '../domain/speak_word.dart';

class PronunciationController extends ChangeNotifier {
  PronunciationController(this._speakWord);

  final SpeakWord _speakWord;

  bool _isSpeaking = false;
  String? _errorMessage;

  bool get isSpeaking => _isSpeaking;
  String? get errorMessage => _errorMessage;

  Future<void> speak(String word) async {
    if (_isSpeaking) return;

    _isSpeaking = true;
    _errorMessage = null;
    notifyListeners();

    try {
      await _speakWord(word);
    } on Exception catch (error) {
      _errorMessage = 'Não foi possível reproduzir o áudio.';
      debugPrint('TTS falhou: $error');
    } finally {
      _isSpeaking = false;
      notifyListeners();
    }
  }
}