import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mechinetest/shared/consrants/colors.dart';


class FontPalette {
  static const themeFont = "Urbanist";

  static TextTheme get textLightTheme {
    return Typography.englishLike2018.apply(
        fontSizeFactor: 0.8.sp,
        bodyColor: kPrimaryColor,
        fontFamily: FontPalette.themeFont);
  }

  static TextStyle urbenist8 = TextStyle(
    fontSize: 8.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 9.6.h,
  );
  static TextStyle urbenist10 = TextStyle(
    fontSize: 10.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 12.h,
  );
  static TextStyle urbenist12 = TextStyle(
    fontSize: 12.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 14.4.h,
  );
  static TextStyle urbenist14 = TextStyle(
    fontSize: 14.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 16.8.h,
  );
  static TextStyle urbenist16 = TextStyle(
    fontSize: 16.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 19.2.h,
  );
  static TextStyle urbenist18 = TextStyle(
    fontSize: 18.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 21.6.h,
  );
  static TextStyle urbenist20 = TextStyle(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 24.6.h,
  );
  static TextStyle urbenist24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 28.8.h,
  );
  static TextStyle urbenist30 = TextStyle(
    fontSize: 30.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 36.h,
  );
  static TextStyle urbenist34 = TextStyle(
    fontSize: 34.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 40.8.h,
  );
  static TextStyle urbenist38 = TextStyle(
    fontSize: 38.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 45.6.h,
  );
  static TextStyle urbenist42 = TextStyle(
    fontSize: 42.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: 0,
    // height: 50.4.h,
  );
}
