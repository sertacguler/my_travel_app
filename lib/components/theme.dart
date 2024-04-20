import 'package:flutter/material.dart';

class AppColors {
  static const navyBlue = Color(0xFF14213D);
  static const orange = Color(0xFFFCA311);
  static const lightLightGrey = Color(0xFFFAFAFA);
  static const lightGreyNew = Color(0xFFEEEEEE);
  static const lightGrey = Color(0xFFE5E5E5);
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static const red = Color(0xffc90000);
  static const green = Color(0xff03b126);
}

ThemeData buildAppTheme() {
  return ThemeData(
    primaryColor: AppColors.navyBlue,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: AppColors.orange,
    ),
    scaffoldBackgroundColor: AppColors.white,
    textTheme: TextTheme(
      bodyText1: TextStyle(color: AppColors.black),
      bodyText2: TextStyle(color: AppColors.black),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide.none,
      ),
      filled: true,
      fillColor: AppColors.lightGrey,
    ),
    buttonTheme: ButtonThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      buttonColor: AppColors.orange,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}
