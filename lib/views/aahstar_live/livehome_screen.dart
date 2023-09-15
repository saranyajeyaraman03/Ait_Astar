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

  String? userName;

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
      await controller.dispose();
      controller = CameraController(newDescription, ResolutionPreset.high);
      await controller.initialize();
      setState(() {});
    }
  }

  Future<void> _startRecording() async {
    if (!controller.value.isInitialized) {
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
    if (!controller.value.isRecordingVideo) {
      return;
    }

    try {
      final XFile videoFile = await controller.stopVideoRecording();
      //await controller.stopVideoRecording();
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: CameraPreview(controller),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              IconButton(
                icon: const Icon(Icons.switch_camera),
                onPressed: _toggleCamera,
              ),
              isRecording
                  ? IconButton(
                      icon: const Icon(
                        Icons.stop,
                        color: Colors.redAccent,
                      ),
                      onPressed: _stopRecording,
                    )
                  : IconButton(
                      icon: const Icon(
                        Icons.fiber_manual_record,
                      ),
                      onPressed: _startRecording,
                    ),
            ],
          ),
        ],
      ),
    );
  }
}




// class CameraPage extends StatefulWidget {
//   const CameraPage({Key? key}) : super(key: key);

//   @override
//   _CameraPageState createState() => _CameraPageState();
// }

// class _CameraPageState extends State<CameraPage> {

//   void moveVideoFile(String sourcePath, String destinationPath) {
//   final sourceFile = File(sourcePath);
//   final destinationFile = File(destinationPath);
//           print("Video recorded1: $destinationFile");


//   sourceFile.renameSync(destinationPath);
// }

//   @override
//   Widget build(BuildContext context) {
//     return FlutterCamera(
//       color: Colors.amber,
//       onImageCaptured: (value) {
//         final path = value.path;
//         print("Image captured: $path");
//         if (path.contains('.jpg')) {
//           showDialog(
//             context: context,
//             builder: (context) {
//               return AlertDialog(
//                 content: Image.file(File(path)),
//               );
//             },
//           );
//         }
//       },
//       onVideoRecorded: (value) {
//         final path = value.path;
//         print("Video recorded: $path");
//         moveVideoFile(value.path, 'custom/path/liveVideo.mp4');

//         // You can now use the video file path for further processing.
//       },
//     );
//   }
// }


// // // ignore_for_file: use_build_context_synchronously

// import 'package:aahstar/service/remote_service.dart';
// import 'package:aahstar/views/auth/auth_helper.dart';
// import 'package:flutter/material.dart';
// import 'package:camera/camera.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:path/path.dart' as path;

// import 'dart:io';

// import 'package:provider/provider.dart';

// class LiveScreen extends StatelessWidget {
//   final List<CameraDescription> cameras;

//   const LiveScreen(this.cameras, {super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Camera App',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: CameraScreen(cameras),
//     );
//   }
// }

// class CameraScreen extends StatefulWidget {
//   final List<CameraDescription> cameras;

//   const CameraScreen(this.cameras, {super.key});

//   @override
//   CameraScreenState createState() => CameraScreenState();
// }

// class CameraScreenState extends State<CameraScreen> {
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//   late int _selectedCameraIndex;

//   String? userName;

//   @override
//   void initState() {
//     super.initState();
//     _selectedCameraIndex = 0;
//     _initializeCamera();
//     AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
//     authHelper.getUserName().then((String? retrievedUserName) {
//       if (retrievedUserName != null) {
//         setState(() {
//           userName = retrievedUserName;
//         });
//       }
//     });
//   }

//   Future<void> _initializeCamera() async {
//     final selectedCamera = widget.cameras[_selectedCameraIndex];
//     _controller = CameraController(selectedCamera, ResolutionPreset.high);
//     _initializeControllerFuture = _controller.initialize();
//   }

//   void _toggleCamera() async {
//     await _controller.dispose();
//     _selectedCameraIndex = (_selectedCameraIndex + 1) % widget.cameras.length;
//     await _initializeCamera();
//     setState(() {});
//   }

//   Future<XFile?> _takeVideo() async {
//     if (!_controller.value.isRecordingVideo) {
//       final Directory? externalDir = await getExternalStorageDirectory();
//       if (externalDir != null) {
//         final String videoPath =
//             '${externalDir.path}/video_${DateTime.now()}.mp4';

//         try {
//           await _controller.startVideoRecording();
//         } catch (e) {
//           print('Error starting video recording: $e');
//           return null;
//         }

//         return XFile(videoPath);
//       }
//     } else {
//       final XFile videoFile = await _controller.stopVideoRecording();
//       await _stopVideoRecordingOnServer(videoFile.path);

//       return videoFile;
//     }

//     return null;
//   }

//   Future<void> _stopVideoRecordingOnServer(String videoFilePath) async {
//     if (videoFilePath.isNotEmpty) {
//       try {
//         print('SaranyaVideoFile: $videoFilePath');

//         String fileName = path.basename(videoFilePath);
//         print('File Name: $fileName');
//         final response = await RemoteServices.uploadLiveVideo(
//             userName: userName!,
//             videoFile: File(videoFilePath),
//             fileName: fileName);
//         print(response.body);

//         if (response.statusCode == 200) {
//           print('Video recording Upload on the server.');
//         } else {
//           print( 'Error stopping video recording on the server: ${response.reasonPhrase}');
//         }
//       } catch (e) {
//         print('Error stopping video recording on the server: $e');
//       }
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder<void>(
//         future: _initializeControllerFuture,
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return CameraPreview(_controller);
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//       floatingActionButton: Column(
//         mainAxisAlignment: MainAxisAlignment.end,
//         children: [
//           FloatingActionButton(
//             onPressed: () async {
//               await _takeVideo();
//               setState(() {});
//             },
//             backgroundColor:
//                 _controller.value.isRecordingVideo ? Colors.red : Colors.blue,
//             child: Icon(
//               _controller.value.isRecordingVideo
//                   ? Icons.stop
//                   : Icons.fiber_manual_record,
//             ),
//           ),
//           const SizedBox(height: 16),
//           FloatingActionButton(
//             onPressed: _toggleCamera,
//             child: const Icon(Icons.switch_camera),
//           ),
//         ],
//       ),
//       floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
//     );
//   }
// }
