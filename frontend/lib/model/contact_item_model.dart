import 'package:flutter/material.dart';

class ContactItemModel {
  const ContactItemModel({
    required this.name,
    required this.tagline,
    required this.initials,
    required this.avatarColor,
    this.profilePicUrl,
    this.userId,
  });

  final String name;
  final String tagline;
  final String initials;
  final Color avatarColor;
  final String? profilePicUrl;
  final String? userId;
}
