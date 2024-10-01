import 'package:flutter/material.dart';
import 'package:mechinetest/shared/themes/font_palette.dart';

import '../constants/colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: primaryColor,
    ),
    useMaterial3: true,
    visualDensity: VisualDensity.adaptivePlatformDensity,
    brightness: Brightness.light,
    scaffoldBackgroundColor: kWhite,
    appBarTheme: AppBarTheme(
      backgroundColor: kWhite,
      surfaceTintColor: Colors.transparent,
      titleTextStyle: FontPalette.urbenist18.copyWith(
        color: kBlack,
      ),
      iconTheme: const IconThemeData(
        color: kWhite,
      ),
    ),
    canvasColor: kColorBorder2,
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: kPrimaryColor1,
    //   unselectedItemColor: kPrimaryColor.withOpacity(0.4),
    //   selectedItemColor: kPrimaryColor,
    // ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: kWhite,
      labelStyle: TextStyle(
        color: kBlack.withOpacity(0.8),
      ),
      errorStyle: const TextStyle(color: kRedColor),
      errorMaxLines: 5,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: kColorBorder2,
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: kRedColor,
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: primaryColor,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          style: BorderStyle.solid,
          color: primaryColor,
        ),
      ),
    ),
    textTheme: FontPalette.textLightTheme,
    primaryTextTheme: FontPalette.textLightTheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.all<Color>(primaryColor),
        foregroundColor: WidgetStateProperty.all<Color>(kWhite),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            // side: BorderSide(color: Colors.red),
          ),
        ),
      ),
    ),
    fontFamily: FontPalette.themeFont,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: kWhite,
    ),
  );
}
