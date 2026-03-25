import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/core/constant/app_style.dart';

class AppButton extends StatelessWidget {
  final Color textColor;
  final Color backgroundColor;
  final String label;
  final VoidCallback onTap;
  const AppButton({
    super.key,
    this.textColor = AppColors.white,
    required this.backgroundColor,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 47,
        width: MediaQuery.sizeOf(context).width,

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: backgroundColor,
        ),

        child: Center(
          child: Text(
            label,
            style: AppStyle.carosBoldStyle(context).copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
