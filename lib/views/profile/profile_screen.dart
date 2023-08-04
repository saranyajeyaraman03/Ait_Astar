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
                const Positioned(
                    bottom: -50.0,
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile.png'),
                    ))
              ],
            ),
            const SizedBox(
              height: 60,
            ),
            Center(
              child: Text(
                'Saranya',
                style: GoogleFonts.nunito(
                  color: ConstantColors.blueColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                '+91 9965056147',
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
              "DOB",
              " 06-24-1998",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Country",
              "India",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "City",
              "Coimbatore",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Address",
              "11/25 G Annamadam Street,Sulur",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Total Athletes and Entertainers Subscribed To",
              "0",
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 10,
              color: const Color(0xFFF2F2F2),
            ),
            Provider.of<ProfileHelper>(context, listen: false).section(
              "Cash App Name",
              "",
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
