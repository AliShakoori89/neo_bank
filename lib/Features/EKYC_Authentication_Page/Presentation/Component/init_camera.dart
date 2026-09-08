import 'package:camera/camera.dart';
import '../../../../main.dart';

class CameraHelper {
  static Future<CameraController> initCamera() async {
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );

    final controller = CameraController(
      frontCamera,
      ResolutionPreset.low,
      enableAudio: true,
    );

    await controller.initialize();

    return controller;
  }
}
