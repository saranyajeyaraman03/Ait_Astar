import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/widgets/livestream-dialog.dart';
import 'package:aahstar/widgets/music_dialog.dart';
import 'package:aahstar/widgets/photo_dialog.dart';
import 'package:aahstar/widgets/video_dialog.dart';
import 'package:aahstar/widgets/youtube_dialog.dart';
import 'package:flutter/material.dart';

class UploadContentScreen extends StatefulWidget {
  const UploadContentScreen({Key? key}) : super(key: key);

  @override
  State<UploadContentScreen> createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  List<String> items = [
    'fa-camera-retro Music',
    'Personal Video',
    'Youtube Video',
    "Lived-Streamed Recorded video",
    'Photo',
    'Message',
    'Trash Talk',
    "Raffle Drawing",
    "Cash App Winner",
    "Event"
  ];

  List<String> icons = [
    'assets/music_icon.png',
    'assets/video_icon.png',
    'assets/youtube_icon.png',
    "assets/video_stream_icon.png",
    'assets/camera_icon.png',
    'assets/message_icon.jpg',
    'assets/trash_icon.png',
    'assets/raffle_icon.png',
    'assets/winner_icon.png',
    "assets/event_icon.jpg"
  ];

  void showMusicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const MusicDialog();
      },
    );
  }

  void showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const VideoDialog();
      },
    );
  }

  void showYoutubeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const YoutubeDialog();
      },
    );
  }

  void showLiveStreamDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LiveStreamDialog();
      },
    );
  }

  void showPhotoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const PhotoDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('Update Content'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.custom(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 300,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          shrinkWrap: true,
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return GestureDetector(
                onTap: () {
                  if (index == 0) {
                    showMusicDialog(context);
                  }
                  else if(index == 1){
                    showVideoDialog(context);
                  }
                  else if(index ==2){
                    showYoutubeDialog(context);
                  }
                  else if(index == 3){
                    showLiveStreamDialog(context);
                  }
                  else if(index == 4){
                    showPhotoDialog(context);
                  }
                },
                child: SizedBox(
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          icons[index],
                          height: 52,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            items[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: items.length,
          ),
        ),
      ),
    );
  }
}
