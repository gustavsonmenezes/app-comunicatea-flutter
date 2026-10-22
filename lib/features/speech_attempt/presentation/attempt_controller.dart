import 'package:flutter/foundation.dart';

import '../domain/attempt_result.dart';
import '../domain/listen_for_attempt.dart';

enum AttemptStatus {
  idle,
  listening,
  success,
  silence,
  permissionDenied,
  error,
}

class AttemptController extends ChangeNotifier {
  AttemptController(this._listenForAttempt);

  final ListenForAttempt _listenForAttempt;

  AttemptStatus _status = AttemptStatus.idle;
  bool _disposed = false;

  AttemptStatus get status => _status;
  bool get isListening => _status == AttemptStatus.listening;

  Future<void> start() async {
    if (isListening) return;

    _update(AttemptStatus.listening);

    try {
      final result = await _listenForAttempt();
      _update(switch (result) {
        AttemptResult.soundDetected => AttemptStatus.success,
        AttemptResult.silence => AttemptStatus.silence,
        AttemptResult.permissionDenied => AttemptStatus.permissionDenied,
      });
    } on Exception catch (error) {
      debugPrint('Captação de áudio falhou: $error');
      _update(AttemptStatus.error);
    }
  }

  void _update(AttemptStatus status) {
    if (_disposed) return;
    _status = status;
    notifyListeners();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }
}
