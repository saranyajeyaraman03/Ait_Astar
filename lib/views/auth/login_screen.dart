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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';
  bool isLoading = false;

  late FocusNode _usernameFocus;
  late FocusNode _passwordFocus;

  late TextEditingController _usernameController;
  late TextEditingController _passwordController;

  bool validateInputs() {
    if (username.isEmpty || password.isEmpty) {
      return false;
    }
    return true;
  }

  void clearCredentials() {
    setState(() {
      _usernameController.clear();
      _passwordController.clear();
    });
  }

  @override
  void initState() {
    _usernameFocus = FocusNode();
    _passwordFocus = FocusNode();
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _passwordFocus.dispose();
    _usernameController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  void _launchURL() async {
    String webURL = "http://18.216.101.141/login/";

    if (await canLaunch(webURL)) {
      await launch(webURL);
    } else {
      throw 'Could not launch $webURL';
    }
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
                controller: _usernameController,
                focusNode: _usernameFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
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
                controller: _passwordController,
                focusNode: _passwordFocus,
                onEditingComplete: () {
                  _passwordFocus.unfocus();
                },
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
                  placeholder: "Enter Passsword",
                ),
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, forgotPasswordRoute);
                      clearCredentials();
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
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      Response response =
                          await RemoteServices.signIn(username, password);

                      if (kDebugMode) {
                        print('Response body: ${response.body}');
                      }

                      if (response.statusCode == 200) {
                        var data = jsonDecode(response.body);
                        AuthHelper authHelper =
                            Provider.of<AuthHelper>(context, listen: false);
                        authHelper.setUsername(username);
                        Map<String, dynamic> jsonMap = data[0];
                        int userId = jsonMap['id'];
                        print('User ID: $userId');
                        authHelper.setUserID(userId);
                        authHelper.setUserData(data);
                        String userType = data[0]['user_type'];
                        bool isBank = data[0]['is_bank'];
                        print(isBank);

                        if (userType.toString().toLowerCase() == "fan") {
                          authHelper.setLoggedIn(true);
                          Navigator.pushReplacementNamed(
                              context, dashboardRoute);
                        } else {
                          if (isBank) {
                            authHelper.setLoggedIn(true);
                            Navigator.pushReplacementNamed(
                                context, entertaineDashboardRoute);
                          } else {
                            clearCredentials();
                            authHelper.setLoggedIn(false);
                            _launchURL();
                          }
                        }
                      } else {
                        SnackbarHelper.showSnackBar(context,
                            "Invalid Username or Password! Please try again!");
                      }
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });

                      print('An error occurred: ${e.toString()}');
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                text: "Sign In",
                isLoading: isLoading,
              ),
              const SizedBox(height: 15),
              SecondaryButton(
                text: "Sign Up Now!",
                onTap: () {
                  Navigator.pushNamed(context, signUpRoute);
                  clearCredentials();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
