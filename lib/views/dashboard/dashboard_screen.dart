import 'package:flutter/material.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/feed/fanScriber_Screen.dart';
import 'package:aahstar/views/feed/fanview_screen.dart';
import 'package:aahstar/views/feed/feed_allpost.dart';
import 'package:aahstar/views/profile/profile_screen.dart';
import 'package:aahstar/views/search/search_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  final int selectIndex;

  const DashboardScreen({Key? key, required this.selectIndex}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late PageController _pageController;
  int _selectedIndex = 0;
  String? userName;
  FeedProfileAndPosts? profileAndPosts;
  Future<bool>? _initialScreen;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectIndex;
    _pageController = PageController(initialPage: _selectedIndex);
    _initialScreen = fetchDataAndDecideInitialScreen();
  }

  @override
  void dispose() {
    _pageController.dispose(); // Dispose of the _pageController.
    super.dispose();
  }

  Future<bool> fetchDataAndDecideInitialScreen() async {
    try {
      AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
      userName = await authHelper.getUserName();
      if (userName != null) {
        profileAndPosts = await RemoteServices.fanScriberAllPost(userName!);
        print("subCount" + profileAndPosts!.isSubscribed.toString());
        setState(() {}); // Update the UI after fetching data.
      }
      return true; // Return true to indicate that data has been fetched.
    } catch (error) {
      print('Error: $error');
      return false; // Return false to indicate that an error occurred.
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _initialScreen,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              //child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError || snapshot.data == false) {
          return const Scaffold(
            body: Center(
              child: Text('Error occurred while fetching data.'),
            ),
          );
        } else {
          final screens = <Widget>[
            if (userName != null)
              profileAndPosts!.subscribedCount == 0
                  ? const FanViewScreen()
                  : const FanScriberScreen(),
            const SearchScreen(),
            const ProfileScreen(),
          ];

          return Scaffold(
            body: PageView(
              controller: _pageController,
              onPageChanged: _onPageChanged,
              physics: const NeverScrollableScrollPhysics(),
              children: screens,
            ),
            bottomNavigationBar: BottomNavigationBar(
              showSelectedLabels: false,
              showUnselectedLabels: false,
              backgroundColor: ConstantColors.appBarColor,
              type: BottomNavigationBarType.fixed,
              onTap: _onItemTapped,
              currentIndex: _selectedIndex,
              selectedIconTheme:
                  const IconThemeData(color: ConstantColors.whiteColor),
              items: const [
                BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    FontAwesomeIcons.house,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    FontAwesomeIcons.magnifyingGlass,
                  ),
                ),
                BottomNavigationBarItem(
                  label: "",
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
