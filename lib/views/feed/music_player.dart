import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';


class MusicPlayerWidget extends StatefulWidget {
  final String musicUrl;

  const MusicPlayerWidget({super.key, required this.musicUrl});

  @override
  MusicPlayerWidgetState createState() => MusicPlayerWidgetState();
}

class MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  final AudioPlayer audioPlayer = AudioPlayer();
  bool isPlaying = false;
  Duration currentPosition = const Duration(seconds: 0);
  Duration totalDuration = const Duration(seconds: 0);

  @override
  void initState() {
    super.initState();

    audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          isPlaying = false;
        });
      }
    });

    audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        totalDuration = duration;
      });
    });

    audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        currentPosition = position;
      });
    });
  }

  Future<void> togglePlayPause() async {
    if (isPlaying) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play(UrlSource(widget.musicUrl),);
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  @override
  void dispose() {
    audioPlayer.dispose(); 
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
         
          SizedBox(
            width: MediaQuery.of(context).size.width,
            child: ElevatedButton(
              onPressed: () {
                togglePlayPause();
              },
              child: Text(isPlaying ? 'Pause Music' : 'Play Music'),
            ),
          ),
          const SizedBox(height: 20),
         
          Text(
            '${currentPosition.inMinutes}:${(currentPosition.inSeconds % 60).toString().padLeft(2, '0')} / ${totalDuration.inMinutes}:${(totalDuration.inSeconds % 60).toString().padLeft(2, '0')}',
            style: const TextStyle(fontSize: 16),
          ),
          Slider(
            value: currentPosition.inSeconds.toDouble(),
            max: totalDuration.inSeconds.toDouble(),
            onChanged: (double value) {
              // Seek to the specified position
              audioPlayer.seek(Duration(seconds: value.toInt()));
            },
          ),
        ],
      ),
    );
  }
}
