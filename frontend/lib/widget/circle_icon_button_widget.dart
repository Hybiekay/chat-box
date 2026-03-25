import 'package:flutter/material.dart';
import 'package:frontend/widget/image_widget.dart';

class CircleIconButtonWidget extends StatelessWidget {
  const CircleIconButtonWidget({
    super.key,
    required this.icon,
    required this.borderColor,
  });

  final String icon;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 1.5),
      ),
      child: Center(
        child: ImageWidget(icon, width: 26, height: 26, color: Colors.white),
      ),
    );
  }
}
