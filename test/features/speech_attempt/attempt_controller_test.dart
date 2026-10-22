import 'package:app_comunicatea/features/speech_attempt/domain/attempt_listener.dart';
import 'package:app_comunicatea/features/speech_attempt/domain/attempt_result.dart';
import 'package:app_comunicatea/features/speech_attempt/domain/listen_for_attempt.dart';
import 'package:app_comunicatea/features/speech_attempt/presentation/attempt_controller.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeListener implements AttemptListener {
  _FakeListener(this.result);

  final AttemptResult result;
  Duration? requestedDuration;

  @override
  Future<AttemptResult> listen({required Duration duration}) async {
    requestedDuration = duration;
    return result;
  }
}

class _ThrowingListener implements AttemptListener {
  @override
  Future<AttemptResult> listen({required Duration duration}) {
    throw Exception('microfone indisponível');
  }
}

AttemptController _controllerWith(AttemptListener listener) =>
    AttemptController(ListenForAttempt(listener));

void main() {
  test('começa ocioso', () {
    final controller = _controllerWith(
      _FakeListener(AttemptResult.soundDetected),
    );

    expect(controller.status, AttemptStatus.idle);
  });

  test('marca sucesso quando detecta som', () async {
    final controller = _controllerWith(
      _FakeListener(AttemptResult.soundDetected),
    );

    await controller.start();

    expect(controller.status, AttemptStatus.success);
  });

  test('marca silêncio quando não detecta som', () async {
    final controller = _controllerWith(_FakeListener(AttemptResult.silence));

    await controller.start();

    expect(controller.status, AttemptStatus.silence);
  });

  test('informa permissão negada', () async {
    final controller = _controllerWith(
      _FakeListener(AttemptResult.permissionDenied),
    );

    await controller.start();

    expect(controller.status, AttemptStatus.permissionDenied);
  });

  test('marca erro quando o listener lança exceção', () async {
    final controller = _controllerWith(_ThrowingListener());

    await controller.start();

    expect(controller.status, AttemptStatus.error);
  });

  test('usa a janela de escuta configurada', () async {
    final listener = _FakeListener(AttemptResult.silence);
    final controller = AttemptController(
      ListenForAttempt(listener, window: const Duration(seconds: 3)),
    );

    await controller.start();

    expect(listener.requestedDuration, const Duration(seconds: 3));
  });
}
