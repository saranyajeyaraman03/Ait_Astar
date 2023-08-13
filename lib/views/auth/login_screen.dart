// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/main_button.dart';
import 'package:aahstar/widgets/secondary_button.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  bool validateInputs() {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    var authHelper = Provider.of<AuthHelper>(context, listen: false);

    return Scaffold(
      backgroundColor: ConstantColors.blueColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Image.asset(
                Path.pngLogo,
                width: MediaQuery.of(context).size.width - 150,
              ),
              const SizedBox(height: 40),
              TextField(
                onChanged: (value) {
                  setState(() {
                    username = value.trim();
                  });
                },
                style: GoogleFonts.nunito(
                  color: ConstantColors.black,
                  fontWeight: FontWeight.w500,
                ),
                decoration: authHelper.textFieldDecoration(
                  placeholder: "Enter Username",
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                onChanged: (value) {
                  setState(() {
                    password = value.trim();
                  });
                },
                obscureText: true,
                style: GoogleFonts.nunito(
                  color: ConstantColors.black,
                ),
                decoration: authHelper.textFieldDecoration(
                  placeholder: "Enter Passswrd",
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, forgotPasswordRoute);
                    },
                    child: Text(
                      "Forgot Password?",
                      style: GoogleFonts.nunito(
                        color: ConstantColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(height: 40),
              MainButton(
                onTap: () async {
                  if (validateInputs()) {
                    try {
                      Response response =
                          await RemoteServices.signIn(username, password);

                      print('Response status code: ${response.statusCode}');
                      print('Response body: ${response.body}');

                      if (response.statusCode == 200) {
                        var data = jsonDecode(response.body);
                        AuthHelper authHelper =
                            Provider.of<AuthHelper>(context, listen: false);
                        authHelper.setLoggedIn(true);
                       authHelper.setUserData(data);
                        String userType = data[0]['user_type'];
                        Navigator.pushReplacementNamed(
                            context,
                            userType.toString().toLowerCase() == "fan"
                                ? dashboardRoute
                                : homedRoute);
                      } else {
                        SnackbarHelper.showSnackBar(context,
                            "Invalid Username or Password! Please try again!");
                      }
                    } catch (e) {
                      print('An error occurred: ${e.toString()}');
                      // Handle the error
                    }
                  }
                },
                text: "Sign In",
              ),
              const SizedBox(height: 15),
              SecondaryButton(
                text: "Sign Up Now!",
                onTap: () {
                  Navigator.pushNamed(context, signUpRoute);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
