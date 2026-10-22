import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';

import 'package:record/record.dart';

import '../domain/attempt_listener.dart';
import '../domain/attempt_result.dart';

class RecordAttemptListener implements AttemptListener {
  RecordAttemptListener(this._recorder);

  final AudioRecorder _recorder;

  /// Nível RMS normalizado (0 a 1) acima do qual consideramos que houve som.
  static const _soundThreshold = 0.02;

  static const _config = RecordConfig(
    encoder: AudioEncoder.pcm16bits,
    sampleRate: 16000,
    numChannels: 1,
  );

  @override
  Future<AttemptResult> listen({required Duration duration}) async {
    if (!await _recorder.hasPermission()) {
      return AttemptResult.permissionDenied;
    }

    var soundDetected = false;
    final stream = await _recorder.startStream(_config);
    final subscription = stream.listen((chunk) {
      if (!soundDetected && _rms(chunk) > _soundThreshold) {
        soundDetected = true;
      }
    });

    try {
      await Future<void>.delayed(duration);
    } finally {
      await _recorder.stop();
      await subscription.cancel();
    }

    return soundDetected ? AttemptResult.soundDetected : AttemptResult.silence;
  }

  double _rms(Uint8List bytes) {
    final sampleCount = bytes.lengthInBytes ~/ 2;
    if (sampleCount == 0) return 0;

    final data = ByteData.sublistView(bytes);
    var sumOfSquares = 0.0;
    for (var i = 0; i < sampleCount; i++) {
      final sample = data.getInt16(i * 2, Endian.little) / 32768;
      sumOfSquares += sample * sample;
    }
    return math.sqrt(sumOfSquares / sampleCount);
  }
}
