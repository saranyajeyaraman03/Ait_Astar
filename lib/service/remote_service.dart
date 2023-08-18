import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import '../widgets/snackbar.dart';

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
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(signUpData),
    );

    print(response.body);
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

  //view profile
  static Future<Response> fetchUserProfile(int userID) async {
    try {
      final Uri url =
          Uri.parse('http://18.216.101.141/api/view-profile/$userID/');

      final Map<String, String> headers = {
        'Content-Type': 'application/json',
      };

      final response = await http.get(url, headers: headers);
      print(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<http.StreamedResponse> updateProfile(
    int userID,
    String name,
    String bio,
    String country,
    String city,
    String address,
    String contact,
    String dob,
    String cashApp,
    File? profileImg,
  ) async {
    try {
      final Uri url =
          Uri.parse('http://18.216.101.141/api/view-profile/$userID/');
      var request = http.MultipartRequest('PUT', url)
        ..headers.addAll({'Content-Type': 'multipart/form-data'});

print(cashApp);
      request.fields['name'] = name;
      request.fields['bio'] = bio;
      request.fields['country'] = country;
      request.fields['city'] = city;
      request.fields['address'] = address;
      request.fields['contact'] = contact;
      request.fields['age'] = dob;
      request.fields['cash_app_name'] = cashApp;

      if (profileImg != null) {
        // Add the image file as a multipart field
        request.files.add(http.MultipartFile(
          'p_picture',
          profileImg.readAsBytes().asStream(),
          profileImg.lengthSync(),
          filename: profileImg.path.split('/').last,
          contentType: MediaType('image', 'jpeg'),
        ));
      }

  print('Fields: ${request.fields}');

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      print('API response : $responseBody');
      print('API request failed with status code: ${response.statusCode}');
      return response;
    } catch (error) {
      rethrow;
    }
  }

  static Future<http.Response> registrationPayment(
    String amount,
    String username,
    String city,
    String country,
    String zipcode,
    String state,
    String address,
    String number_of_month,
    String user_type,
    String cardnumber,
    String expmonth,
    String expyear,
    String cvv,
  ) async {
    try {
      const apiUrl = 'http://18.216.101.141/api/create-stripe-payment/';
      final headers = {'Content-Type': 'application/json'};

      final body = {
        "amount": amount,
        "username": username,
        "city": city,
        "country": country,
        "zipcode": zipcode,
        "state": state,
        "address": address,
        "number_of_month": number_of_month,
        "user_type": user_type,
        "cardnumber": cardnumber,
        "expmonth": expmonth,
        "expyear": expyear,
        "cvv": cvv
      };

      print('Request Body: $body');

      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        print('Payment created successfully');
        print(response.body);
      } else {
        // Handle API errors
        print('Failed to create payment');
        print('Status code: ${response.statusCode}');
        print('Response body: ${response.body}');
      }
      return response;
    } catch (error) {
      // Handle exceptions here
      print('An error occurred: $error');
      rethrow; // Rethrow the caught exception
    }
  }
}
