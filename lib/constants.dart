import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';
import 'package:wghsoga_app/Auth/SignIn/sign_in_screen.dart';

const wesPrimary = Color(0xffF47D7B);
const wesYellow = Color(0xffF0EC04);
const wesGreen = Color(0xff007256);
const wesWhite = Color(0xffffffff);

const bodyText1 = Color(0xffffffff);
const bodyText2 = Color(0xffffffff);

//const hostName = "http://192.168.43.121:8000";
const hostName = "http://92.112.194.239:6060";

Future<void> logout(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Remove all user-related data
  await prefs.remove("API_Key");
  await prefs.remove("USER_ID");
  await prefs.remove("user_photo");

  // Optional: Remove any other relevant data
  // await prefs.remove("other_key");

  // Navigate to the login screen
  Navigator.of(context).pushAndRemoveUntil(
    MaterialPageRoute(builder: (BuildContext context) => SignInScreen()),
    (Route<dynamic> route) => false, // Removes all routes
  );
}

Future<String?> getApiPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("API_Key");
}

Future<String?> getUserIDPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("USER_ID");
}

Future<String?> getUserPhoto() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("user_photo");
}

class PasteTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow pasting of text by returning the new value unchanged
    return newValue;
  }
}

Future<bool> saveIDApiKey(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("API_Key", apiKey);
  return prefs.commit();
}

Future<bool> saveUserID(String apiKey) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("USER_ID", apiKey);
  return prefs.commit();
}

Future<void> saveUserData(Map<String, dynamic> userData) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_data', json.encode(userData));
}

Future<void> saveUserPhoto(String userPhoto) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('user_photo', json.encode(userPhoto));
}
