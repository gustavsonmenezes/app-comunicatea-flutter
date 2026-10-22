import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:record/record.dart';

import 'app.dart';
import 'features/pronunciation/data/flutter_tts_synthesizer.dart';
import 'features/pronunciation/domain/speak_word.dart';
import 'features/speech_attempt/data/record_attempt_listener.dart';
import 'features/speech_attempt/domain/listen_for_attempt.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final synthesizer = FlutterTtsSynthesizer(FlutterTts());
  await synthesizer.initialize();

  final attemptListener = RecordAttemptListener(AudioRecorder());

  runApp(
    App(
      speakWord: SpeakWord(synthesizer),
      listenForAttempt: ListenForAttempt(attemptListener),
    ),
  );
}
