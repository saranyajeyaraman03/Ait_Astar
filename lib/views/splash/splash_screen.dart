// ignore_for_file: unrelated_type_equality_checks

import 'dart:async';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
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
      print('user_type: $userType');
      return userType;
    }

    return null;
  }

  // Function to check the login state from SharedPreferences and navigate accordingly
  Future<void> _navigateToInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    String? userType = await getUserType();
    print(userType!.toLowerCase());
    
      String initialHomeRoute = userType.toLowerCase() == "fan"
          ? dashboardRoute
          : entertaineDashboardRoute;
    
    final String initialRoute = isLoggedIn ? initialHomeRoute : loginRoute;

    if (kDebugMode) {
      print(isLoggedIn);
    }
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacementNamed(
        context,
        initialRoute,
      ),
    );
  }
}
