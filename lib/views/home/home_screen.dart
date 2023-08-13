import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/comman.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

//This screen Used for Entertainer and Athlete
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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

  final GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Provider.of<Common>(context, listen: false).drawer(context),
      backgroundColor: ConstantColors.whiteColor,
      appBar: AppBar(
        backgroundColor: ConstantColors.appBarColor,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          "Home Screen",
          style: GoogleFonts.nunito(
            color: ConstantColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            FontAwesomeIcons.bars,
            color: ConstantColors.whiteColor,
          ),
          onPressed: () {
            _drawerKey.currentState?.openDrawer();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.pushNamed(context, uploadContentRoute);
                },
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.settings, color: Colors.white),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Uploaded Exclusive Content',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'View Uploaded Content',
                    style: GoogleFonts.nunito(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, liveRoute);
                      },
                      child: Image.asset(
                        "assets/video_stream_icon.png",
                        height: 50,
                        width: 100,
                      ))
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 40,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  itemBuilder: (context, index) {
                    return CategoryCard(
                      categoryName: categories[index],
                      icons: icons[index],
                    );
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 22 / 30,
                  ),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return CategoryViewCard(
                      categoryName: categories[index],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final String icons;

  const CategoryCard(
      {super.key, required this.categoryName, required this.icons});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            width: 10,
          ),
          SizedBox(
            height: 24,
            width: 24,
            child: Image.asset(
              icons,
              fit: BoxFit.contain,
            ),
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
    );
  }
}

class CategoryViewCard extends StatelessWidget {
  final String categoryName;

  const CategoryViewCard({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: const BorderSide(color: Colors.grey, width: 1),
      ),
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: Image.asset(
                      "assets/logo.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  const Text(
                    '15 hours ago',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Category :',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Message',
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                        backgroundColor: ConstantColors.appBarColor),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                'If you are a Aah Star Customers with an account on this platform, you are solely responsible',
                style: TextStyle(fontSize: 12),
              ),
              const SizedBox(
                height: 30,
              ),
              SizedBox(
                width: 120,
                height: 30,
                child: ElevatedButton(
                  onPressed: () => {
                    QuickAlert.show(
                      context: context,
                      type: QuickAlertType.confirm,
                      onCancelBtnTap: () {},
                      onConfirmBtnTap: () {},
                      text: 'Do you want to delete this item',
                      confirmBtnText: 'Yes',
                      cancelBtnText: 'No',
                      confirmBtnColor: ConstantColors.appBarColor,
                    ),
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Colors.redAccent),
                  ),
                  child: const Row(
                    children: [
                      IconTheme(
                        data: IconThemeData(size: 16.0, color: Colors.white),
                        child: Icon(Icons.delete),
                      ),
                      SizedBox(width: 8),
                      Text('Delete'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
