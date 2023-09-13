import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Common extends ChangeNotifier {
  Widget tile({required Function onPressed, required String icon}) {
    return GestureDetector(
      onTap: () {
        // Handle onTap here
        onPressed();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: Center(
          child: Image.asset(
            icon,
            width: 50,
            height: 50,
          ),
        ),
      ),
    );
  }

  Widget drawer(BuildContext context) {
   Future<Map<String, dynamic>?> getUserData(BuildContext context) async {
  AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
  List<dynamic>? retrievedUserList = await authHelper.getUserData();

  if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
    Map<String, dynamic> userData = retrievedUserList[0];
    String? userType = userData['user_type'];

    // Retrieve user picture and name from SharedPreferences
    String? userPic = await authHelper.loadUserProfilePicture();
    String? username = await authHelper.loadUserName();

    if (kDebugMode) {
      print('user_type: $userType');
      print('p_picture: $userPic');
      print('name: $username');
    }
    return {
      'user_type': userType,
      'p_picture': userPic,
      'name': username,
    };
  }

  return null;
}


    return FutureBuilder<Map<String, dynamic>?>(
      future: getUserData(context),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userType = snapshot.data!['user_type'] ?? '';
          String userPic = snapshot.data!['p_picture'] ?? '';
          String userName = snapshot.data!['name'] ?? '';
          return Drawer(
            backgroundColor: ConstantColors.appBarColor,
            width: MediaQuery.of(context).size.width / 1.3,
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                       

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                                radius: 50,
                                backgroundImage: userPic.isEmpty
                                    ? const AssetImage('assets/profile.png')
                                    : Image.network(
                                        userPic,
                                        fit: BoxFit.fill,
                                      ).image),
                            const SizedBox(height: 10),
                            Text(
                              userName,
                              style: GoogleFonts.nunito(
                                color: ConstantColors.whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  height: MediaQuery.of(context).size.height / 1.4,
                  decoration: const BoxDecoration(
                    color: ConstantColors.whiteColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      tile(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, editProfileRoute);
                          },
                          //title: "Edit Profile",
                          icon: 'assets/edit_profile.png'),
                      userType.toLowerCase() == "fan"
                          ? const SizedBox()
                          : tile(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, uploadContentRoute);
                              },
                              //title: 'Upload Content',
                              icon: 'assets/upload_icon.png'),
                      tile(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context,
                                userType.toLowerCase() == "fan"
                                    ? fanSlideSubscriptionRoute
                                    : athleteSubscriptionRoute);
                          },
                          //title: "Subscription",
                          icon: 'assets/subscription_icon.png'),
                      tile(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(context, privacyPolicyRoute);
                          },
                          // title: "Privacy Policy",
                          icon: 'assets/privacy_icon.png'),
                      tile(
                          onPressed: () {
                            Navigator.pop(context);
                            Navigator.pushNamed(
                                context, termsAndConditionsRoute);
                          },
                          //title: "Terms and Conditions",
                          icon: 'assets/terms_icon.png'),
                      tile(
                          onPressed: () {
                            AuthHelper authHelper =
                                Provider.of<AuthHelper>(context, listen: false);
                            authHelper.setLoggedIn(false);
                            Navigator.pushNamedAndRemoveUntil(
                                context, loginRoute, (route) => false);
                          },
                          //title: "Logout",
                          icon: 'assets/logout_icon.png'),
                    ],
                  ),
                ),
              ],
            ),
          );
        } else {
          // Handle the case where the future completes with null data
          return const Drawer(
              // Your existing drawer code here...
              );
        }
      },
    );
  }
}
