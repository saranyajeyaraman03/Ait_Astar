import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/subscription/subscription_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class FanSlideSubscriptionScreen extends StatefulWidget {
  const FanSlideSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<FanSlideSubscriptionScreen> createState() =>
      _FanSlideSubscriptionScreenState();
}

class _FanSlideSubscriptionScreenState
    extends State<FanSlideSubscriptionScreen> {
  String? userName;
late List<FanSubscriptionList> fanSubscription = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();

      if (userName != null) {
        fanSubscription = await RemoteServices.fanSubscriptions(userName!);
        setState(() {});
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void _launchURL() async {
    String webURL = "http://18.216.101.141/login/";
    print(webURL);
    String encodedURL = Uri.encodeFull(webURL);

    if (await canLaunch(encodedURL)) {
      await launch(encodedURL);
    } else {
      throw 'Could not launch $encodedURL';
    }
  }

  String formattedDate(String date) {
    final dateParts = date.split('-');
    if (dateParts.length == 3) {
      final year = dateParts[2];
      final month = dateParts[1];
      final day = dateParts[0];

      final monthNames = [
        'Jan.',
        'Feb.',
        'Mar.',
        'Apr.',
        'May',
        'Jun.',
        'Jul.',
        'Aug.',
        'Sep.',
        'Oct.',
        'Nov.',
        'Dec.'
      ];

      final formattedMonth = monthNames[int.parse(month) - 1];
      return "$formattedMonth $day, $year";
    } else {
      return date;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text(' Subscription'),
      ),
      body: fanSubscription == null
          ? const SizedBox()

          : SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: ListView.builder(
                itemCount: fanSubscription.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  FanSubscriptionList subscription = fanSubscription[index];
                  return Card(
                    child: Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ConstantColors.appBarColor,
                          width: 2.0,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Name : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: subscription.subscribedUser,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Start Date : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: formattedDate(subscription.startDate),
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "End Date : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: formattedDate(subscription.endDate),
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "User Type : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: subscription.userType,
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Plan Type : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text:
                                      "${subscription.planType} - \$${subscription.planPrice.toStringAsFixed(2)}",
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Is Auto-Renew : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: " True",
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: "Action : ",
                                  style: GoogleFonts.nunito(
                                      fontSize: 16,
                                      color: ConstantColors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: " True",
                                  style: GoogleFonts.nunito(
                                    fontSize: 16,
                                    color: ConstantColors.black,
                                  ),
                                ),
                                const WidgetSpan(
                                    child: SizedBox(
                                  width: 50,
                                )),
                                WidgetSpan(
                                    child: GestureDetector(
                                        onTap: () {
                                          _launchURL();
                                        },
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: const Text(
                                            "Cancel Subscription",
                                            style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                            ),
                                          ),
                                        )))
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
    );
  }
}
