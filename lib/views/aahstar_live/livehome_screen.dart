import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'dart:io';

import 'package:provider/provider.dart';

class CameraApp extends StatefulWidget {
  final List<CameraDescription> cameras;

  CameraApp({required this.cameras});

  @override
  _CameraAppState createState() => _CameraAppState();
}

class _CameraAppState extends State<CameraApp> {
  late CameraController controller;
  late bool isRecording = false;
  late String videoPath;
  late FlashMode flashMode = FlashMode.off; // Initialize flash mode
  String? userName;
  bool isControllerDisposed = false; // Track the controller's disposal state

  @override
  void initState() {
    super.initState();
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    authHelper.getUserName().then((String? retrievedUserName) {
      if (retrievedUserName != null) {
        setState(() {
          userName = retrievedUserName;
        });
      }
    });
    controller = CameraController(widget.cameras[0], ResolutionPreset.high);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<void> _toggleCamera() async {
    if (isControllerDisposed) {
      return; // Check if the controller has been disposed
    }

    final lensDirection = controller.description.lensDirection;
    CameraDescription newDescription;

    if (lensDirection == CameraLensDirection.front) {
      newDescription = widget.cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = widget.cameras.firstWhere((description) =>
          description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      final isRecordingInProgress = isRecording;
      if (isRecordingInProgress) {
        await _stopRecording();
      }

      await controller.dispose();
      isControllerDisposed = true; // Set the controller's disposal state
      controller = CameraController(newDescription, ResolutionPreset.high);
      await controller.initialize();
      isControllerDisposed = false; // Reset the controller's disposal state
      if (isRecordingInProgress) {
        await _startRecording();
      }
      setState(() {});
    }
  }

  Future<void> _toggleFlashlight() async {
    if (controller.value.isInitialized) {
      if (flashMode == FlashMode.off) {
        flashMode = FlashMode.torch;
      } else {
        flashMode = FlashMode.off;
      }

      await controller.setFlashMode(flashMode);
      setState(() {});
    }
  }

  Future<void> _startRecording() async {
    if (!controller.value.isInitialized || isRecording) {
      return;
    }

    try {
      await controller.startVideoRecording();
      setState(() {
        isRecording = true;
      });
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopRecording() async {
    if (!controller.value.isRecordingVideo || !isRecording) {
      return;
    }

    try {
      final XFile videoFile = await controller.stopVideoRecording();
      setState(() {
        isRecording = false;
      });
      print('Video saved to: ${videoFile.path}');
      await _stopVideoRecordingOnServer(videoFile.path);
    } catch (e) {
      print(e);
    }
  }

  Future<void> _stopVideoRecordingOnServer(String videoFilePath) async {
    if (videoFilePath.isNotEmpty) {
      try {
        print('SaranyaVideoFile: $videoFilePath');

        String fileName = path.basename(videoFilePath);
        print('File Name: $fileName');
        final response = await RemoteServices.uploadLiveVideo(
            userName: userName!,
            videoFile: File(videoFilePath),
            fileName: fileName);
        print(response.body);

        if (response.statusCode == 200) {
          print('Video recording Upload on the server.');
        } else {
          print(
              'Error stopping video recording on the server: ${response.reasonPhrase}');
        }
      } catch (e) {
        print('Error stopping video recording on the server: $e');
      }
    }
  }

  Widget _buildRecordingIndicator() {
    if (controller == null || isControllerDisposed) {
      return Container();
    }

    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        width: 40,
        height: 40,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.red,
        ),
        child: const Center(
          child: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
            size: 16,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Camera preview
          Positioned.fill(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),

          // Recording indicator (conditionally displayed)
          if (isRecording) _buildRecordingIndicator(),

          Align(
            alignment: Alignment.topLeft,
            child: Container(
              margin: const EdgeInsets.only(top: 20),
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.switch_camera,
                      size: 40,
                      color: Colors.orange,
                    ),
                    onPressed: _toggleCamera,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  IconButton(
                    icon: Icon(
                      flashMode == FlashMode.off
                          ? Icons.flash_off
                          : Icons.flash_on,
                      size: 40,
                      color: Colors.orange,
                    ),
                    onPressed: _toggleFlashlight,
                  ),
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: isRecording
                  ? IconButton(
                      icon: const Icon(
                        Icons.stop,
                        size: 50,
                        color: Colors.redAccent,
                      ),
                      onPressed: _stopRecording,
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.fiber_manual_record,
                        size: 50,
                        color: Colors.white,
                      ),
                      onPressed: _startRecording,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}
