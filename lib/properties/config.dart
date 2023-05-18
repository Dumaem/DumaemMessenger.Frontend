import 'package:flutter/material.dart';

import '../main.dart';

const double fontSizeForTitle = 30;
const double fontSizeForHyperText = 15;
const double baseBorderRadius = 8;
const double smallBorderRadius = 2;
const double chatCircleAvatarRadius = 12;
const double primaryCircleAvatarRadius = 30;
const double secondaryCircleAvatarRadius = 25;
const double bigChatCircleAvatarRadius = 50;
const double chatTextFontSize = 12;
const double authenticationPageWidgetWidth = 0.7;
const double textPadding = 25;
bool isLightTheme = true;
const IconData lightIcon = Icons.wb_sunny;
const IconData darkIcon = Icons.nights_stay;

final ThemeData lightTheme = ThemeData(
  primarySwatch: buildMaterialColor(const Color.fromARGB(255, 190, 233, 244)),
  primaryColor: const Color.fromARGB(255, 133, 194, 210),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 190, 233, 244),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 129, 169, 226),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.black),
    titleLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.black, fontSize: 15),
    bodySmall: TextStyle(color: Colors.black),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle()),
  brightness: Brightness.light,
);

final ThemeData darkTheme = ThemeData(
  primarySwatch: buildMaterialColor(const Color.fromARGB(255, 1, 24, 30)),
  primaryColor: Color.fromARGB(255, 4, 44, 54),
  appBarTheme: const AppBarTheme(
    color: Color.fromARGB(255, 2, 90, 112),
  ),
  buttonTheme: const ButtonThemeData(
    buttonColor: Color.fromARGB(255, 8, 34, 71),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white, fontSize: 15),
    bodySmall: TextStyle(color: Colors.white),
  ),
  elevatedButtonTheme: const ElevatedButtonThemeData(style: ButtonStyle()),
  brightness: Brightness.dark,
);

const kprimaryColor = Color(0xff212C42);
const ksecondryColor = Color(0xff9CA2FF);
const ksecondryLightColor = Color(0xffEDEFFE);
const klightContentColor = Color(0xffF1F2F7);

const double kbigFontSize = 25;
const double knormalFontSize = 18;
const double ksmallFontSize = 15;
