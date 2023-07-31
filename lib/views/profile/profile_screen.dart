import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/profile/profile_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.whiteColor,
        elevation: 0.0,
        title: Text(
          "Profile",
          style: GoogleFonts.nunito(
            fontWeight: FontWeight.w500,
            color: ConstantColors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Provider.of<ProfileHelper>(context, listen: false).header(
              "",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 18,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Name",
              "Jane",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Phone Number or Email",
              "jane@abc.com",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Gender",
              "Female",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Joined On",
              "24 Sep 2022",
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
