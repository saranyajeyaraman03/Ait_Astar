// ignore_for_file: unnecessary_null_comparison, deprecated_member_use, use_build_context_synchronously

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/constant_url.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/feed/admin_userdata.dart';
import 'package:aahstar/views/feed/cash_winner.dart';
import 'package:aahstar/views/feed/music_player.dart';
import 'package:aahstar/views/feed/video_slider.dart';
import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FanViewScreen extends StatefulWidget {
  const FanViewScreen({Key? key}) : super(key: key);

  @override
  @override
  State<FanViewScreen> createState() => _FanViewScreenState();
}

class PostStatus {
  bool isLiked;
  bool isHated;

  PostStatus({this.isLiked = false, this.isHated = false});
}

class _FanViewScreenState extends State<FanViewScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  AdminUserData? adminUserData;
  late List<AdminPost> allPosts = [];

  String? userName;
  Map<int, PostStatus> postStatusMap = {};

  List<AdminPost> filteredPosts = [];
  List<Scraper> scraperLink = [];
  List<String> scraperVideoLinks = [];
  List<VideoPlayerController> videoControllers = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    for (var controller in videoControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();
      authHelper.setSubcriptionCount('0');
      if (userName != null) {
        adminUserData = await RemoteServices.fanAllPost(userName!);
        allPosts = adminUserData!.adminAllContents;
        if (adminUserData != null &&
            adminUserData!.scraper != null &&
            adminUserData!.scraper.isNotEmpty) {
          scraperLink = adminUserData!.scraper;
          scraperVideoLinks =
              scraperLink.map((scraper) => scraper.link).toList();
        }

        setState(() {
          for (int i = 0; i < allPosts.length; i++) {
            postStatusMap[i] = PostStatus();
          }
          filteredPosts = allPosts;
        });
        AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
        authHelper.saveUserProfile(
            adminUserData!.profileOfUser.first.pPicture.isEmpty
                ? ""
                : ConstantUrl.mediaUrl +
                    adminUserData!.profileOfUser.first.pPicture,
            userName!);
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void filterPostsByType(int postType) {
    filteredPosts =
        allPosts.where((post) => post.postType == postType).toList();
    setState(() {});
  }

  Future<void> toggleLike(int index, String postId) async {
    setState(() {
      postStatusMap[index]!.isLiked = !postStatusMap[index]!.isLiked;
      if (postStatusMap[index]!.isLiked) {
        postStatusMap[index]!.isHated = false;
      }
    });

    Response response = await RemoteServices.like(userName!, postId);
    print(response.body);
    if (response.statusCode == 200) {
      print('Love Added Successfully');
    } else {
      print('API call failed with status code ${response.statusCode}');
    }
  }

  Future<void> toggleHate(int index, String postId) async {
    setState(() {
      postStatusMap[index]!.isHated = !postStatusMap[index]!.isHated;
      if (postStatusMap[index]!.isHated) {
        postStatusMap[index]!.isLiked = false;
      }
    });
    Response response = await RemoteServices.hate(userName!, postId);
    print(response.body);
    if (response.statusCode == 200) {
      print('Hate Added Successfully');
    } else {
      print('API call failed with status code ${response.statusCode}');
    }
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

  void showWinnerDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const CashWinnerDialog();
      },
    );
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
        title: const Text('FanView'),
      ),
      body: adminUserData == null
          ? const SizedBox()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
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
                                  // Background Image
                                  Image.asset(
                                    'assets/aahstar_fan.png',
                                    fit: BoxFit.cover,
                                    width: 150,
                                  ),
                                  Positioned(
                                    top: 65,
                                    left: 50,
                                    child: adminUserData!.profileOfUser.first
                                            .pPicture.isEmpty
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
                                                  adminUserData!.profileOfUser
                                                      .first.pPicture,
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
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Fanscribed to : ",
                                          style: GoogleFonts.nunito(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Text(
                                          "0",
                                          style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: ConstantColors.black,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      " ${adminUserData!.profileOfUser.first.address}\n${adminUserData!.profileOfUser.first.city} ${adminUserData!.profileOfUser.first.zipcode}",
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.nunito(
                                        fontSize: 16,
                                        color: ConstantColors.black,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const SizedBox(
                            height: 10,
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
                                  showWinnerDialog(context);
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
                                onTap: () {
                                  filterPostsByType(6);
                                },
                                child: Container(
                                  width: 40,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Colors.deepOrange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/merchandise_icon.png',
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
                    Text(
                      'Aah Star News',
                      style: GoogleFonts.nunito(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    scraperVideoLinks.isNotEmpty
                        ? SizedBox(
                            height: 200,
                            child: VideoWebViewScreen(
                              videoUrls: scraperVideoLinks,
                            ),
                          )
                        : const SizedBox(),
                    Row(
                      children: [
                        Text(
                          'View Uploaded Content:',
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
                        AdminPost post = filteredPosts[index];
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
                                      Text(
                                        DateFormat("MMMM d yyyy 'at' hh:mm a")
                                            .format(post.createdAt),
                                      ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: MusicPlayerWidget(musicUrl: ConstantUrl.mediaUrl + post.file),
                                      ),
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
                                    if (post.postType == 3) // youtube post type
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
                                                  )
                                                ],
                                              ))),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 10),
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
