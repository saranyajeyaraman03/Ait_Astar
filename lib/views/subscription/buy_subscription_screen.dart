import 'dart:convert';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/payment/payment_screen.dart';
import 'package:aahstar/widgets/subscription.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BuySubscribtionScreen extends StatefulWidget {
  const BuySubscribtionScreen({Key? key}) : super(key: key);

  @override
  State<BuySubscribtionScreen> createState() => _BuySubscribtionScreenState();
}

class _BuySubscribtionScreenState extends State<BuySubscribtionScreen> {
  int? userID;
  late String  username;

  Future<void> _initializeData() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    List<dynamic>? retrievedUserList = await authHelper.getUserData();
    if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
      Map<String, dynamic> userData = retrievedUserList[0];
      userID = userData['id'];
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
          Map<String, dynamic> data = json.decode(jsonBody);
          username = data['user']['username'];
          print('Username: $username');
        }
      }
    } catch (error) {
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ConstantColors.appBarColor,
        appBar: AppBar(
          backgroundColor: ConstantColors.transparent,
          elevation: 0.0,
        ),
        body: WillPopScope(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height - 600,
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 40),
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 1.3,
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
                          "Hello, Dann",
                          style: GoogleFonts.nunito(
                            fontSize: 14,
                            color: ConstantColors.mainlyTextColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Choose your subscription plan",
                          style: GoogleFonts.nunito(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Subscription(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     PaymentScreen(paymentAmount: "20",userName: username),
                              ),
                            );
                          },
                          packageName: "Monthly Plan",
                          price: "20",
                          duration: "Per Month",
                          planTxt: "Choose Plan",
                        ),
                        const SizedBox(height: 10),
                        Subscription(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                     PaymentScreen(paymentAmount: "200",userName: username),
                              ),
                            );
                          },
                          packageName: "Yearly Plan",
                          price: "200",
                          duration: "Per Year",
                          planTxt: "Choose Plan",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            onWillPop: () async {
              // print(isLoggedIn);

              return true;
            }));
  }
}
