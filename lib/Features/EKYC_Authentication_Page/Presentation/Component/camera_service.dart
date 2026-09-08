import 'dart:async';
import 'package:camera/camera.dart';

class CameraService {
  Timer? _timer;

  Future<XFile?> startRecording({
    required CameraController controller,
    required int recordDuration,
    required Function(int currentSecond) onTick,
  }) async {
    if (!controller.value.isInitialized) {
      return null;
    }
    if (controller.value.isRecordingVideo) {
      return null;
    }
    await controller.startVideoRecording();
    var currentSecond = 0;
    onTick(currentSecond);
    final completer = Completer<XFile?>();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      currentSecond++;
      onTick(currentSecond);
      if (currentSecond >= recordDuration) {
        timer.cancel();
        _timer = null;
        final file = await controller.stopVideoRecording();
        if (!completer.isCompleted) {
          completer.complete(file);
        }
      }
    });
    return completer.future;
  }

  Future<XFile?> stopRecording({required CameraController controller}) async {
    _timer?.cancel();
    _timer = null;
    if (!controller.value.isRecordingVideo) {
      return null;
    }
    return controller.stopVideoRecording();
  }

  void dispose() {
    _timer?.cancel();
    _timer = null;
  }
}
