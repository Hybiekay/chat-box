import 'dart:convert';
import 'package:flutter/material.dart';

class SettingsItemModel {
  final String title;
  final String? subtitle;
  final String imagePath;
  final VoidCallback? onTap;
  final bool isEnabled;

  SettingsItemModel({
    required this.title,
    this.subtitle,
    required this.imagePath,
    this.onTap,
    this.isEnabled = true,
  });

  SettingsItemModel copyWith({
    String? title,
    String? subtitle,
    String? imagePath,
    VoidCallback? onTap,
    bool? isEnabled,
  }) {
    return SettingsItemModel(
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      imagePath: imagePath ?? this.imagePath,
      onTap: onTap ?? this.onTap,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'subtitle': subtitle,
      'imagePath': imagePath,
      'isEnabled': isEnabled,
    };
  }

  factory SettingsItemModel.fromMap(Map<String, dynamic> map) {
    return SettingsItemModel(
      title: map['title'],
      subtitle: map['subtitle'],
      imagePath: map['imagePath'],
      isEnabled: map['isEnabled'] ?? true,
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsItemModel.fromJson(String source) =>
      SettingsItemModel.fromMap(json.decode(source));
}
