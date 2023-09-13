// ignore_for_file: deprecated_member_use, unnecessary_null_comparison

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/constant_url.dart';
import 'package:aahstar/views/home/athent_allpost.dart';
import 'package:aahstar/views/feed/feed_allpost.dart' as SubscribeUsers;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

//This screen Used for Entertainer and Athlete
class FanScriberAllPostScreen extends StatefulWidget {
  final List<SubscribeUsers.SubscribeUsers> subscribeUsers;

  final String fanScriberName;
  final int index;
  const FanScriberAllPostScreen(
      {Key? key,
      required this.fanScriberName,
      required this.subscribeUsers,
      required this.index})
      : super(key: key);

  @override
  State<FanScriberAllPostScreen> createState() =>
      _FanScriberAllPostScreenState();
}

class _FanScriberAllPostScreenState extends State<FanScriberAllPostScreen> {
  AthEntAllPost? athEntAllPost;
  late List<AllPost> allPosts = [];
  List<AllPost> filteredPosts = [];
  List<VideoPlayerController> videoControllers = [];
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.index;
    fetchData(widget.fanScriberName);
  }

  Future<void> fetchData(String fanScriberName) async {
    try {
      if (widget.fanScriberName != null) {
        athEntAllPost = await RemoteServices.fetchAthentDetails(fanScriberName);
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
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('FanScriber View'),
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
                    Row(
                      children: [
                        for (int index = 0;
                            index < widget.subscribeUsers.length;
                            index++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedIndex = index;
                              });
                              print(
                                  'User clicked: ${widget.subscribeUsers[index].username}');
                              fetchData(widget.subscribeUsers[index].username);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 50,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: selectedIndex == index
                                        ? Colors.red
                                        : ConstantColors.appBarColor,
                                    width: 2.0,
                                  ),
                                ),
                                child: widget.subscribeUsers[index].pPicture
                                        .isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(
                                            ConstantUrl.mediaUrl +
                                                widget.subscribeUsers[index]
                                                    .pPicture),
                                        radius: 30,
                                      )
                                    : Image.asset('assets/profile.png'),
                              ),
                            ),
                          ),
                      ],
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
                            if (selectedIndex != null &&
                                selectedIndex! >= 0 &&
                                selectedIndex! < widget.subscribeUsers.length) {
                              final selectedUser = widget.subscribeUsers[
                                  selectedIndex!]; 
                              fetchData(selectedUser.username);
                            } else {
                              fetchData(widget.fanScriberName);
                            }
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
                              'Camera',
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
