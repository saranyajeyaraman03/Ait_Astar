// ignore_for_file: deprecated_member_use

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/home/athent_allpost.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
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
        athEntAllPost = await RemoteServices.fetchAthentDetails(userName!);
        allPosts = athEntAllPost!.allPosts;

        setState(() {
          filteredPosts = allPosts;
        });
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void filterPostsByType(int postType) {
    filteredPosts =
        allPosts.where((post) => post.postType == postType).toList();
    print(
        'Filtered Posts Count: ${filteredPosts.length}'); // Add this line to check the filtered count.
    setState(() {});
  }

  // late bool isLiked = false;
  // late bool isHated = false;

  // void toggleLike() {
  //   setState(() {
  //     isLiked = !isLiked;
  //     if (isLiked && isHated) {
  //       isHated = false;
  //     }
  //   });
  // }

  // void toggleHate() {
  //   setState(() {
  //     isHated = !isHated;
  //     if (isHated && isLiked) {
  //       isLiked = false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    String url = "http://18.216.101.141/media/";

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
      // Add more entries as needed
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
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              athEntAllPost!.userProfile.pPicture.isEmpty
                                  ? Image.asset(
                                      'assets/profile.png',
                                      width: 100,
                                    )
                                  : Image.network(
                                      url + athEntAllPost!.userProfile.pPicture,
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
                                        "Fanscribed : ",
                                        style: GoogleFonts.nunito(
                                          fontSize: 16,
                                          color: const Color.fromARGB(
                                              255, 12, 10, 10),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      // Text(
                                      //   "${athEntAllPost!.subscribedCount}",
                                      //   style: GoogleFonts.nunito(
                                      //       fontSize: 18,
                                      //       color: ConstantColors.black),
                                      // ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    " ${athEntAllPost!.userProfile.address}\n${athEntAllPost!.userProfile.city} ${athEntAllPost!.userProfile.zipcode}",
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
                    Text(
                      'View Uploaded Content',
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
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
                              iconSize: 30.0,
                              icon: Image.asset('assets/music_icon.png'),
                              onPressed: () {
                                filterPostsByType(2);
                              },
                            ),
                            const Text('Music'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Image.asset('assets/video_icon.png'),
                              onPressed: () {
                                filterPostsByType(4);
                              },
                            ),
                            const Text('Video'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Image.asset('assets/youtube_icon.png'),
                              onPressed: () {
                                filterPostsByType(3);
                              },
                            ),
                            const Text('YouTube'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Image.asset('assets/camera_icon.png'),
                              onPressed: () {
                                filterPostsByType(10);
                              },
                            ),
                            const Text('Camera'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Image.asset('assets/message_icon.jpg'),
                              onPressed: () {
                                filterPostsByType(1);
                              },
                            ),
                            const Text('Message'),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              iconSize: 30.0,
                              icon: Image.asset('assets/trash_icon.png'),
                              onPressed: () {
                                filterPostsByType(11);
                              },
                            ),
                            const Text('Trash'),
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
                                          if (post.postType ==
                                              4) // Video post type
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
                                                  aspectRatio:
                                                      MediaQuery.of(context)
                                                              .size
                                                              .width /
                                                          200,
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
                                          if (post.postType == 8) // raffle post type
                                            SizedBox(
                                                width: MediaQuery.of(context).size.width,
                                                height: 120,
                                                child: Padding(
                                                    padding:const EdgeInsets.all(15),
                                                    child: Column(
                                                      crossAxisAlignment:CrossAxisAlignment .start,
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
                                          if (post.postType == 7) // event post type
                                            SizedBox(
                                                width: MediaQuery.of(context).size .width,
                                                child: Padding(
                                                    padding: const EdgeInsets.all(15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          'Event Name :${post.name}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color: ConstantColors .black,
                                                          ),
                                                        ),
                                                        Text(
                                                          'Location :${post.description}',
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color: ConstantColors .black,
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

                                                    if (post.postType == 6) // Merchandise  post type
                                            SizedBox(
                                                width: MediaQuery.of(context).size .width,
                                                child: Padding(
                                                    padding: const EdgeInsets.all(15),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          post.description,
                                                          style: GoogleFonts
                                                              .nunito(
                                                            fontSize: 16,
                                                            color: ConstantColors .black,
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
