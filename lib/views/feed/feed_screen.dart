import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({Key? key}) : super(key: key);

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late bool isLiked = false;
  late bool isHated = false;

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
      if (isLiked && isHated) {
        // If both like and hate are selected, unselect hate
        isHated = false;
      }
    });
  }

  void toggleHate() {
    setState(() {
      isHated = !isHated;
      if (isHated && isLiked) {
        // If both like and hate are selected, unselect like
        isLiked = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Provider.of<Common>(context, listen: false).drawer(context),
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Feed",
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
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(bottom: 40),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                color: ConstantColors.appBarColor,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            const SizedBox(width: 30),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Dudley Athlete Allen",
                                  style: GoogleFonts.nunito(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  "17 November at 01:00 am",
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
                          height: 200,
                          decoration: BoxDecoration(
                            color: ConstantColors.greyColor,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    toggleLike();
                                  },
                                  icon: Icon(
                                    isLiked
                                        ? FontAwesomeIcons.solidThumbsUp
                                        : FontAwesomeIcons.thumbsUp,
                                    color: isLiked
                                        ? Colors.blue
                                        : ConstantColors.mainlyTextColor,

                                    // FontAwesomeIcons.thumbsUp,
                                    // color: ConstantColors.mainlyTextColor,
                                  ),
                                ),
                                Text(
                                  isLiked ? "Liked" : "Like",
                                  style: GoogleFonts.nunito(
                                    color: isLiked
                                        ? Colors.blue
                                        : ConstantColors.mainlyTextColor,
                                  ),

                                  // style: GoogleFonts.nunito(
                                  //   color: ConstantColors.mainlyTextColor,
                                  // ),
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
                                        ? FontAwesomeIcons.solidThumbsDown
                                        : FontAwesomeIcons.thumbsDown,
                                    color: isHated
                                        ? Colors.red
                                        : ConstantColors.mainlyTextColor,

                                    // FontAwesomeIcons.thumbsDown,
                                    // color: ConstantColors.mainlyTextColor,
                                  ),
                                ),
                                Text(
                                  isHated ? "Hated" : "Hate",
                                  style: GoogleFonts.nunito(
                                    color: isHated
                                        ? Colors.red
                                        : ConstantColors.mainlyTextColor,
                                  ),

                                  // "Hate",
                                  // style: GoogleFonts.nunito(
                                  //   color: ConstantColors.mainlyTextColor,
                                  // ),
                                ),
                              ],
                            )
                          ],
                        )
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
