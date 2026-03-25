import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_style.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/model/contact_item_model.dart';
import 'package:frontend/widget/user_avatar_widget.dart';

class ContactTileWidget extends StatelessWidget {
  const ContactTileWidget({super.key, required this.contact, this.onTap});

  final ContactItemModel contact;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final palette = Theme.of(context).extension<AppThemeColors>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            children: [
              UserAvatarWidget(
                initials: contact.initials,
                backgroundColor: contact.avatarColor,
                radius: 32,
                profilePicUrl: contact.profilePicUrl,
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contact.name,
                      style: AppStyle.circularTextStyle(
                        size: 21,
                        weight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      contact.tagline,
                      style: AppStyle.circularTextStyle(
                        size: 15,
                        weight: FontWeight.w500,
                        color: palette.secondaryText,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
