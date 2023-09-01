// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/fan/fan_subscription/fan_subscription.dart';
import 'package:aahstar/views/fan/fan_subscription/user_profile.dart';
import 'package:aahstar/views/search/profile_post.dart';
import 'package:aahstar/views/search/user_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late Future<List<AthleteUserModel>> futureUsers;
  final TextEditingController _searchController = TextEditingController();

  String searchQuery = '';

  List<AthleteUserModel> allUsers = []; // Store all users initially
  List<AthleteUserModel> displayedUsers = []; // Store users based on search

  String? userName;

  @override
  void initState() {
    super.initState();
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    authHelper.getUserName().then((String? retrievedUserName) {
      if (retrievedUserName != null) {
        setState(() {
          userName = retrievedUserName;
        });
      }
    });
    futureUsers = RemoteServices.fetchAthleteUsers();
    futureUsers.then((users) {
      setState(() {
        allUsers = users;
        displayedUsers = users;
      });
    });
  }

  void searchUsers(String query) {
    setState(() {
      displayedUsers = allUsers
          .where((user) =>
              user.username.toLowerCase().contains(query.toLowerCase()))
          .toList();
      print(displayedUsers.length);

      if (displayedUsers.isEmpty) {
        displayedUsers = [];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height / 1.7;
    double aspectRatio = deviceWidth / deviceHeight;

    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: PreferredSize(
          preferredSize: const Size.fromHeight(180),
          child: Stack(
            children: <Widget>[
              Container(
                // Background
                color: ConstantColors.appBarColor,
                height: MediaQuery.of(context).size.height * 0.2,
                width: MediaQuery.of(context).size.width,
                child: const Center(
                  child: Text(
                    "Search",
                    style: TextStyle(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                ),
              ),
              Container(),
              Positioned(
                top: 100.0,
                left: 20.0,
                right: 20.0,
                child: AppBar(
                  backgroundColor: Colors.white,
                  primary: false,
                  title: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        print(value);
                        searchUsers(value);
                      },
                      decoration: const InputDecoration(
                          hintText: "Search Athletes & Entertainer ",
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.grey))),
                  actions: <Widget>[
                    IconButton(
                      icon: const Icon(Icons.search,
                          color: ConstantColors.appBarColor),
                      onPressed: () {},
                    ),
                  ],
                ),
              )
            ],
          )),
      body: FutureBuilder<List<AthleteUserModel>>(
        future: futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No data available.',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            );
          } else {
            if (displayedUsers.isEmpty) {
              return const Center(
                child: Text(
                  'No matching users found.',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              );
            }

            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              padding: const EdgeInsets.all(10.0),
              itemCount: displayedUsers.length,
              itemBuilder: (context, index) {
                var user = displayedUsers[index];
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                  ),
                  child: GridTile(
                    footer: Padding(
                      padding: const EdgeInsets.only(
                          left: 30, right: 30, top: 10, bottom: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ConstantColors.darkBlueColor,
                        ),
                        onPressed: () async {
                          ProfileAndPosts profileAndPosts =
                              await RemoteServices.fetchViewProfile(
                                  user.username, userName!);
                          bool isSubscribed = profileAndPosts.isSubscribed;
                          print(isSubscribed);
                          if (isSubscribed) {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        UserProfileScreen(
                                            profileAndPosts: profileAndPosts),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          } else {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        FanSubscriptionScreen(
                                            subname: user.username,
                                            type: user.userType),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(1.0, 0.0);
                                  const end = Offset.zero;
                                  const curve = Curves.easeInOut;
                                  var tween = Tween(begin: begin, end: end)
                                      .chain(CurveTween(curve: curve));
                                  var offsetAnimation = animation.drive(tween);
                                  return SlideTransition(
                                      position: offsetAnimation, child: child);
                                },
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'View',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      ),
                    ),
                    child: SizedBox(
                      child: Column(
                        children: [
                          Image.asset(
                            Path.pngLogo,
                            width: 100,
                            height: 80,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            user.username,
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          Text(
                            user.userType,
                            style: const TextStyle(
                                color: Colors.black, fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
