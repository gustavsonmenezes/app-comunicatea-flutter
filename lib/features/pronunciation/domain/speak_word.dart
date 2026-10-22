import 'speech_synthesizer.dart';

class SpeakWord {
  const SpeakWord(this._synthesizer);

  final SpeechSynthesizer _synthesizer;

  Future<void> call(String word) {
    final text = word.trim();
    if (text.isEmpty) {
      throw ArgumentError.value(word, 'word', 'não pode ser vazia');
    }
    return _synthesizer.speak(text);
  }
}