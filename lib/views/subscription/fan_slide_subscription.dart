import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FanSlideSubscriptionScreen extends StatefulWidget {
  const FanSlideSubscriptionScreen({Key? key}) : super(key: key);

  @override
  State<FanSlideSubscriptionScreen> createState() =>
      _FanSlideSubscriptionScreenState();
}

class _FanSlideSubscriptionScreenState
    extends State<FanSlideSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        title: const Text(' Subscription'),
      ),
      body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Container(
            height: 200,
            child: ListView.builder(
              itemCount: 1, 
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Name: prasanna_athlete",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Start Date: Aug. 28, 2023",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "End Date: Sept. 28, 2023",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "User Type: athlete",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Plan Type: Monthly - \$5",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Is Auto-Renew: True",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Action: ",
                          style: GoogleFonts.nunito(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          )),
    );
  }
}
