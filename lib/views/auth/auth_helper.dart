import 'dart:convert';

import 'package:aahstar/values/constant_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthHelper extends ChangeNotifier {
  bool _isLoggedIn = false;

  bool get isLoggedIn => _isLoggedIn;

  // Load the login state from shared preferences
  Future<void> loadLoggedInState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isLoggedIn = prefs.getBool('isLoggedIn') ?? false;
    notifyListeners();
  }

  Future<void> setLoggedIn(bool value) async {
    _isLoggedIn = value;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', value);
    notifyListeners();
  }

  Future<void> setUserData(userdata) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('user_data', jsonEncode(userdata));
  }

  Future<void> setUsername(String userName) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name',userName );
  }

  Future<String?> getUserName() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('user_name');
}


Future<void> setUserID(int userID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('user_id',userID );
  }

  Future<int?> getUserID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getInt('user_id');
}


  Future<List<dynamic>?> getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      List<dynamic> userData = jsonDecode(userDataString);
      return userData;
    }
    return null;
  }

  

  InputDecoration textFielWithIcondDecoration({required String placeholder}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintText: placeholder,
      fillColor: ConstantColors.inputColor,
      filled: true,
      suffixIcon: const Icon(Icons.calendar_today),
      hintStyle: GoogleFonts.nunito(
        color: ConstantColors.mainlyTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration textFieldTimeIcondDecoration({required String placeholder}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintText: placeholder,
      fillColor: ConstantColors.inputColor,
      filled: true,
      suffixIcon: const Icon(Icons.access_time_outlined),
      hintStyle: GoogleFonts.nunito(
        color: ConstantColors.mainlyTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  InputDecoration textFieldDecoration({required String placeholder}) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(
          width: 0,
          style: BorderStyle.none,
        ),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      hintText: placeholder,
      fillColor: ConstantColors.inputColor,
      filled: true,
      hintStyle: GoogleFonts.nunito(
        color: ConstantColors.mainlyTextColor,
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
