import 'package:flutter/material.dart';

import '../domain/listen_for_attempt.dart';
import 'attempt_controller.dart';

class AttemptSection extends StatefulWidget {
  const AttemptSection({super.key, required this.listenForAttempt});

  final ListenForAttempt listenForAttempt;

  @override
  State<AttemptSection> createState() => _AttemptSectionState();
}

class _AttemptSectionState extends State<AttemptSection> {
  late final AttemptController _controller =
      AttemptController(widget.listenForAttempt);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FilledButton.tonalIcon(
              onPressed: _controller.isListening ? null : _controller.start,
              icon: Icon(_controller.isListening ? Icons.hearing : Icons.mic),
              label: const Text('Falar'),
            ),
            const SizedBox(height: 16),
            Text(
              _messageFor(_controller.status),
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
          ],
        );
      },
    );
  }

  String _messageFor(AttemptStatus status) => switch (status) {
        AttemptStatus.idle => 'Toque em "Falar" e diga a palavra',
        AttemptStatus.listening => 'Estou ouvindo...',
        AttemptStatus.success => 'Muito bem! Você tentou!',
        AttemptStatus.silence => 'Não ouvi nada. Vamos tentar de novo?',
        AttemptStatus.permissionDenied =>
          'Permita o uso do microfone nas configurações do aparelho.',
        AttemptStatus.error => 'Não foi possível usar o microfone.',
      };
}
