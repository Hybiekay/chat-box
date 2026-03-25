import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/core/extention/build_context_ext.dart';

class AppStyle {
  static TextStyle circularTextStyle({
    double size = 16,
    FontWeight weight = FontWeight.w500,
    Color? color,
    double? height,
  }) {
    return TextStyle(
      fontFamily: 'circular',
      fontSize: size,
      fontWeight: weight,
      color: color,
      height: height,
    );
  }

  static TextStyle circularMediumStyle = TextStyle(
    fontFamily: 'circular',
    fontSize: 22,
  );

  static TextStyle circularSmallStyle = TextStyle(
    fontFamily: 'circular',
    fontSize: 16,
    color: AppColors.textColor,
  );

  static TextStyle carosLargeStyle = TextStyle(
    fontFamily: 'caros',
    fontSize: 55,
    color: AppColors.white,
    fontWeight: FontWeight.w800,
  );

  static TextStyle carosBoldStyle(BuildContext context) => TextStyle(
    fontFamily: 'caros',
    fontSize: 18,
    color: context.isDarkMode ? AppColors.white : AppColors.black,
    fontWeight: FontWeight.w600,
  );
}
