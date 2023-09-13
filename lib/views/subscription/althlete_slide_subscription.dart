// ignore_for_file: unnecessary_null_comparison

import 'dart:convert';

import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/constant_url.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class AthleteSubscriptionScreen extends StatefulWidget {
  const AthleteSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<AthleteSubscriptionScreen> createState() =>
      _AthleteSubscriptionScreenState();
}

class _AthleteSubscriptionScreenState extends State<AthleteSubscriptionScreen> {
  late String startDate = '';
  late String endDate = '';
  late String planType = 'Monthly';
  late double planPrice = 0.0;
  late double fundsAvailableForWithdraw = 0.0;
  late double pendings = 0.0;
  late double totalEarnings = 0.0;
  late Response response =
      Response('', 200); // Initialize with an empty response

  String? userName;

  void setSubscriptionInfo(Map<String, dynamic> responseData) {
    final activeSubscription = responseData['active_subscription'][0];
    startDate = activeSubscription['start_date'] ?? '';
    endDate = activeSubscription['end_date'] ?? '';
    planType = activeSubscription['plan_type'] ?? 'Monthly';
    planPrice = activeSubscription['plan_price'] ?? 0.0;
    final balance = responseData['balance'];
    fundsAvailableForWithdraw = balance['funds_available_for_withdraw'] ?? 0.0;
    pendings = balance['pendings'] ?? 0.0;
    totalEarnings = balance['total_earnings'] ?? 0.0;
  }

  @override
  void initState() {
    fetchSubscriptionData();
    super.initState();
  }

  Future<void> fetchSubscriptionData() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();

      if (userName != null) {
        response = await RemoteServices.entSubscriptions(userName!);
        print(response);
        final responseData = json.decode(response.body);
        setSubscriptionInfo(responseData);
        setState(() {});
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _launchURL() async {
    String webURL = ConstantUrl.loginUrl;
    print(webURL);
    String encodedURL = Uri.encodeFull(webURL);

    if (await canLaunch(encodedURL)) {
      await launch(encodedURL);
    } else {
      throw 'Could not launch $encodedURL';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text('Subscription'),
      ),
      body: response == null
          ? const SizedBox()
          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Active Subscription',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            '\$${planPrice.toStringAsFixed(2)} / $planType',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Start Date: ${startDate.isEmpty ? "" : DateFormat("MMM. d, yyyy").format(DateTime.parse(startDate))}',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'End Date: ${endDate.isEmpty ? "" : DateFormat("MMM. d, yyyy").format(DateTime.parse(endDate))}',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Your subscription has ended at/   ${endDate.isEmpty ? "" : DateFormat("MMM. d, yyyy").format(DateTime.parse(endDate))}',
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _launchURL();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                              ),
                              child: Text(
                                'Cancel Subscription',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: ConstantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              'Balance',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Funds Available for withdraw: ${fundsAvailableForWithdraw.toStringAsFixed(2)}', // Display funds available
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Pendings: ${pendings.toStringAsFixed(2)}', // Display pendings
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Total Earnings: ${totalEarnings.toStringAsFixed(2)}', // Display total earnings
                            style: GoogleFonts.nunito(
                              fontSize: 14,
                              color: ConstantColors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          const Divider(
                            color: Colors.grey,
                            thickness: 2,
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                _launchURL();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                              ),
                              child: Text(
                                'Payouts \$0',
                                style: GoogleFonts.nunito(
                                  fontSize: 14,
                                  color: ConstantColors.whiteColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
