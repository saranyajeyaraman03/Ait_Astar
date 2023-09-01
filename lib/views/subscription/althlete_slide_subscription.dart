import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AthleteSubscriptionScreen extends StatefulWidget {
  const AthleteSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<AthleteSubscriptionScreen> createState() => _AthleteSubscriptionScreenState();
}

class _AthleteSubscriptionScreenState extends State<AthleteSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text(' Subscription'),
      ),
      body: SingleChildScrollView(
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
                        '\$/',
                        style: GoogleFonts.nunito(
                         fontSize: 14,
                          color: ConstantColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Start Date:',
                        style: GoogleFonts.nunito(
                         fontSize: 14,
                          color: ConstantColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'End Date:',
                        style: GoogleFonts.nunito(
                         fontSize: 14,
                          color: ConstantColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Your subscription has ended at/',
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
                          onPressed: () {},
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
                    ]),
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
                        'Funds Available for withdraw: 0',
                        style: GoogleFonts.nunito(
                         fontSize: 14,
                          color: ConstantColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Pendings : 0',
                        style: GoogleFonts.nunito(
                         fontSize: 14,
                          color: ConstantColors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Total Earnings : 0',
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
                          onPressed: () {},
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
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

