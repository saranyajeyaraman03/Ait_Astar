// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/profile/profile_helper.dart';
import 'package:aahstar/views/profile/user_profile.dart';
import 'package:flutter/foundation.dart';
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

    int? userID = await authHelper.getUserID();

    if (userID != null) {
      await _fetchUserProfile(userID);
    } else {
      print('UserID is null');
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
            if (kDebugMode) {
              print("saranya : ${userProfile!.profileUrl}");
            }

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
    String formattedDob = "";
    if (userProfile?.dob != null && userProfile!.dob.isNotEmpty) {
      formattedDob =
          DateFormat('MM-dd-yyyy').format(DateTime.parse(userProfile!.dob));
    }

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
                userProfile?.name ?? ' ',
                style: GoogleFonts.nunito(
                  color: ConstantColors.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
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
              userProfile?.bio ?? ' ',
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
              userProfile?.country ?? ' ',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "City",
              userProfile?.city ?? ' ',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "State",
              userProfile?.address ?? ' ',
            ),
             Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Phone Number",
              userProfile?.contact ?? ' ',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Athletes & Entertainers Subscribed ",
              userProfile?.subscriptionCount ?? ' ',
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Cash App Name",
              userProfile?.cashAppName ?? ' ',
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
