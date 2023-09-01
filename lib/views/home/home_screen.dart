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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
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

              const SizedBox(height: 20,),

               Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          children: [
            IconButton(
              iconSize: 30.0,
              icon: Image.asset('assets/music_icon.png'),
              onPressed: () {
                
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
                 
              // SizedBox(
              //   child: GridView.builder(
              //     physics: const NeverScrollableScrollPhysics(),
              //     shrinkWrap: true,
              //     gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              //       crossAxisCount: 2,
              //       crossAxisSpacing: 10.0,
              //       mainAxisSpacing: 10.0,
              //       childAspectRatio: 22 / 35,
              //     ),
              //     itemCount: 2,
              //     itemBuilder: (context, index) {
              //       return CategoryViewCard(
              //         categoryName: "music",
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryViewCard extends StatelessWidget {
  final String categoryName;

  const CategoryViewCard({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    '15 hours ago',
                    style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Category :',
                    style: TextStyle(
                      fontSize: 10,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        backgroundColor: ConstantColors.appBarColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'If you are a Aah Star Customers with an account on this platform',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                width: 100,
                height: 30,
                child: ElevatedButton(
                  onPressed: () => {
                    // QuickAlert.show(
                    //   context: context,
                    //   type: QuickAlertType.confirm,
                    //   onCancelBtnTap: () {},
                    //   onConfirmBtnTap: () {},
                    //   text: 'Do you want to delete this item',
                    //   confirmBtnText: 'Yes',
                    //   cancelBtnText: 'No',
                    //   confirmBtnColor: ConstantColors.appBarColor,
                    // ),
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                  child: const Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(size: 14.0, color: Colors.white),
                        child: Icon(Icons.delete),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'Delete',
                        style: TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
