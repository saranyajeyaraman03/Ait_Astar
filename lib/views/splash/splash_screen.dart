import 'dart:async';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/views/dashboard/dashboard_screen.dart';
import 'package:aahstar/views/home/entertainer_dashboard.dart';
import 'package:aahstar/widgets/custom_router.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
 

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _navigateToInitialScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ConstantColors.whiteColor,
      body: Center(
        child: Image.asset(
          Path.pngLogo,
          width: MediaQuery.of(context).size.width - 100,
        ),
      ),
    );
  }

  Future<String?> getUserType() async {
    AuthHelper authHelper = Provider.of<AuthHelper>(context, listen: false);
    List<dynamic>? retrievedUserList = await authHelper.getUserData();

    if (retrievedUserList != null && retrievedUserList.isNotEmpty) {
      Map<String, dynamic> userData = retrievedUserList[0];
      String? userType = userData['user_type'];
      if (kDebugMode) {
        print('user_type: $userType');
      }
      return userType;
    }

    return null;
  }

  // Function to check the login state from SharedPreferences and navigate accordingly
  Future<void> _navigateToInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userType = await getUserType();

    String? initialHomeRoute;

    if (userType != null) {
      initialHomeRoute = userType.toLowerCase() == "fan"
          ? dashboardRoute
          : entertaineDashboardRoute;
    } else {
      initialHomeRoute = loginRoute;
    }

    final String initialRoute = isLoggedIn ? initialHomeRoute : loginRoute;

    if (kDebugMode) {
      print(isLoggedIn);
    }

    Timer(
      const Duration(seconds: 3),
      () {
        if (initialHomeRoute == dashboardRoute) {
          Navigator.pushReplacement(
            context,
            CustomPageRoute(
              builder: (context) => const DashboardScreen(selectIndex: 0),
            ),
          );
        } else if (initialHomeRoute == entertaineDashboardRoute) {
          Navigator.pushReplacement(
            context,
            CustomPageRoute(
              builder: (context) =>
                  const EntertainerDashboardScreen(selectIndex: 0),
            ),
          );
        } else {
          // Handle other cases or navigate to the login screen
          Navigator.pushReplacementNamed(
            context,
            initialRoute,
          );
        }
      },
    );
  }
}
