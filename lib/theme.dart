import 'package:flutter/material.dart';
import 'package:wghsoga_app/constants.dart';


ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: wesGreen,
    fontFamily: 'Montserrat',
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}


TextTheme textTheme() {
  return const TextTheme(
    bodyLarge: TextStyle(color: wesWhite),
    bodyMedium: TextStyle(color: wesWhite),
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: wesGreen
      ,
    elevation: 0
  );
}