import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:machine_test_lilac/shared/utils/constants.dart';

class AppTheme {
  // Define heading text style
  static TextStyle headingLarge(Color? color) {
    return GoogleFonts.poppins(
      fontSize: 28.sp, // Ensure this is defined as a constant
      color: color ?? lightTextColor,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle headingText(Color? color) {
    return GoogleFonts.poppins(
      fontSize: mediumHeadingFont, // Ensure this is defined as a constant
      color: color ?? lightTextColor,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle titleText(Color color) {
    return GoogleFonts.jost(
      fontSize: titleFont, // Ensure this is defined as a constant
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle mediumTitleText(Color color) {
    return GoogleFonts.poppins(
      fontSize: mediumTitleFont, // Ensure this is defined as a constant
      color: color,
      fontWeight: FontWeight.w600,
    );
  }

  static TextStyle bodyText(Color color) {
    return GoogleFonts.poppins(
      fontSize: mediumSmallFont, // Ensure this is defined as a constant
      color: color,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle smallText(Color color) {
    return GoogleFonts.poppins(
      fontSize: smallTextFont, // Ensure this is defined as a constant
      color: color,
      fontWeight: FontWeight.w400,
    );
  }
}