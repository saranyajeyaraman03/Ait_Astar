import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class FilterDrawer extends StatelessWidget {
  FilterDrawer({Key? key}) : super(key: key);

  List<String> categories = [
    'Music',
    'Personal Video',
    'Youtube Video',
    "Aah Star Live",
    'Photo',
    'Message',
    'Trash Talk',
  ];

  List<String> icons = [
    'assets/music_icon.png',
    'assets/video_icon.png',
    'assets/youtube_icon.png',
    "assets/video_stream_icon.png",
    'assets/camera_icon.png',
    'assets/message_icon.jpg',
    'assets/trash_icon.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: ConstantColors.appBarColor,
            ),
            child: Center(
              child: Text(
                'Upload Content',
                style: GoogleFonts.nunito(
                  color: ConstantColors.whiteColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          ListView.builder(
            itemCount: categories.length,
            shrinkWrap: true, // new line
            physics: const NeverScrollableScrollPhysics(),

            itemBuilder: (context, index) {
              if (categories.length > index && icons.length > index) {
                return CategoryCard(
                  categoryName: categories[index],
                  icons: icons[index],
                );
              } else {
                return const SizedBox(); // Placeholder or fallback widget
              }
            },
          )
        ],
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String icons;

  const CategoryCard(
      {Key? key, required this.categoryName, required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(
                width: 10,
              ),
              Image.asset(
                icons,
                height: 24,
                width: 24,
                fit: BoxFit.contain,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                categoryName,
                style: GoogleFonts.nunito(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
            ],
          ),
        ));
  }
}
