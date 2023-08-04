import 'dart:async';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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

  // Function to check the login state from SharedPreferences and navigate accordingly
  Future<void> _navigateToInitialScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    final String initialRoute = isLoggedIn ? dashboardRoute : loginRoute;
    //final String initialRoute = isLoggedIn ? homedRoute : loginRoute;

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
