import 'dart:convert';
import 'package:aahstar/views/feed/feed_allpost.dart';
import 'package:aahstar/views/home/athent_allpost.dart';
import 'package:aahstar/views/search/profile_post.dart';
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
    print('http://18.216.101.141/api/mobile-login/');
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
      print('http://18.216.101.141/api/view-profile/$userID/');

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

  static Future<http.Response> fanSubscriptionPayment(
    String amount,
    String username,
    String subusername,
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
      const apiUrl = 'http://18.216.101.141/api/create-stripe-payment-fan/';

      // Create a map of request data
      final Map<String, dynamic> requestData = {
        "amount": amount,
        "username": username,
        "subs_username": subusername,
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
        "cvv": cvv,
      };

      if (kDebugMode) {
        print('Request Body: $requestData');
      }

      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestData),
      );

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

  // static Future<http.Response> fanSubscriptionPayment(
  //   String amount,
  //   String username,
  //   String subusername,
  //   String city,
  //   String country,
  //   String zipcode,
  //   String state,
  //   String address,
  //   String numberofmonth,
  //   String usertype,
  //   String cardnumber,
  //   String expmonth,
  //   String expyear,
  //   String cvv,
  // ) async {
  //   try {
  //     const apiUrl = 'http://18.216.101.141/api/create-stripe-payment-fan/';
  //     final headers = {'Content-Type': 'application/json'};

  //     final body = {
  //       "amount": amount,
  //       "username": username,
  //       "subs_username":subusername,
  //       "city": city,
  //       "country": country,
  //       "zipcode": zipcode,
  //       "state": state,
  //       "address": address,
  //       "number_of_month": numberofmonth,
  //       "user_type": usertype,
  //       "cardnumber": cardnumber,
  //       "expmonth": expmonth,
  //       "expyear": expyear,
  //       "cvv": cvv
  //     };

  //     if (kDebugMode) {
  //       print('Request Body: $body');
  //     }

  //     final response = await http.post(Uri.parse(apiUrl),
  //         headers: headers, body: json.encode(body));

  //     if (response.statusCode == 200) {
  //       if (kDebugMode) {
  //         print(response.body);
  //       }
  //     } else {
  //       // Handle API errors
  //       if (kDebugMode) {
  //         print('Response body: ${response.body}');
  //       }
  //     }
  //     return response;
  //   } catch (error) {
  //     if (kDebugMode) {
  //       print('An error occurred: $error');
  //     }
  //     rethrow;
  //   }
  // }

  //Search Api
  static Future<List<AthleteUserModel>> fetchAthleteUsers() async {
    final response =
        await http.get(Uri.parse('http://18.216.101.141/api/search-list/'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      print(response.body);
      List<AthleteUserModel> users = jsonData
          .map((userJson) => AthleteUserModel.fromJson(userJson))
          .toList();
      return users;
    } else {
      throw Exception('Failed to load users');
    }
  }

//search by name

  static Future<List<AthleteUserModel>> searchUsersByName(String name) async {
    final response = await http
        .get(Uri.parse('http://18.216.101.141/api/search-list/?q=$name'));

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((userJson) => AthleteUserModel.fromJson(userJson))
          .toList();
    } else {
      throw Exception('Failed to search users');
    }
  }

//view user profile
  static Future<ProfileAndPosts> fetchViewProfile(
      String searchName, String user_name) async {
    final response = await http.get(
      Uri.parse(
          'http://18.216.101.141/api/search-list-details/?subscribed_user=$searchName&user_name=$user_name'),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return ProfileAndPosts.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

//view user profile
  static Future<AthEntAllPost> fetchAthentDetails(String username) async {
    final response = await http.get(
      Uri.parse(
          'http://18.216.101.141/api/ath-ent-detail/?user_name=$username'),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return AthEntAllPost.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  //feed api
  static Future<FeedProfileAndPosts> feedAllPost(String user_name) async {
    print(
        'http://18.216.101.141/api/fan-fanscriber-view/?user_name=$user_name');

    final response = await http.get(
      Uri.parse(
          'http://18.216.101.141/api/fan-fanscriber-view/?user_name=$user_name'),
    );
    print(response.body);

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonData = json.decode(response.body);
      return FeedProfileAndPosts.fromJson(jsonData);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static Future<Response> like(String userName, String postId) async {
    try {
      Response response = await post(
          Uri.parse('http://18.216.101.141/api/create-love/'),
          body: {
            "user_name": userName,
            "post_id": postId,
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

  static Future<Response> hate(String userName, String postId) async {
    try {
      Response response = await post(
          Uri.parse('http://18.216.101.141/api/create-hated/'),
          body: {
            "user_name": userName,
            "post_id": postId,
          });
      return response;
    } catch (e) {
      rethrow;
    }
  }

//api for Trash Talk
  static Future<http.Response> submitTrashTalk(
      String userName, String description) async {
    try {
      final response = await http.post(
        Uri.parse('http://18.216.101.141/api/create-trash-talk/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_name': userName,
          'description': description,
        }),
      );

      print(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //api for meesage
  static Future<http.Response> submitMessage(
      String userName, String description) async {
    try {
      final response = await http.post(
        Uri.parse('http://18.216.101.141/api/create-message/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_name': userName,
          'description': description,
        }),
      );

      print(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

//api for Alert
  static Future<http.Response> submitAlert(
      String userName, String description) async {
    try {
      final response = await http.post(
        Uri.parse('http://18.216.101.141/api/create-alert/'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'user_name': userName,
          'description': description,
        }),
      );

      print(response.body);
      return response;
    } catch (e) {
      rethrow;
    }
  }

  //api for youtube
  static Future<http.Response> submitYoutube(
      String userName, String title, String link) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://18.216.101.141/api/create-youtube/'),
      );

      request.headers['Content-Type'] = 'application/json; charset=UTF-8';

      request.fields['user_name'] = userName;
      request.fields['title'] = title;
      request.fields['description'] = '';
      request.fields['link'] = link;

      print('Request Body: ${request.fields}');

      final response = await request.send();

      final responseString = await response.stream.bytesToString();

      print('Response Body: $responseString');

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

//api for merchandise
  static Future<http.Response> submitMerchandise(
      String userName, String name, String link) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://18.216.101.141/api/create-merchandise/'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['user_name'] = userName;
      request.fields['title'] = name;
      request.fields['description'] = '';
      request.fields['link'] = link;

      // You can also add any additional fields using the request.fields map

      print('Request Fields: ${request.fields}');

      final response = await request.send();

      final responseString = await response.stream.bytesToString();

      print('Response Body: $responseString');

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

//api for event
  static Future<http.Response> submitEvent(String userName, String title,
      String date, String time, String location, String link) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://18.216.101.141/api/create-event/'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['user_name'] = userName;
      request.fields['title'] = title;
      request.fields['date'] = date;
      request.fields['time'] = time;
      request.fields['address'] = location;
      request.fields['link'] = link;

      print('Request Fields: ${request.fields}');

      final response = await request.send();

      final responseString = await response.stream.bytesToString();

      print('Response Body: $responseString');

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

//api for event
  static Future<http.Response> submitRaffle(
      String userName, String date, String time, String link) async {
    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('http://18.216.101.141/api/create-cashapp/'),
      );

      request.headers['Content-Type'] = 'multipart/form-data';

      request.fields['user_name'] = userName;
      request.fields['date'] = date;
      request.fields['time'] = time;
      request.fields['link'] = link;

      print('Request Fields: ${request.fields}');

      final response = await request.send();

      final responseString = await response.stream.bytesToString();

      print('Response Body: $responseString');

      return http.Response(responseString, response.statusCode);
    } catch (e) {
      rethrow;
    }
  }

//api for upload Music
  static Future<http.Response> uploadMusic({
    required String userName,
    required String title,
    required File musicFile,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://18.216.101.141/api/create-music/'),
    );

    request.fields['user_name'] = userName;
    request.fields['title'] = title;
    request.fields['description'] = "";

    request.files.add(
      http.MultipartFile(
        'file',
        musicFile.readAsBytes().asStream(),
        musicFile.lengthSync(),
        filename: fileName,
      ),
    );
    print(request.fields);
    try {
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }

//api for upload Video
  static Future<http.Response> uploadVideo({
    required String userName,
    required String title,
    required File videoFile,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://18.216.101.141/api/create-video/'),
    );

    request.fields['user_name'] = userName;
    request.fields['title'] = title;
    request.fields['description'] = "";

    request.files.add(
      http.MultipartFile(
        'file',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: fileName,
      ),
    );

    try {
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }

//api for upload Live Video
  static Future<http.Response> uploadLiveVideo({
    required String userName,
    required File videoFile,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://18.216.101.141/api/create-saved-livestream/'),
    );

    request.fields['user_name'] = userName;

    request.files.add(
      http.MultipartFile(
        'file',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: fileName,
      ),
    );

    try {
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }

  //api for upload Photo
  static Future<http.Response> uploadPhoto({
    required String userName,
    required String title,
    required File videoFile,
    required String fileName,
  }) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('http://18.216.101.141/api/create-photo/'),
    );

    request.fields['user_name'] = userName;
    request.fields['title'] = title;

    request.files.add(
      http.MultipartFile(
        'file',
        videoFile.readAsBytes().asStream(),
        videoFile.lengthSync(),
        filename: fileName,
      ),
    );

    try {
      final response = await request.send();
      return await http.Response.fromStream(response);
    } catch (e) {
      rethrow;
    }
  }
}
