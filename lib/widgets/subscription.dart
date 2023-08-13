import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Subscription extends StatelessWidget {
  const Subscription(
      {Key? key,
      required this.onTap,
      required this.packageName,
      required this.price,
      required this.duration,
      required this.planTxt})
      : super(key: key);

  final Function onTap;
  final String packageName;
  final String price;
  final String duration;
  final String planTxt;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: () => onTap(),
        child: Container(
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            gradient: const LinearGradient(
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              stops: [0.1, 0.5, 0.8],
              colors: [
                Color(0xFF9640bd),
                ConstantColors.appBarColor,
                Color(0xFF7e3bae),
              ],
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                packageName,
                style: GoogleFonts.nunito(
                  color: ConstantColors.whiteColor,
                  fontWeight: FontWeight.w500,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: "$price USD ",
                  style: GoogleFonts.nunito(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: ConstantColors.whiteColor,
                  ),
                  children: [
                    TextSpan(
                      text: duration,
                      style: GoogleFonts.nunito(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: ConstantColors.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    planTxt,
                    style: GoogleFonts.nunito(
                      fontWeight: FontWeight.w600,
                      color: ConstantColors.whiteColor,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: ConstantColors.whiteColor,
                    size: 12,
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
