import 'package:flutter/material.dart';

import '../domain/speak_word.dart';
import 'pronunciation_controller.dart';

class PronunciationPage extends StatefulWidget {
  const PronunciationPage({super.key, required this.speakWord});

  final SpeakWord speakWord;

  @override
  State<PronunciationPage> createState() => _PronunciationPageState();
}

class _PronunciationPageState extends State<PronunciationPage> {
  static const _word = 'Água';

  late final PronunciationController _controller =
  PronunciationController(widget.speakWord);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Teste de voz')),
      body: Center(
        child: ListenableBuilder(
          listenable: _controller,
          builder: (context, _) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(_word, style: Theme.of(context).textTheme.displayMedium),
                const SizedBox(height: 24),
                FilledButton.icon(
                  onPressed:
                  _controller.isSpeaking ? null : () => _controller.speak(_word),
                  icon: const Icon(Icons.volume_up),
                  label: const Text('Ouvir'),
                ),
                if (_controller.errorMessage case final message?) ...[
                  const SizedBox(height: 16),
                  Text(message, style: const TextStyle(color: Colors.red)),
                ],
              ],
            );
          },
        ),
      ),
    );
  }
}