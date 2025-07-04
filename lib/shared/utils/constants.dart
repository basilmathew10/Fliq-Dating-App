import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const buttonColor = Color(0XFFE6446E);
const buttonTextColor = Colors.white;
const backGroundColor = Colors.white;
const borderColor = Colors.grey;
const cardColor = Colors.white;

LinearGradient primaryCardColor = const LinearGradient(
  colors: [
    Color(0xFFFF80A1), // Pink
    Color(0xFFE6446E), // Darker pink
  ],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);
LinearGradient secondaryCardColor =
    const LinearGradient(colors: [Color(0xff5AB2C8), Color(0xffDDFF8F)]);

// ligtTheme
const lightTextColor = Colors.white;
const greyTextColor = Colors.grey;
const greyCardColor = Color.fromARGB(255, 232, 230, 237);
const lightScaffoldBackground = Colors.white;
const lightAppBackgroundColor = Colors.white;
const lightCardColor = Colors.white;
const lightContainerColor = Colors.white;

// darkTheme
const darkTextColor = Colors.black;
const darkCardColor = Colors.black;
const darkScaffoldBackground = Colors.black;
const darkAppBackgroundColor = Colors.black;
const darkContainerColor = Color.fromARGB(255, 38, 38, 38);

// fontsize - Convert to getter functions to ensure ScreenUtil is initialized
double get headingFont => 25.sp;
double get mediumHeadingFont => 18.sp;
double get titleFont => 26.sp;
double get bodyMediumTitleFont => 14.sp;
double get mediumTitleFont => 12.sp;
double get mediumSmallFont => 13.sp;
double get smallTextFont => 12.sp;

// fontWeight
FontWeight titleFontWeight = FontWeight.bold;
FontWeight normalFontWeight = FontWeight.normal;

// radius
double get borderRadius => 10.r;
