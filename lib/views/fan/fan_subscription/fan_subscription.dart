import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FanSubscribtionScreen extends StatefulWidget {
  const FanSubscribtionScreen({Key? key}) : super(key: key);

  @override
  State<FanSubscribtionScreen> createState() => _FanSubscribtionScreenState();
}

class _FanSubscribtionScreenState extends State<FanSubscribtionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.appBarColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.transparent,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              // width: MediaQuery.of(context).size.width,
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                color: ConstantColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  Text(
                    "Hello, saranya",
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      color: ConstantColors.darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "You have not subscribed to this Athlete or Entertainer. If you want to view their Exclusive Content, please become their FanScriber. Click this link to FanScribe.",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    Path.pngLogo,
                    height: 200,
                    width: 200,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "Arvind",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: ConstantColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    "*arvind007",
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: ConstantColors.mainlyTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          ConstantColors.darkBlueColor),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, fanMonthSubscriptionRoute);
                    },
                    child: const Text(
                      'Subscribe arvind007',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
