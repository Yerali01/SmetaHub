import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTypography {
  const AppTypography._();

  static const String _sfProDisplay = '';
  static const String _sf = '';

  // Headers ----------------------------------------------------------------

  static final TextStyle h1 = TextStyle(
    fontFamily: _sf,
    fontSize: 48.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static final TextStyle h232 = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 32.sp,
    height: 36.sp / 32.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static final TextStyle h3Bold = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 24.sp,
    height: 28.sp / 24.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static final TextStyle h3Medium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 24.sp,
    height: 28.sp / 24.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static final TextStyle h4Bold = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 20.sp,
    height: 24.sp / 20.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );
  static final TextStyle h4Medium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 20.sp,
    height: 24.sp / 20.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );

  static final TextStyle h5Bold = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 18.sp,
    height: 20.sp / 18.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );

  static final TextStyle h5Medium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 18.sp,
    height: 20.sp / 18.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle h5Regular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 18.sp,
    height: 20.sp / 18.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  // Headlines ----------------------------------------------------------------

  static final TextStyle headlineBold = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 16.sp,
    height: 18.sp / 16.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );
  static final TextStyle headlineMedium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 16.sp,
    height: 18.sp / 16.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle headlineRegular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 16.sp,
    height: 18.sp / 16.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  // Subheads ----------------------------------------------------------------

  static final TextStyle subheadsBold = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 14.sp,
    height: 16.sp / 14.sp,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.none,
  );
  static final TextStyle subheadsMedium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 14.sp,
    height: 16.sp / 14.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle subheadsRegular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 14.sp,
    height: 16.sp / 14.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  // Body ----------------------------------------------------------------

  static final TextStyle bodyMedium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 15.sp,
    height: 18.sp / 15.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle bodyRegular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 15.sp,
    height: 18.sp / 15.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  // Captions ----------------------------------------------------------------

  static final TextStyle caption1Medium = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 12.sp,
    height: 14.sp / 12.sp,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
  );
  static final TextStyle caption1Regular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 12.sp,
    height: 14.sp / 12.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
  static final TextStyle caption2Regular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 11.sp,
    height: 14.sp / 11.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
  static final TextStyle caption3Regular = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 10.sp,
    height: 14.sp / 10.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );

  static final TextStyle sfPDW40015 = TextStyle(
    fontFamily: _sfProDisplay,
    fontSize: 15.sp,
    height: 20.sp / 15.sp,
    fontWeight: FontWeight.w400,
    decoration: TextDecoration.none,
  );
}
