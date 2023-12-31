// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/aahstar_live/livehome_screen.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/home/entertainer_dashboard.dart';
import 'package:aahstar/widgets/alert_dialog.dart';
import 'package:aahstar/widgets/custom_router.dart';
import 'package:aahstar/widgets/event_dialog.dart';
import 'package:aahstar/widgets/merchandise_dialog.dart';
import 'package:aahstar/widgets/message_dialog.dart';
import 'package:aahstar/widgets/music_dialog.dart';
import 'package:aahstar/widgets/photo_dialog.dart';
import 'package:aahstar/widgets/raffle_dialog.dart';
import 'package:aahstar/widgets/trash_dialog.dart';
import 'package:aahstar/widgets/video_dialog.dart';
import 'package:aahstar/widgets/youtube_dialog.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UploadContentScreen extends StatefulWidget {
  const UploadContentScreen({Key? key}) : super(key: key);

  @override
  State<UploadContentScreen> createState() => _UploadContentScreenState();
}

class _UploadContentScreenState extends State<UploadContentScreen> {
  List<String> items = [
    'Music',
    'Personal Video',
    'Youtube Video',
    "Aah Star Live",
    'Photo',
    'Message',
    'Alert',
    'Merchandise Website Link',
    'Trash Talk',
    "Event",
    "Raffle Drawing",
  ];

  List<String> icons = [
    'assets/music_icon.png',
    'assets/video_icon.png',
    'assets/youtube_icon.png',
    "assets/video_stream_icon.png",
    'assets/camera_icon.png',
    'assets/message_icon.jpg',
    'assets/alert_icon.png',
    'assets/merchandise_icon.png',
    'assets/trash_icon.png',
    "assets/event_icon.png",
    'assets/raffle_icon.png',
  ];

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
  }

  void showMusicDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MusicDialog(
          userName: userName,
        );
      },
    );
  }

  void showVideoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return VideoDialog(
          userName: userName,
        );
      },
    );
  }

  void showYoutubeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return YoutubeDialog(
          userName: userName,
        );
      },
    );
  }

  // void showLiveStreamDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return const LiveStreamDialog();
  //     },
  //   );
  // }

  void showPhotoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return PhotoDialog(
          userName: userName,
        );
      },
    );
  }

  void showMessageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MessageDialog(
          userName: userName,
        );
      },
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialogScreen(
          userName: userName,
        );
      },
    );
  }

  void showMerchandiseDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return MerchandiseDialog(
          userName: userName,
        );
      },
    );
  }

  void showTrashDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return TrashDialog(
          userName: userName,
        );
      },
    );
  }

  void showEventDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EventDialog(
          userName: userName,
        );
      },
    );
  }

  void showRaffleDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return RaffleDialog(
          userName: userName,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('Upload Content'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              CustomPageRoute(
                builder: (context) =>
                    const EntertainerDashboardScreen(selectIndex: 0),
              ),
              (route) => false,
            );
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: GridView.custom(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          shrinkWrap: true,
          childrenDelegate: SliverChildBuilderDelegate(
            (BuildContext ctx, int index) {
              return GestureDetector(
                onTap: () async {
                  if (index == 0) {
                    showMusicDialog(context);
                  } else if (index == 1) {
                    showVideoDialog(context);
                  } else if (index == 2) {
                    showYoutubeDialog(context);
                  } else if (index == 3) {
                   // Navigator.pushNamed(context, liveRoute);

                    WidgetsFlutterBinding.ensureInitialized();
                    final cameras = await availableCameras();
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            CameraApp( cameras: cameras,),
                           //LiveScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          const begin = Offset(1.0, 0.0);
                          const end = Offset.zero;
                          const curve = Curves.easeInOut;
                          var tween = Tween(begin: begin, end: end)
                              .chain(CurveTween(curve: curve));
                          var offsetAnimation = animation.drive(tween);
                          return SlideTransition(
                              position: offsetAnimation, child: child);
                        },
                      ),
                    );
                  } else if (index == 4) {
                    showPhotoDialog(context);
                  } else if (index == 5) {
                    showMessageDialog(context);
                  } else if (index == 6) {
                    showAlertDialog(context);
                  } else if (index == 7) {
                    showMerchandiseDialog(context);
                  } else if (index == 8) {
                    showTrashDialog(context);
                  } else if (index == 9) {
                    showEventDialog(context);
                  } else if (index == 10) {
                    showRaffleDialog(context);
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
                          height: 40,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(
                            items[index],
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black,
                              fontSize: 14,
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
