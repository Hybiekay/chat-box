import 'package:flutter/material.dart';
import 'package:frontend/core/constant/app_style.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/model/message_item_model.dart';
import 'package:frontend/widget/user_avatar_widget.dart';

class MessageTileWidget extends StatelessWidget {
  const MessageTileWidget({super.key, required this.item, this.onTap});

  final MessageItemModel item;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final palette = theme.extension<AppThemeColors>()!;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  UserAvatarWidget(
                    initials: item.initials,
                    backgroundColor: item.avatarColor,
                    radius: 31,
                    profilePicUrl: item.profilePicUrl,
                    isGroup: item.isGroup,
                  ),
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: item.statusColor == const Color(0xFF1EDB76)
                            ? palette.online
                            : palette.offline,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: palette.messageSheet,
                          width: 2.4,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.name,
                      style: AppStyle.circularTextStyle(
                        size: 21,
                        weight: FontWeight.w700,
                        color: colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      item.message,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppStyle.circularTextStyle(
                        size: 15,
                        weight: FontWeight.w500,
                        color: palette.secondaryText,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    item.time,
                    style: AppStyle.circularTextStyle(
                      size: 14,
                      weight: FontWeight.w500,
                      color: palette.secondaryText,
                    ),
                  ),
                  const SizedBox(height: 12),
                  if (item.unreadCount > 0)
                    Container(
                      width: 34,
                      height: 34,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: palette.badge,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${item.unreadCount}',
                        style: AppStyle.circularTextStyle(
                          size: 17,
                          weight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
