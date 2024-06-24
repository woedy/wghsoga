import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart';

const wesPrimary = Color(0xffF47D7B);
const wesYellow = Color(0xffF0EC04);
const wesGreen = Color(0xff007256);
const wesWhite = Color(0xffffffff);


const bodyText1 = Color(0xffffffff);
const bodyText2 = Color(0xffffffff);

const hostName = "https://api.rentstraight.zuludesks.com/api/";
const hostNameMedia = "https://api.rentstraight.zuludesks.com";




Future<String?> getApiPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("API_Key");
}



Future<String?> getUserIDPref() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString("USER_ID");
}









class PasteTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Allow pasting of text by returning the new value unchanged
    return newValue;
  }
}