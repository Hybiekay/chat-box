import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_colors.dart';
import 'package:frontend/core/constant/app_style.dart';

class OrDivideWidget extends StatelessWidget {
  final Color dividerColor;
  final Color textColor;
  const OrDivideWidget({
    super.key,
    this.dividerColor = AppColors.white,
    this.textColor = AppColors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Divider(color: dividerColor)),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Or',
            style: AppStyle.circularMediumStyle.copyWith(
              color: textColor,
              fontSize: 18,
            ),
          ),
        ),
        Expanded(child: Divider(color: dividerColor)),
      ],
    );
  }
}
