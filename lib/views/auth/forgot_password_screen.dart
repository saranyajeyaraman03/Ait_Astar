// ignore_for_file: use_build_context_synchronously

import 'package:aahstar/router/route_constant.dart';
import 'package:aahstar/service/remote_service.dart';
import 'package:aahstar/values/constant_colors.dart';
import 'package:aahstar/values/path.dart';
import 'package:aahstar/views/auth/auth_helper.dart';
import 'package:aahstar/widgets/main_button.dart';
import 'package:aahstar/widgets/snackbar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  String email = '';
  bool isLoading = false;

  bool validateInputs() {
    if (email.isEmpty) {
      SnackbarHelper.showSnackBar(context, 'This field may not be blank.');
      return false;
    }

    // Email validation
    final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegExp.hasMatch(email)) {
      SnackbarHelper.showSnackBar(context, "Invalid email format.");
      return false;
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    var authHelper = Provider.of<AuthHelper>(context, listen: false);

    return Scaffold(
      backgroundColor: ConstantColors.blueColor,
      appBar: AppBar(
        elevation: 0.0,
        title: Text(
          "Forgot Password",
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
              const SizedBox(height: 40),
              MainButton(
                onTap: () async {
                  if (validateInputs()) {
                    setState(() {
                      isLoading = true;
                    });

                    try {
                      Response response =
                          await RemoteServices.forgetPassword(email);

                      if (kDebugMode) {
                        print('Response status code: ${response.statusCode}');
                      }
                      if (kDebugMode) {
                        print('Response body: ${response.body}');
                      }

                      if (response.statusCode == 200) {
                        SnackbarHelper.showSnackBar(context,
                            "Password reset link has been sent on your email.");
                        Navigator.pushReplacementNamed(context, loginRoute);
                      } else {
                        SnackbarHelper.showSnackBar(
                            context, "User doesn't exists");
                      }
                    } catch (e) {
                      rethrow;
                    } finally {
                      setState(() {
                        isLoading = false;
                      });
                    }
                  }
                },
                text: "Reset Password",
                isLoading: isLoading,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
