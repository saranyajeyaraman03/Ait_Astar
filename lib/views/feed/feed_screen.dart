// ignore_for_file: unnecessary_null_comparison

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/feed/feed_allpost.dart';
import 'package:chewie/chewie.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  FeedProfileAndPosts? profileAndPosts;
  late List<AllPost> allPosts = [];
  String? userName;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();

      if (userName != null) {
        profileAndPosts = await RemoteServices.feedAllPost(userName!);
        allPosts = profileAndPosts!.allPosts;
        setState(() {});
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  late bool isLiked = false;
  late bool isHated = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked && isHated) {
        isHated = false;
      }
    });
  }

  void toggleHate() {
    setState(() {
      isHated = !isHated;
      if (isHated && isLiked) {
        isLiked = false;
      }
    });
  }

  
  @override
  Widget build(BuildContext context) {
    String url = "http://18.216.101.141/media/";

    Map<int, String> postTypeToCategory = {
      1: 'Message',
      2: 'Music',
      3: 'YouTube Video',
      4: 'Personal Video',
      5: 'YouTube Video',
      6: 'Live Video',
      7: 'Events',
      8: 'Cash App Raffle Prize',
      9: 'Winner',
      10: 'Picture',
      11: 'Trash Talk',
      12: 'Alert'
      // Add more entries as needed
    };

    return Scaffold(
      key: _drawerKey,
      drawer: Provider.of<Common>(context, listen: false).drawer(context),
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('Feed'),
      ),
      body: profileAndPosts == null
          ? const CircularProgressIndicator()
          : SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              profileAndPosts!.userProfile.pPicture.isEmpty
                                  ? Image.asset(
                                      'assets/profile.png',
                                      width: 100,
                                    )
                                  : Image.network(
                                      url +
                                          profileAndPosts!.userProfile.pPicture,
                                      fit: BoxFit.cover,
                                      width: 100,
                                    ),
                              const SizedBox(width: 30),
                              Column(
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
                                        "${profileAndPosts!.subscribedCount}",
                                        style: GoogleFonts.nunito(
                                            fontSize: 18,
                                            color: ConstantColors.black),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ${profileAndPosts!.userProfile.address}\n${profileAndPosts!.userProfile.state} ${profileAndPosts!.userProfile.zipcode}",
                                    maxLines: 2,
                                    style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: ConstantColors.darkBlueColor,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/raffle_icon.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                              const SizedBox(width: 10),
                              GestureDetector(
                                onTap: () {
                                },
                                child: Container(
                                  width: 60,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: Colors.orange,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Image.asset(
                                    'assets/winner_icon.png',
                                    width: 20,
                                    height: 20,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/alert_icon.png',
                                  width: 30,
                                  height: 30,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                width: 60,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Image.asset(
                                  'assets/event_icon.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: allPosts.length,
                      itemBuilder: (context, index) {
                        AllPost post = allPosts[index];
                        String category =
                            postTypeToCategory[post.postType] ?? 'Other';

                        return post.postType == 6
                            ? const SizedBox()
                            : Container(
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
                                                  color: ConstantColors
                                                      .appBarColor,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                    horizontal: 10,
                                                  ),
                                                  child: Text(
                                                    category,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                color: ConstantColors
                                                    .mainlyTextColor,
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
                                          if (post.postType ==
                                              2) // Music post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    url + post.file,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                )),
                                          if (post.postType == 4) // Video post type
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              height: 200,
                                              child: Chewie(
                                                controller: ChewieController(
                                                  videoPlayerController:
                                                      VideoPlayerController
                                                          .network(
                                                    url + post.file,
                                                  
                                                  ),
                                                 aspectRatio: MediaQuery.of(context).size.width / 200, 

                                                  autoPlay: true,
                                                  looping: true,
                                                ),
                                              ),
                                            ),
                                          if (post.postType == 12 ||
                                              post.postType == 11 ||
                                              post.postType ==
                                                  1) // Alert and Trash and Message talk post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 100,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    post.description,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color:
                                                          ConstantColors.black,
                                                    ),
                                                  ),
                                                )),
                                          if (post.postType ==
                                              10) // Picture post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 200,
                                                child: Center(
                                                  child: Image.network(
                                                    url + post.file,
                                                    fit: BoxFit.cover,
                                                  ),
                                                )),
                                          if (post.postType ==
                                              3) // you tube post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(20),
                                                  child: Text(
                                                    post.link,
                                                    style: GoogleFonts.nunito(
                                                      fontSize: 16,
                                                      color: ConstantColors
                                                          .darkBlueColor,
                                                    ),
                                                  ),
                                                )),
                                          if (post.postType ==
                                              8) // raffle post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                height: 120,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Raffle Lucky Draw Event',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Date: ${post.formattedDate}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Time: ${post.formattedTime}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          "Prize Amount:  \$${post.link}",
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                      ],
                                                    ))),
                                          if (post.postType ==
                                              7) // event post type
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            15),
                                                    child: Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          'Event Name :${post.name}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Location :${post.description}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Date: ${post.formattedDate}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Time: ${post.formattedTime}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color:
                                                                ConstantColors
                                                                    .black,
                                                          ),
                                                        ),
                                                        RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                text: "Link : ",
                                                                style:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontSize: 16,
                                                                  color:
                                                                      ConstantColors
                                                                          .black,
                                                                ),
                                                              ),
                                                              TextSpan(
                                                                text: post.link,
                                                                style:
                                                                    GoogleFonts
                                                                        .nunito(
                                                                  fontSize: 16,
                                                                  color: ConstantColors
                                                                      .darkBlueColor,
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ))),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceAround,
                                        children: [
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  toggleLike();
                                                },
                                                icon: Icon(
                                                  isLiked
                                                      ? FontAwesomeIcons
                                                          .solidThumbsUp
                                                      : FontAwesomeIcons
                                                          .thumbsUp,
                                                  color: isLiked
                                                      ? Colors.blue
                                                      : ConstantColors
                                                          .mainlyTextColor,
                                                ),
                                              ),
                                              Text(
                                                isLiked ? "Liked" : "Like",
                                                style: GoogleFonts.nunito(
                                                  color: isLiked
                                                      ? Colors.blue
                                                      : ConstantColors
                                                          .mainlyTextColor,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  toggleHate();
                                                },
                                                icon: Icon(
                                                  isHated
                                                      ? FontAwesomeIcons
                                                          .solidThumbsDown
                                                      : FontAwesomeIcons
                                                          .thumbsDown,
                                                  color: isHated
                                                      ? Colors.red
                                                      : ConstantColors
                                                          .mainlyTextColor,
                                                ),
                                              ),
                                              Text(
                                                isHated ? "Hated" : "Hate",
                                                style: GoogleFonts.nunito(
                                                  color: isHated
                                                      ? Colors.red
                                                      : ConstantColors
                                                          .mainlyTextColor,
                                                ),
                                              ),
                                            ],
                                          )
                                        ])
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
