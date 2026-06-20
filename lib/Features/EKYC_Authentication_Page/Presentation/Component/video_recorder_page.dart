import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class VideoRecorderPage extends StatefulWidget {
  final CameraDescription camera;

  const VideoRecorderPage({
    super.key,
    required this.camera,
  });

  @override
  State<VideoRecorderPage> createState() => _VideoRecorderPageState();
}

class _VideoRecorderPageState extends State<VideoRecorderPage> {
  late CameraController _controller;
  bool isRecording = false;

  @override
  void initState() {
    super.initState();

    _controller = CameraController(
      widget.camera,
      ResolutionPreset.high,
      enableAudio: true,
    );

    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    await _controller.initialize();

    if (mounted) {
      setState(() {});
    }
  }

  Future<void> _toggleRecording() async {
    if (!_controller.value.isInitialized) return;

    if (!isRecording) {
      await _controller.startVideoRecording();

      setState(() {
        isRecording = true;
      });
    } else {
      final XFile file = await _controller.stopVideoRecording();

      setState(() {
        isRecording = false;
      });

      if (mounted) {
        Navigator.pop(context, File(file.path));
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!_controller.value.isInitialized) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(_controller),
          ),
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _toggleRecording,
                child: Icon(
                  isRecording ? Icons.stop : Icons.videocam,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}