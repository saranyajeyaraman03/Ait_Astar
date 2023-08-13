import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<Response> signIn(String username, password) async {
    try {
      Response response = await post(
          Uri.parse('http://18.216.101.141/api/mobile-login/'),
          body: {
            "username": username,
            "password": password,
          });
      return response;
    } catch (e) {
      rethrow; 
    }
  }
  // SignUp Api
  static Future<int> signUp(
    String username,
    String email,
    String password,
    String confirmPassword,
    String userType,
  ) async {
    String apiUrl = 'http://18.216.101.141/api/signup/';

    Map<String, dynamic> signUpData = {
      "username": username,
      "email": email,
      "password": password,
      "confirm_password": confirmPassword,
      "user_type": userType,
    };

    print(signUpData);
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signUpData),
    );

    print(response.body);
    print(response.statusCode);

    return response.statusCode;
  }

  //Forget Password api
 static Future<Response> forgetPassword(String email) async {
    try {
      Response response = await post(
          Uri.parse('http://18.216.101.141/api/request-password-reset/'),
          body: {
            "email": email,
          });
      return response;
    } catch (e) {
      rethrow; 
    }
  }
}


