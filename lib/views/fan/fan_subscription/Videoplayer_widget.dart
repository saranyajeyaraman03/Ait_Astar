import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

 @override
void initState() {
  super.initState();
  try {
    print(widget.videoUrl);
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
        _controller.play();
      });
  } catch (e) {
    print("Error initializing video player: $e");
  }
}


  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: VideoPlayer(_controller),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
