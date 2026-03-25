import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/core/constant/app_style.dart';

class AuthFormField extends StatelessWidget {
  final String label;
  final TextEditingController? controller;
  const AuthFormField({super.key, required this.label, this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          label,
          style: AppStyle.circularMediumStyle.copyWith(
            fontSize: 18,
            color: AppColors.primary,
          ),
        ),
        TextFormField(controller: controller),
      ],
    );
  }
}
