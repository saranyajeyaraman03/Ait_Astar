// ignore_for_file: unnecessary_null_comparison

import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/constant_url.dart';
import 'package:aahstar/views/fan_scriber/fanscriber_allPost_screen.dart';
import 'package:aahstar/views/feed/feed_allpost.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FanScriberListScreen extends StatefulWidget {
  final List<SubscribeUsers> subscribeUsers;

  const FanScriberListScreen({
    Key? key,
    required this.subscribeUsers,
  }) : super(key: key);

  @override
  State<FanScriberListScreen> createState() => _FanScriberListScreenState();
}

class _FanScriberListScreenState extends State<FanScriberListScreen> {
  late List<SubscribeUsers> subscribeUsers = [];

  @override
  void initState() {
    super.initState();
    subscribeUsers = widget.subscribeUsers;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('FanScriber'),
      ),
      body: subscribeUsers == null
          ? const SizedBox()
          : SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Column(
                children: [
                  for (int index = 0; index < subscribeUsers.length; index++)
                    Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FanScriberAllPostScreen(
                                    fanScriberName: subscribeUsers[index].username,
                                    subscribeUsers: subscribeUsers,
                                    index: index,
                                  );
                                },
                              ),
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: ConstantColors.appBarColor,
                                width: 2.0,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: const EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    subscribeUsers[index].pPicture.isEmpty
                                        ? Image.asset(
                                            'assets/profile.png',
                                            width: 100,
                                          )
                                        : Image.network(
                                            ConstantUrl.mediaUrl +
                                                subscribeUsers[index].pPicture,
                                            fit: BoxFit.cover,
                                            width: 80,
                                          ),
                                    const SizedBox(width: 10),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            subscribeUsers[index].username,
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
                                              const Text(
                                                "Fanscribers : ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Color.fromARGB(
                                                      255, 12, 10, 10),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              Text(
                                                "${subscribeUsers[index].followers}",
                                                style: GoogleFonts.nunito(
                                                  fontSize: 18,
                                                  color: ConstantColors.black,
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            "${subscribeUsers[index].address}\n${subscribeUsers[index].city} ${subscribeUsers[index].zipcode}",
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
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                ],
              ),
            ),
    );
  }
}
