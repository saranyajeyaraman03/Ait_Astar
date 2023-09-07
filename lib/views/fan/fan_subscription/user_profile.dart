import 'package:aahstar/values/constant_colors.dart';
import 'package:chewie/chewie.dart';
import 'package:video_player/video_player.dart';
import 'package:aahstar/views/search/profile_post.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class UserProfileScreen extends StatefulWidget {
  final ProfileAndPosts profileAndPosts;

  const UserProfileScreen({Key? key, required this.profileAndPosts})
      : super(key: key);

  @override
  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  @override
  Widget build(BuildContext context) {
    UserProfile userProfile = widget.profileAndPosts.userProfile;
    List<AllPost> allPosts = widget.profileAndPosts.allPosts;
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
    };

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('View Profile'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
                child: Row(
                  children: [
                    userProfile.pPicture.isEmpty
                        ? Image.asset(
                            'assets/profile.png',
                            width: 100,
                          )
                        : Image.network(
                            url + userProfile.pPicture,
                            fit: BoxFit.cover,
                            width: 100,
                          ),
                    const SizedBox(width: 30),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          userProfile.name,
                          style: GoogleFonts.nunito(
                            fontSize: 18,
                            color: ConstantColors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Followers : ${userProfile.followers}",
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: ConstantColors.black,
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          "Address: ${userProfile.address}\n${userProfile.state} ${userProfile.zipcode}",
                          maxLines: 2,
                          style: GoogleFonts.nunito(
                            fontSize: 16,
                            color: ConstantColors.black,
                          ),
                        )
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
                                    if (post.postType == 4) // Video post type
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        child: Chewie(
                                          controller: ChewieController(
                                            videoPlayerController:
                                                VideoPlayerController.network(
                                              url + post.file,
                                            ),
                                            autoPlay: false,
                                            looping: false,
                                          ),
                                        ),
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
                                                  RichText(
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
