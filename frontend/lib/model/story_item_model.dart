import 'package:flutter/material.dart';

class StoryItemModel {
  const StoryItemModel({
    required this.name,
    required this.initials,
    required this.backgroundColor,
    required this.ringColor,
    this.profilePicUrl,
    this.userId,
    this.isMine = false,
  });

  final String name;
  final String initials;
  final Color backgroundColor;
  final Color ringColor;
  final String? profilePicUrl;
  final String? userId;
  final bool isMine;
}
