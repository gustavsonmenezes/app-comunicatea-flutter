import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import 'app.dart';
import 'features/pronunciation/data/flutter_tts_synthesizer.dart';
import 'features/pronunciation/domain/speak_word.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final synthesizer = FlutterTtsSynthesizer(FlutterTts());
  await synthesizer.initialize();

  runApp(App(speakWord: SpeakWord(synthesizer)));
}