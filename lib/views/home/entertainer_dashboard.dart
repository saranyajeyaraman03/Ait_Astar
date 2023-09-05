import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/views/home/home_screen.dart';
import 'package:aahstar/views/profile/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class EntertainerDashboardScreen extends StatefulWidget {
  final int selectIndex;

  const EntertainerDashboardScreen({Key? key, required this.selectIndex})
      : super(key: key);

  @override
  State<EntertainerDashboardScreen> createState() =>
      _EntertainerDashboardScreenState();
}

class _EntertainerDashboardScreenState
    extends State<EntertainerDashboardScreen> {
  PageController _pageController = PageController();
  int _selectIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectIndex = widget.selectIndex;
    _pageController = PageController(initialPage: _selectIndex);
  }

  void _onPageChanged(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  void _onItemTapped(int index) {
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: _onPageChanged,
        physics: const NeverScrollableScrollPhysics(),
        children: const [
          HomeScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: ConstantColors.appBarColor,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        currentIndex: _selectIndex,
        selectedIconTheme: const IconThemeData(
          color: ConstantColors.whiteColor,
        ),
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
              Icons.person,
              size: 30,
            ),
          ),
          // Add more BottomNavigationBarItems as needed
        ],
      ),
    );
  }
}
