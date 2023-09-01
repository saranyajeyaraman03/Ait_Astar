import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/fan/payment/buy_fan_subscription_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FanSubscriptionScreen extends StatefulWidget {
  final String subname;
  final String type;
  const FanSubscriptionScreen(
      {Key? key, required this.subname, required this.type})
      : super(key: key);

  @override
  State<FanSubscriptionScreen> createState() => _FanSubscriptionScreenState();
}

class _FanSubscriptionScreenState extends State<FanSubscriptionScreen> {
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
              height: 50,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: ConstantColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
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
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Image.asset(
                    Path.pngLogo,
                    height: 150,
                    width: 120,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.subname,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: ConstantColors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.type,
                    style: GoogleFonts.nunito(
                      fontSize: 16,
                      color: ConstantColors.mainlyTextColor,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 10),
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
                      //Navigator.pushNamed(context, buyFansubscriptionRoute);
                       Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        BuyFanSubscriptionScreen(
                                            subname: widget.subname),
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
                    },
                    child: Text(
                      "Subscribe  ${widget.subname}",
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
