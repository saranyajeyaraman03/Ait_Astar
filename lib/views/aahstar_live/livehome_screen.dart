import 'dart:io';

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';




void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstCamera = cameras.first;

  runApp(MaterialApp(
    home: LiveScreen([firstCamera]),
  ));
}

class LiveScreen extends StatelessWidget {
  final List<CameraDescription> cameras;

  const LiveScreen(this.cameras, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Camera App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: CameraScreen(cameras),
    );
  }
}

class CameraScreen extends StatefulWidget {
  final List<CameraDescription> cameras;

  const CameraScreen(this.cameras, {Key? key}) : super(key: key);

  @override
  CameraScreenState createState() => CameraScreenState();
}

class CameraScreenState extends State<CameraScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  late int _selectedCameraIndex;
  bool _isFlashEnabled = false; 
  bool _isFrontCamera = false; 

 String? userName;

  @override
  void initState() {
    super.initState();
    _selectedCameraIndex = 0;
    _initializeCamera();
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    authHelper.getUserName().then((String? retrievedUserName) {
      if (retrievedUserName != null) {
        setState(() {
          userName = retrievedUserName;
        });
      }
    });
  }
 

  Future<void> _initializeCamera() async {
    final selectedCamera = widget.cameras[_selectedCameraIndex];
    _controller = CameraController(selectedCamera, ResolutionPreset.high);
    _initializeControllerFuture = _controller.initialize();
  }

  void _toggleFlash() {
    setState(() {
      _isFlashEnabled = !_isFlashEnabled;
      _controller.setFlashMode(
          _isFlashEnabled ? FlashMode.torch : FlashMode.off);
    });
  }

  void _toggleCamera() async {
    await _controller.dispose();
    _isFrontCamera = !_isFrontCamera;
    _selectedCameraIndex =
        _isFrontCamera ? 0 : 1; 
    await _initializeCamera();
    setState(() {});
  }

Future<Directory?> getExternalStorageDirectory() async {
  return await getExternalStorageDirectory();
}

  Future<XFile?> _takeVideo() async {
    if (!_controller.value.isRecordingVideo) {
      final Directory? externalDir = await getExternalStorageDirectory();
      if (externalDir != null) {
        final String videoPath =
            '${externalDir.path}/video_${DateTime.now()}.mp4';
print(videoPath);
        try {
          await _controller.startVideoRecording();
        } catch (e) {
          print('Error starting video recording: $e');
          return null;
        }

        return XFile(videoPath);
      }
    } else {
      final XFile videoFile = await _controller.stopVideoRecording();
      await _stopVideoRecordingOnServer(videoFile.path);

      return videoFile;
    }

    return null;
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CameraPreview(_controller);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              _toggleFlash(); 
            },
            backgroundColor:
                _isFlashEnabled ? Colors.blue : Colors.red, 
            child: Icon(
              _isFlashEnabled ? Icons.flash_on : Icons.flash_off, 
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              await _takeVideo(); 
            },
             backgroundColor:
                _controller.value.isRecordingVideo ? Colors.red : Colors.blue,
            child: Icon(
              _controller.value.isRecordingVideo
                  ? Icons.stop
                  : Icons.fiber_manual_record,
            ),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            onPressed: () async {
              _toggleCamera(); 
            },
            child: Icon(
              _isFrontCamera ? Icons.camera_rear : Icons.camera_front, 
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}


// // ignore_for_file: use_build_context_synchronously

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
