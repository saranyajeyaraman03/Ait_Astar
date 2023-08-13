import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/widgets/subscription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FanMonthSubscribtionScreen extends StatefulWidget {
  const FanMonthSubscribtionScreen({Key? key}) : super(key: key);

  @override
  State<FanMonthSubscribtionScreen> createState() =>
      _FanMonthSubscribtionScreenState();
}

class _FanMonthSubscribtionScreenState
    extends State<FanMonthSubscribtionScreen> {
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
                      Navigator.pushNamed(context, paymentRoute);
                    },
                    packageName: "Monthly Plan",
                    price: "5",
                    duration: "Per Month",
                    planTxt: "Payment",
                  ),
                  const SizedBox(height: 20),

                 
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
