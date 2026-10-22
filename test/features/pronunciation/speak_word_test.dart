import 'package:app_comunicatea/features/pronunciation/domain/speak_word.dart';
import 'package:app_comunicatea/features/pronunciation/domain/speech_synthesizer.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeSynthesizer implements SpeechSynthesizer {
  final spoken = <String>[];

  @override
  Future<void> speak(String text) async => spoken.add(text);

  @override
  Future<void> stop() async {}
}

void main() {
  late _FakeSynthesizer synthesizer;
  late SpeakWord speakWord;

  setUp(() {
    synthesizer = _FakeSynthesizer();
    speakWord = SpeakWord(synthesizer);
  });

  test('envia a palavra sem espaços extras ao sintetizador', () async {
    await speakWord('  água ');

    expect(synthesizer.spoken, ['água']);
  });

  test('rejeita palavra vazia', () {
    expect(() => speakWord('   '), throwsArgumentError);
  });
}