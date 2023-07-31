import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileHelper extends ChangeNotifier {
  Widget header(String profilePicture) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hey There !",
                style: GoogleFonts.nunito(
                  color: ConstantColors.blueColor,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget section(String title, String data) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: ConstantColors.blueColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                data,
                style: GoogleFonts.nunito(
                  fontSize: 14,
                  color: ConstantColors.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
