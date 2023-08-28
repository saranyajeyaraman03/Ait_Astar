import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Common extends ChangeNotifier {
  Widget tile({required Function onPressed, required String title}) {
    return ListTile(
      title: Text(
        title,
        style: GoogleFonts.nunito(
          fontWeight: FontWeight.w500,
          fontSize: 15,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 15,
      ),
      onTap: () => onPressed(),
    );
  }

  Widget drawer(BuildContext context) {
    Future<String?> getUserType() async {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      List<dynamic>? retrievedUserList = await authHelper.getUserData();

      if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
        Map<String, dynamic> userData = retrievedUserList[0];
        String? userType = userData['user_type'];
        if (kDebugMode) {
          print('user_type: $userType');
        }
        return userType;
      }

      return null;
    }

    return FutureBuilder<String?>(
      future: getUserType(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userType = snapshot.data!;

          return Drawer(
            backgroundColor: ConstantColors.appBarColor,
            width: MediaQuery.of(context).size.width/1.3,
            child: ListView(
              children: [
                DrawerHeader(
                  margin: EdgeInsets.zero,
                  padding: EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: ConstantColors.whiteColor,
                            size: 35,
                          ),
                        ),
                        const SizedBox(height: 50),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Hey There !",
                              style: GoogleFonts.nunito(
                                color: ConstantColors.whiteColor,
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                          ],
                        ),
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
                        title: "Edit Profile",
                      ),
                      userType.toLowerCase() == "fan"
                          ? const SizedBox()
                          : tile(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pushNamed(
                                    context, uploadContentRoute);
                              },
                              title: 'Upload Content',
                            ),
                      tile(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, subscriptionRoute);
                        },
                        title: "Subscription",
                      ),
                      tile(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, privacyPolicyRoute);
                        },
                        title: "Privacy Policy",
                      ),
                      tile(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pushNamed(context, termsAndConditionsRoute);
                        },
                        title: "Terms and Conditions",
                      ),
                      tile(
                        onPressed: () {
                          AuthHelper authHelper =
                              Provider.of<AuthHelper>(context, listen: false);
                          authHelper.setLoggedIn(false);
                          Navigator.pushNamedAndRemoveUntil(
                              context, loginRoute, (route) => false);
                        },
                        title: "Logout",
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }else {
        // Handle the case where the future completes with null data
        return Drawer(
          // Your existing drawer code here...
        );
      }

      },
    );
  }
}
