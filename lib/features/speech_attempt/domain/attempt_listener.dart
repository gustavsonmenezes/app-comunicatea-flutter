import 'attempt_result.dart';

abstract interface class AttemptListener {
  Future<AttemptResult> listen({required Duration duration});
}
