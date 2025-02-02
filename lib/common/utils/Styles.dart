import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ui/widget/constants/app_colors.dart';
import 'app_constants.dart';
import 'color_constants.dart';

abstract class Styles {
  static TextStyle textFontSemiBold(
      {Color color = BLACK,
        required double size,
        double letterSpacing = 0}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        //  height: 1,
        letterSpacing: letterSpacing,
        fontFamily: AppConstants.fontFamilyGilroy,
        fontWeight: FontWeight.w600);
  }

  static TextStyle textFontBold(
      {Color color = BLACK,
        required double size,
        double letterSpacing = 0}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        //  height: 1,
        letterSpacing: letterSpacing,
        fontFamily: AppConstants.fontFamilyGilroy,
        fontWeight: FontWeight.w700);
  }

  static TextStyle textFontMedium(
      {Color color = BLACK,
        required double size,
        double letterSpacing = 0,
      }) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        //  height: 1,
        letterSpacing: letterSpacing,
        fontFamily: AppConstants.fontFamilyGilroy,
        fontWeight: FontWeight.w500);
  }

  static TextStyle textFontRegular(
      {Color color = BLACK,
        required double size,
        weight = FontWeight.w400,
        double height = 1.4,
        double letterSpacing = 0}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        height: height,
        letterSpacing: letterSpacing,
        fontFamily: AppConstants.fontFamilyGilroy,
        fontWeight: weight);
  }


  static TextStyle textFontRegularOverFlow(
      {Color color = BLACK,
        required double size,
        weight = FontWeight.w400,
        double height = 1.4,
        double letterSpacing = 0}) {
    return TextStyle(
        color: color,
        fontSize: size.sp,
        height: height,
        letterSpacing: letterSpacing,
        overflow: TextOverflow.ellipsis,
        fontFamily: AppConstants.fontFamilyGilroy,
        fontWeight: weight);
  }

}
