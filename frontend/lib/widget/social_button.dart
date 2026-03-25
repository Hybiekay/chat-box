import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/widget/image_widget.dart';

class SocialBotton extends StatelessWidget {
  final String iconPath;
  final Color boderColor;
  final Color? color;
  const SocialBotton({
    super.key,
    required this.iconPath,
    this.boderColor = AppColors.white,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(13),
      decoration: BoxDecoration(
        border: Border.all(color: boderColor),
        shape: BoxShape.circle,
      ),

      child: ImageWidget(iconPath, color: color),
    );
  }
}
