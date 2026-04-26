import 'package:flutter/material.dart';
import 'package:frontend/widget/profile_avatar_widget.dart';

class UserAvatarWidget extends StatelessWidget {
  const UserAvatarWidget({
    super.key,
    required this.initials,
    required this.backgroundColor,
    required this.radius,
    this.profilePicUrl,
    this.isGroup = false,
  });

  final String initials;
  final Color backgroundColor;
  final double radius;
  final String? profilePicUrl;
  final bool isGroup;

  @override
  Widget build(BuildContext context) {
    final fallback = ProfileAvatarWidget(
      initials: initials,
      backgroundColor: backgroundColor,
      radius: radius,
      isGroup: isGroup,
      profilePicUrl: '',
    );

    if (profilePicUrl == null || profilePicUrl!.isEmpty) {
      return fallback;
    }

    return ClipOval(
      child: SizedBox(
        width: radius * 2,
        height: radius * 2,
        child: Image.network(
          profilePicUrl!,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => fallback,
        ),
      ),
    );
  }
}
