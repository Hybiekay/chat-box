import 'package:flutter/material.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    super.key,
    required this.initials,
    required this.backgroundColor,
    required this.radius,
    required this.profilePicUrl,

    this.isGroup = false,
  });

  final String initials;
  final Color backgroundColor;
  final double radius;
  final dynamic profilePicUrl;

  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextStyle(
      fontFamily: 'circular',
      fontSize: isGroup ? radius * 0.42 : radius * 0.46,
      fontWeight: FontWeight.w700,
      color: const Color(0xFF13211F),
    );

    return Container(
      width: radius * 2,
      height: radius * 2,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      alignment: Alignment.center,
      child: isGroup
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(initials.substring(0, 1), style: textStyle),
                Text(
                  initials.substring(1),
                  style: textStyle.copyWith(fontSize: radius * 0.34),
                ),
              ],
            )
          : Text(initials, style: textStyle),
    );
  }
}
