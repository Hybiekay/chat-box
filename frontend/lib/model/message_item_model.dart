import 'package:flutter/material.dart';

class MessageItemModel {
  const MessageItemModel({
    required this.name,
    required this.message,
    required this.time,
    required this.initials,
    required this.avatarColor,
    required this.statusColor,
    this.profilePicUrl,
    this.userId,
    this.unreadCount = 0,
    this.isGroup = false,
  });

  final String name;
  final String message;
  final String time;
  final String initials;
  final Color avatarColor;
  final Color statusColor;
  final String? profilePicUrl;
  final String? userId;
  final int unreadCount;
  final bool isGroup;

  MessageItemModel copyWith({
    String? name,
    String? message,
    String? time,
    String? initials,
    Color? avatarColor,
    Color? statusColor,
    String? profilePicUrl,
    String? userId,
    int? unreadCount,
    bool? isGroup,
  }) {
    return MessageItemModel(
      name: name ?? this.name,
      message: message ?? this.message,
      time: time ?? this.time,
      initials: initials ?? this.initials,
      avatarColor: avatarColor ?? this.avatarColor,
      statusColor: statusColor ?? this.statusColor,
      profilePicUrl: profilePicUrl ?? this.profilePicUrl,
      userId: userId ?? this.userId,
      unreadCount: unreadCount ?? this.unreadCount,
      isGroup: isGroup ?? this.isGroup,
    );
  }
}
