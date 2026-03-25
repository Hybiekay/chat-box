import 'package:flutter/material.dart';
import 'package:frontend/core/theme/app_theme_colors.dart';

extension BuildContextExt on BuildContext {
  bool get isDarkMode => Theme.brightnessOf(this) == Brightness.dark;
  ThemeData get theme => Theme.of(this);
  AppThemeColors get palette => Theme.of(this).extension<AppThemeColors>()!;
}
