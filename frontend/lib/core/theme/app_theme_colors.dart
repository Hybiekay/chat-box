import 'package:flutter/material.dart';

@immutable
class AppThemeColors extends ThemeExtension<AppThemeColors> {
  const AppThemeColors({
    required this.headerBackground,
    required this.messageSheet,
    required this.secondaryText,
    required this.inactiveIcon,
    required this.badge,
    required this.online,
    required this.offline,
    required this.handle,
    required this.searchBorder,
    required this.storyRingMuted,
  });

  final Color headerBackground;
  final Color messageSheet;
  final Color secondaryText;
  final Color inactiveIcon;
  final Color badge;
  final Color online;
  final Color offline;
  final Color handle;
  final Color searchBorder;
  final Color storyRingMuted;

  @override
  AppThemeColors copyWith({
    Color? headerBackground,
    Color? messageSheet,
    Color? secondaryText,
    Color? inactiveIcon,
    Color? badge,
    Color? online,
    Color? offline,
    Color? handle,
    Color? searchBorder,
    Color? storyRingMuted,
  }) {
    return AppThemeColors(
      headerBackground: headerBackground ?? this.headerBackground,
      messageSheet: messageSheet ?? this.messageSheet,
      secondaryText: secondaryText ?? this.secondaryText,
      inactiveIcon: inactiveIcon ?? this.inactiveIcon,
      badge: badge ?? this.badge,
      online: online ?? this.online,
      offline: offline ?? this.offline,
      handle: handle ?? this.handle,
      searchBorder: searchBorder ?? this.searchBorder,
      storyRingMuted: storyRingMuted ?? this.storyRingMuted,
    );
  }

  @override
  AppThemeColors lerp(ThemeExtension<AppThemeColors>? other, double t) {
    if (other is! AppThemeColors) {
      return this;
    }

    return AppThemeColors(
      headerBackground: Color.lerp(
        headerBackground,
        other.headerBackground,
        t,
      )!,
      messageSheet: Color.lerp(messageSheet, other.messageSheet, t)!,
      secondaryText: Color.lerp(secondaryText, other.secondaryText, t)!,
      inactiveIcon: Color.lerp(inactiveIcon, other.inactiveIcon, t)!,
      badge: Color.lerp(badge, other.badge, t)!,
      online: Color.lerp(online, other.online, t)!,
      offline: Color.lerp(offline, other.offline, t)!,
      handle: Color.lerp(handle, other.handle, t)!,
      searchBorder: Color.lerp(searchBorder, other.searchBorder, t)!,
      storyRingMuted: Color.lerp(storyRingMuted, other.storyRingMuted, t)!,
    );
  }
}
