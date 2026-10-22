import 'package:flutter/material.dart';

import 'features/pronunciation/domain/speak_word.dart';
import 'features/pronunciation/presentation/pronunciation_page.dart';

class App extends StatelessWidget {
  const App({super.key, required this.speakWord});

  final SpeakWord speakWord;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AppComunicaTEA',
      theme: ThemeData(colorSchemeSeed: Colors.teal),
      home: PronunciationPage(speakWord: speakWord),
    );
  }
}