// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/constant_url.dart';
import 'package:aahstar/views/aahstar_live/livehome_screen.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/home/athent_allpost.dart';
import 'package:camera/camera.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

//This screen Used for Entertainer and Athlete
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AthEntAllPost? athEntAllPost;
  late List<AllPost> allPosts = [];
  List<AllPost> filteredPosts = [];
  List<VideoPlayerController> videoControllers = [];

  String? userName;
  late String userType = "";

  @override
  void initState() {
    super.initState();
    getUserType();
    fetchData();
  }

  Future<void> getUserType() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    List<dynamic>? retrievedUserList = await authHelper.getUserData();
    if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
      Map<String, dynamic> userData = retrievedUserList[0];
      userType = userData['user_type'] ?? '';
      print('user_type: $userType');
    }
  }

  Future<void> fetchData() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();

      if (userName != null) {
        athEntAllPost = await RemoteServices.fetchAthentDetails(userName!);
        allPosts = athEntAllPost!.allPosts;

        setState(() {
          filteredPosts = allPosts;
        });
      }
      authHelper.saveUserProfile(
          athEntAllPost!.userProfile.pPicture.isEmpty
              ? ""
              : ConstantUrl.mediaUrl + athEntAllPost!.userProfile.pPicture,
          userName!);
    } catch (error) {
      print('Error: $error');
    }
  }

  void filterPostsByType(int postType) {
    filteredPosts =
        allPosts.where((post) => post.postType == postType).toList();
    print('Filtered Posts Count: ${filteredPosts.length}');
    setState(() {});
  }

  void _launchURL(String webURL) async {
    print(webURL);
    String encodedURL = Uri.encodeFull(webURL);
    if (await canLaunch(encodedURL)) {
      await launch(encodedURL);
    } else {
      throw 'Could not launch $encodedURL';
    }
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Map<int, String> postTypeToCategory = {
      1: 'Message',
      2: 'Music',
      3: 'YouTube Video',
      4: 'Personal Video',
      5: 'YouTube Video',
      6: 'Merchandise',
      7: 'Events',
      8: 'Cash App Raffle Prize',
      9: 'Live Video',
      10: 'Picture',
      11: 'Trash Talk',
      12: 'Alert'
    };
    return Scaffold(
      key: _drawerKey,
      drawer: Provider.of<Common>(context, listen: false).drawer(context),
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Home Screen",
          style: GoogleFonts.nunito(
            color: ConstantColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.bars,
            color: ConstantColors.whiteColor,
          ),
          onPressed: () {
            _drawerKey.currentState?.openDrawer();
          },
        ),
      ),
      body: athEntAllPost == null
          ? const SizedBox()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ConstantColors.appBarColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Stack(
                                children: [
                                  Image.asset(
                                    userType.toString().toLowerCase() ==
                                            "entertainer"
                                        ? 'assets/aahstar_entertainer.png'
                                        : 'assets/aahstar_athlete.png',
                                    fit: BoxFit.cover,
                                    width: 150,
                                  ),
                                  Positioned(
                                    top: 65,
                                    left: 50,
                                    child: athEntAllPost!
                                            .userProfile.pPicture.isEmpty
                                        ? ClipOval(
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              child: Image.asset(
                                                'assets/profile.png',
                                                width: 50,
                                              ),
                                            ),
                                          )
                                        : ClipOval(
                                            child: Image.network(
                                              ConstantUrl.mediaUrl +
                                                  athEntAllPost!
                                                      .userProfile.pPicture,
                                              fit: BoxFit.cover,
                                              width: 50,
                                              height: 50,
                                            ),
                                          ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      userName!,
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Fanscribers : ",
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: const Color.fromARGB(
                                                255, 12, 10, 10),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "${athEntAllPost!.userProfile.followers}",
                                          style: GoogleFonts.nunito(
                                              fontSize: 18,
                                              color: ConstantColors.black),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      "${athEntAllPost!.userProfile.address}\n${athEntAllPost!.userProfile.city} ${athEntAllPost!.userProfile.zipcode}",
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: ConstantColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  filterPostsByType(8);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: ConstantColors.darkBlueColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/raffle_icon.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  //filterPostsByType(8);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/winner_icon.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  filterPostsByType(12);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/alert_icon.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                  filterPostsByType(7);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.blue,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/event_icon.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () async {
                                  //filterPostsByType(6);
                                  WidgetsFlutterBinding.ensureInitialized();
                                  final cameras = await availableCameras();
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation,
                                              secondaryAnimation) =>
                                          CameraApp(
                                        cameras: cameras,
                                      ),
                                      //LiveScreen(),
                                      transitionsBuilder: (context, animation,
                                          secondaryAnimation, child) {
                                        const begin = Offset(1.0, 0.0);
                                        const end = Offset.zero;
                                        const curve = Curves.easeInOut;
                                        var tween = Tween(
                                                begin: begin, end: end)
                                            .chain(CurveTween(curve: curve));
                                        var offsetAnimation =
                                            animation.drive(tween);
                                        return SlideTransition(
                                            position: offsetAnimation,
                                            child: child);
                                      },
                                    ),
                                  );
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/live_streamed_icon.png',
                                    width: 15,
                                    height: 15,
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Colors.green),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, uploadContentRoute);
                      },
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.settings, size: 25, color: Colors.white),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Uploaded Exclusive Content',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text(
                          'View Uploaded Content',
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 20),
                        TextButton(
                          onPressed: () {
                            fetchData();
                          },
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: Text(
                            'All',
                            style: GoogleFonts.nunito(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/music_icon.png'),
                              onPressed: () {
                                filterPostsByType(2);
                              },
                            ),
                            const Text(
                              'Music',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/video_icon.png'),
                              onPressed: () {
                                filterPostsByType(4);
                              },
                            ),
                            const Text(
                              'Video',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/youtube_icon.png'),
                              onPressed: () {
                                filterPostsByType(3);
                              },
                            ),
                            const Text(
                              'YouTube',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/camera_icon.png'),
                              onPressed: () {
                                filterPostsByType(10);
                              },
                            ),
                            const Text(
                              'Photo',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/message_icon.jpg'),
                              onPressed: () {
                                filterPostsByType(1);
                              },
                            ),
                            const Text(
                              'Message',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 25,
                              icon: Image.asset('assets/trash_icon.png'),
                              onPressed: () {
                                filterPostsByType(11);
                              },
                            ),
                            const Text(
                              'Trash',
                              style: TextStyle(fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: filteredPosts.length,
                      itemBuilder: (context, index) {
                        AllPost post = filteredPosts[index];

                        String category =
                            postTypeToCategory[post.postType] ?? 'Other';

                        ChewieController? chewieController;
                        if (post.postType == 4) {
                          VideoPlayerController videoController =
                              VideoPlayerController.network(
                            ConstantUrl.mediaUrl + post.file,
                          );
                          videoControllers.add(videoController);
                          chewieController = ChewieController(
                            videoPlayerController: videoController,
                            aspectRatio:
                                MediaQuery.of(context).size.width / 200,
                            autoPlay: true,
                            looping: true,
                          );
                        }

                        return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(bottom: 40),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Category : ",
                                            style: GoogleFonts.nunito(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Container(
                                            color: ConstantColors.appBarColor,
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 10,
                                            ),
                                            child: Text(
                                              category,
                                              style: GoogleFonts.nunito(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        DateFormat("d MMMM 'at' hh:mm a")
                                            .format(post.createdAt),
                                        style: GoogleFonts.nunito(
                                          color: ConstantColors.mainlyTextColor,
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Container(
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: ConstantColors.greyColor,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    if (post.postType == 2) // Music post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text(
                                              ConstantUrl.mediaUrl + post.file,
                                              style: GoogleFonts.nunito(
                                                fontSize: 16,
                                                color: ConstantColors.black,
                                              ),
                                            ),
                                          )),
                                    if (post.postType == 4 &&
                                        chewieController != null)
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Chewie(
                                            controller: chewieController),
                                      ),
                                    if (post.postType == 12 ||
                                        post.postType == 11 ||
                                        post.postType ==
                                            1) // Alert and Trash and Message talk post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 100,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: Text(
                                              post.description,
                                              style: GoogleFonts.nunito(
                                                fontSize: 16,
                                                color: ConstantColors.black,
                                              ),
                                            ),
                                          )),
                                    if (post.postType ==
                                        10) // Picture post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 200,
                                          child: Center(
                                            child: Image.network(
                                              ConstantUrl.mediaUrl + post.file,
                                              fit: BoxFit.cover,
                                            ),
                                          )),
                                    if (post.postType ==
                                        3) // you tube post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                            padding: const EdgeInsets.all(20),
                                            child: GestureDetector(
                                              onTap: () {
                                                _launchURL(post.link);
                                              },
                                              child: Text(
                                                post.link,
                                                style: GoogleFonts.nunito(
                                                  fontSize: 16,
                                                  color: ConstantColors
                                                      .darkBlueColor,
                                                ),
                                              ),
                                            ),
                                          )),
                                    if (post.postType == 8) // raffle post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          height: 120,
                                          child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Raffle Lucky Draw Event',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Date: ${post.formattedDate}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Time: ${post.formattedTime}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    "Prize Amount:  \$${post.link}",
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                    if (post.postType == 7) // event post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Event Name :${post.name}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Location :${post.description}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Date: ${post.formattedDate}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  Text(
                                                    'Time: ${post.formattedTime}',
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _launchURL(post.link);
                                                    },
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "Link : ",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 16,
                                                              color:
                                                                  ConstantColors
                                                                      .black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: post.link,
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 16,
                                                              color: ConstantColors
                                                                  .darkBlueColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                    if (post.postType ==
                                        6) // Merchandise  post type
                                      SizedBox(
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    post.description,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      _launchURL(post.link);
                                                    },
                                                    child: RichText(
                                                      text: TextSpan(
                                                        children: [
                                                          TextSpan(
                                                            text: "Link : ",
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 16,
                                                              color:
                                                                  ConstantColors
                                                                      .black,
                                                            ),
                                                          ),
                                                          TextSpan(
                                                            text: post.link,
                                                            style: GoogleFonts
                                                                .nunito(
                                                              fontSize: 16,
                                                              color: ConstantColors
                                                                  .darkBlueColor,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
                              // Row(
                              //     mainAxisAlignment:
                              //         MainAxisAlignment.spaceAround,
                              //     children: [
                              //       Row(
                              //         children: [
                              //           IconButton(
                              //             onPressed: () {
                              //               toggleLike();
                              //             },
                              //             icon: Icon(
                              //               isLiked
                              //                   ? FontAwesomeIcons
                              //                       .solidThumbsUp
                              //                   : FontAwesomeIcons
                              //                       .thumbsUp,
                              //               color: isLiked
                              //                   ? Colors.blue
                              //                   : ConstantColors
                              //                       .mainlyTextColor,
                              //             ),
                              //           ),
                              //           Text(
                              //             isLiked ? "Liked" : "Like",
                              //             style: GoogleFonts.nunito(
                              //               color: isLiked
                              //                   ? Colors.blue
                              //                   : ConstantColors
                              //                       .mainlyTextColor,
                              //             ),
                              //           ),
                              //         ],
                              //       ),
                              //       Row(
                              //         children: [
                              //           IconButton(
                              //             onPressed: () {
                              //               toggleHate();
                              //             },
                              //             icon: Icon(
                              //               isHated
                              //                   ? FontAwesomeIcons
                              //                       .solidThumbsDown
                              //                   : FontAwesomeIcons
                              //                       .thumbsDown,
                              //               color: isHated
                              //                   ? Colors.red
                              //                   : ConstantColors
                              //                       .mainlyTextColor,
                              //             ),
                              //           ),
                              //           Text(
                              //             isHated ? "Hated" : "Hate",
                              //             style: GoogleFonts.nunito(
                              //               color: isHated
                              //                   ? Colors.red
                              //                   : ConstantColors
                              //                       .mainlyTextColor,
                              //             ),
                              //           ),
                              //         ],
                              //       )

                              //     ])
                            ],
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
    );
  }
}
