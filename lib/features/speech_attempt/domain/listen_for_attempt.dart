import 'attempt_listener.dart';
import 'attempt_result.dart';

class ListenForAttempt {
  const ListenForAttempt(
    this._listener, {
    this.window = const Duration(seconds: 5),
  });

  final AttemptListener _listener;
  final Duration window;

  Future<AttemptResult> call() => _listener.listen(duration: window);
}
