import 'dart:convert';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/profile/profile_helper.dart';
import 'package:aahstar/views/profile/user_profile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserProfile? userProfile;
  late String imageUrl = "";

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  Future<void> _initializeData() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    List<dynamic>? retrievedUserList = await authHelper.getUserData();
    if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
      Map<String, dynamic> userData = retrievedUserList[0];
      int? userID = userData['id'];
      print('id: $userID');
      await _fetchUserProfile(userID!);
    }
  }

  Future<void> _fetchUserProfile(int userID) async {
    try {
      final response = await RemoteServices.fetchUserProfile(userID);
      if (response.statusCode == 200) {
        final jsonBody = response.body;
        if (jsonBody != null) {
          setState(() {
            userProfile = UserProfile.fromJson(json.decode(jsonBody));
            print("saranya : " + userProfile!.profileUrl);

            imageUrl = userProfile?.profileUrl ?? "";
          });
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {


        String formattedDob = userProfile != null
        ? DateFormat('MM-dd-yyyy').format(DateTime.parse(userProfile!.dob))
        : 'Loading .....';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 4,
                  color: ConstantColors.appBarColor,
                ),
                Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: (imageUrl.isNotEmpty && imageUrl != null)
                          ? Image.network(
                              imageUrl,
                              fit: BoxFit.cover,
                            ).image
                          : const AssetImage('assets/profile.png'),
                    ))
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                userProfile?.name ?? 'Loading .....',
                style: GoogleFonts.nunito(
                  color: ConstantColors.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                userProfile?.contact ?? 'Loading .....',
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ConstantColors.blueColor,
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Bio",
              userProfile?.bio ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "DOB",
              formattedDob,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Country",
              userProfile?.country ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "City",
              userProfile?.city ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Address",
              userProfile?.address ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Total Athletes and Entertainers Subscribed To",
              userProfile?.subscriptionCount ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Cash App Name",
                userProfile?.cashAppName ?? 'Loading .....',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
          ],
        ),
      ),
    );
  }
}
