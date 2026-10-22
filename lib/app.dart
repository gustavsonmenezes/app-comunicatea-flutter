import 'package:flutter/material.dart';

import 'features/pronunciation/domain/speak_word.dart';
import 'features/pronunciation/presentation/pronunciation_page.dart';
import 'features/speech_attempt/domain/listen_for_attempt.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required this.speakWord,
    required this.listenForAttempt,
  });

  final SpeakWord speakWord;
  final ListenForAttempt listenForAttempt;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppComunicaTEA',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: PronunciationPage(
        speakWord: speakWord,
        listenForAttempt: listenForAttempt,
      ),
    );
  }
}
