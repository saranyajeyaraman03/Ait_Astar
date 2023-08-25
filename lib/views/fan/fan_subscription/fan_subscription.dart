import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FanSubscribtionScreen extends StatefulWidget {
  final String name;
  final String type;
  const FanSubscribtionScreen(
      {Key? key, required this.name, required this.type})
      : super(key: key);

  @override
  State<FanSubscribtionScreen> createState() => _FanSubscribtionScreenState();
}

class _FanSubscribtionScreenState extends State<FanSubscribtionScreen> {
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
  }

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
                    "Hello, $userName",
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
                    widget.name,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: ConstantColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.type,
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
                      Navigator.pushNamed(context, fansubscriptionPayment);
                    },
                    child: Text(
                      "Subscribe  ${widget.name}",
                      style: const TextStyle(color: Colors.white, fontSize: 16),
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
