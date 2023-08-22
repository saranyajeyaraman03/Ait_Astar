// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/main_button.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late FocusNode _usernameFocus;
  late FocusNode _emailFocus;
  late FocusNode _passwordFocus;
  late FocusNode _confirmPasswordFocus;

  final List<String> _accountType = ['Fan', 'Athlete', 'Entertainer'];
  String _selectedAccountType = "";

  String username = '';
  String email = '';
  String password = '';
  String confirmPassword = '';

  bool validateInputs() {
    if (username.isEmpty ||
        email.isEmpty ||
        password.isEmpty ||
        confirmPassword.isEmpty ||
        _selectedAccountType.isEmpty) {
      SnackbarHelper.showSnackBar(
          context, 'Invalid input. Please check your fields.');
      return false;
    }

    // Email validation
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      SnackbarHelper.showSnackBar(context, "Invalid email format.");
      return false;
    }
    // Password validation criteria
    if (password.length < 8) {
      SnackbarHelper.showSnackBar(
          context, 'Password must contain at least 8 characters.');
      return false;
    }

    if (password == username ||
        password == email ||
        password == _selectedAccountType) {
      SnackbarHelper.showSnackBar(context,
          "Password can't be too similar to other personal information.");
      return false;
    }
    // Confirm password validation
    if (password != confirmPassword) {
      SnackbarHelper.showSnackBar(
          context, "Password and confirm password must match.");
      return false; //
    }

    return true;
  }

  @override
  void initState() {
    setState(() {
      _selectedAccountType = _accountType[0];
    });
    _usernameFocus = FocusNode();
    _emailFocus = FocusNode();
    _passwordFocus = FocusNode();
    _confirmPasswordFocus = FocusNode();

    super.initState();
  }

  @override
  void dispose() {
    _usernameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var authHelper = Provider.of<AuthHelper>(context, listen: false);

    return Scaffold(
      backgroundColor: ConstantColors.blueColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Sign Up",
          style: GoogleFonts.nunito(
            color: ConstantColors.whiteColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                Path.pngLogo,
                width: MediaQuery.of(context).size.width - 150,
              ),
              const SizedBox(height: 40),
              TextField(
                focusNode: _usernameFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_emailFocus);
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
                focusNode: _emailFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_passwordFocus);
                },
                onChanged: (value) {
                  setState(() {
                    email = value.trim();
                  });
                },
                keyboardType: TextInputType.emailAddress,
                style: GoogleFonts.nunito(
                  color: ConstantColors.black,
                  fontWeight: FontWeight.w500,
                ),
                decoration: authHelper.textFieldDecoration(
                  placeholder: "Enter Email",
                ),
              ),
              const SizedBox(height: 25),
              TextField(
                focusNode: _passwordFocus,
                onEditingComplete: () {
                  FocusScope.of(context).requestFocus(_confirmPasswordFocus);
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
              const SizedBox(height: 25),
              TextField(
                focusNode: _confirmPasswordFocus,
                onEditingComplete: () {
                  _confirmPasswordFocus.unfocus(); 
                },
                onChanged: (value) {
                  setState(() {
                    confirmPassword = value.trim();
                  });
                },
                obscureText: true,
                style: GoogleFonts.nunito(
                  color: ConstantColors.black,
                ),
                decoration: authHelper.textFieldDecoration(
                  placeholder: "Confirm Passswrd",
                ),
              ),
              const SizedBox(height: 25),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: ConstantColors.inputColor,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: DropdownButton(
                  isExpanded: true,
                  underline: Container(),
                  value: _selectedAccountType,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedAccountType = newValue!;
                    });
                  },
                  items: _accountType.map((location) {
                    return DropdownMenuItem(
                      value: location,
                      child: Text(
                        location,
                        style: GoogleFonts.nunito(
                          color: ConstantColors.black,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
              const SizedBox(height: 40),
              MainButton(
                onTap: () async {
                  if (validateInputs()) {
                    final statusCode = await RemoteServices.signUp(
                      username,
                      email,
                      password,
                      confirmPassword,
                      _selectedAccountType,
                    );

                    if (statusCode == 200) {
                      AuthHelper authHelper =
                          Provider.of<AuthHelper>(context, listen: false);
                      authHelper.setLoggedIn(true);
                      Navigator.pushReplacementNamed(
                          context,
                          _selectedAccountType == "Fan"
                              ? dashboardRoute
                              : buySubscriptionRoute);
                    } else if (statusCode == 400) {
                      print('Signup failed with status code: $statusCode');
                      SnackbarHelper.showSnackBar(context,
                          'You have already register this email as a Fan');
                    } else {
                      // Signup failed
                      print('Signup failed with status code: $statusCode');
                      SnackbarHelper.showSnackBar(
                          context, 'A user with that username already exists.');
                    }
                  }
                },
                text: "Sign Up",
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
