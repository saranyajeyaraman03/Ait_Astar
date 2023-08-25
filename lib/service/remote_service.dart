import 'dart:convert';
import 'package:aahstar/views/search/all_post.dart';
import 'package:aahstar/views/search/user_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'dart:io';
// ignore: depend_on_referenced_packages
import 'package:http_parser/http_parser.dart';

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
  static Future<Response> signUp(
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

    if (kDebugMode) {
      print(response.body);
    }
    return response;
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
      if (kDebugMode) {
        print(response.body);
      }
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

      request.fields['name'] = name;
      request.fields['bio'] = bio;
      request.fields['country'] = country;
      request.fields['city'] = city;
      request.fields['address'] = address;
      request.fields['contact'] = contact;
      request.fields['dob'] = dob;
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


      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (kDebugMode) {
        print('API response : $responseBody');
      }
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
    String numberofmonth,
    String usertype,
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
        "number_of_month": numberofmonth,
        "user_type": usertype,
        "cardnumber": cardnumber,
        "expmonth": expmonth,
        "expyear": expyear,
        "cvv": cvv
      };

      if (kDebugMode) {
        print('Request Body: $body');
      }

      final response = await http.post(Uri.parse(apiUrl),
          headers: headers, body: json.encode(body));

      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
      } else {
        // Handle API errors
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
      }
      return response;
    } catch (error) {
      if (kDebugMode) {
        print('An error occurred: $error');
      }
      rethrow; 
    }
  }

  //Search Api
  static Future<List<AthleteUserModel>> fetchAthleteUsers() async {
  final response = await http.get(Uri.parse('http://18.216.101.141/api/search-list/'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
        List<AthleteUserModel> users = jsonData.map((userJson) => AthleteUserModel.fromJson(userJson)).toList();
        return users;
  } else {
    throw Exception('Failed to load users');
  }
}

//search by name

static Future<List<AthleteUserModel>> searchUsersByName(String name) async {
  final response = await http.get(Uri.parse('http://18.216.101.141/api/search-list/?q=$name'));

  if (response.statusCode == 200) {
    final List<dynamic> jsonData = json.decode(response.body);
    return jsonData.map((userJson) => AthleteUserModel.fromJson(userJson)).toList();
  } else {
    throw Exception('Failed to search users');
  }
}

//view user profile
static Future<List<AllPost>> fetchViewProfile(String name) async {
  print(name);
  final response = await http.get(
    Uri.parse('http://18.216.101.141/api/search-list-details/?name=$name'),
  );
    print(response.body);

  if (response.statusCode == 200) {
    Map<String, dynamic> jsonData = json.decode(response.body);
    List<dynamic> postsData = jsonData['all_posts'];    
    return postsData.map((postData) => AllPost.fromJson(postData)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}


}
