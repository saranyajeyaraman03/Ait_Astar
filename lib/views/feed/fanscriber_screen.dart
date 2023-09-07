// ignore_for_file: deprecated_member_use

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/home/athent_allpost.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:video_player/video_player.dart';

//This screen Used for Entertainer and Athlete
class FanScriberScreen extends StatefulWidget {
  final String fanScriberName;
  const FanScriberScreen({Key? key, required this.fanScriberName}) : super(key: key);

  @override
  State<FanScriberScreen> createState() => _FanScriberScreenState();
}

class _FanScriberScreenState extends State<FanScriberScreen> {

  AthEntAllPost? athEntAllPost;
  late List<AllPost> allPosts = [];
  List<AllPost> filteredPosts = [];
  List<VideoPlayerController> videoControllers = [];
  String url = "http://18.216.101.141/media/";


  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {

      if (widget.fanScriberName != null) {
        athEntAllPost = await RemoteServices.fetchAthentDetails(widget.fanScriberName);
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
        title: const Text('Fan Scriber View'),
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
                              athEntAllPost!.userProfile.pPicture.isEmpty
                                  ? Image.asset(
                                      'assets/profile.png',
                                      width: 100,
                                    )
                                  : Image.network(
                                      url + athEntAllPost!.userProfile.pPicture,
                                      fit: BoxFit.cover,
                                      width: 80,
                                    ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.fanScriberName,
                                      style: GoogleFonts.nunito(
                                        fontSize: 18,
                                        color: ConstantColors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
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
                                      maxLines: 2,
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
                              // GestureDetector(
                              //   onTap: () {
                              //     //filterPostsByType(8);
                              //   },
                              //   child: Container(
                              //     width: 40,
                              //     height: 30,
                              //     decoration: BoxDecoration(
                              //       color: Colors.orange,
                              //       borderRadius: BorderRadius.circular(8),
                              //     ),
                              //     child: Image.asset(
                              //       'assets/winner_icon.png',
                              //       width: 15,
                              //       height: 15,
                              //     ),
                              //   ),
                              // ),
                              // const SizedBox(width: 10),
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
                            url + post.file,
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
                                              url + post.file,
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
                                              url + post.file,
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
