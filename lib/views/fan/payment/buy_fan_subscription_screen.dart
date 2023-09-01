
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/payment/fan_payment_screen.dart';
import 'package:aahstar/widgets/subscription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyFanSubscriptionScreen extends StatefulWidget {
   final String subname; 

  const BuyFanSubscriptionScreen({Key? key, required this.subname})
      : super(key: key);


  @override
  State<BuyFanSubscriptionScreen> createState() =>
      _BuyFanSubscriptionScreenState();
}

class _BuyFanSubscriptionScreenState
    extends State<BuyFanSubscriptionScreen> {
  int? userID;
  
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
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height - 600,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 60),
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
                    "Welcome To Aah Star FanScriber",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: ConstantColors.darkBlueColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  Text(
                    "FanScriber",
                    style: GoogleFonts.nunito(
                      fontSize: 20,
                      color: ConstantColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Subscription(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                   FanPaymentScreen(
                                      paymentAmount: "5",subname: widget.subname, ),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    packageName: "Monthly Plan",
                    price: "5",
                    duration: "Per Month",
                    planTxt: "Payment",
                  ),
                  const SizedBox(height: 20),
                  Subscription(
                    onTap: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                   FanPaymentScreen(
                                      paymentAmount: "50",subname: widget.subname),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
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
                    packageName: "Yearly Plan",
                    price: "50",
                    duration: "Per Year",
                    planTxt: "Choose Plan",
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
