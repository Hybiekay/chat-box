import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constant/app_images.dart';
import 'package:frontend/core/constant/app_style.dart';
import 'package:frontend/core/extention/build_context_ext.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/model/message_item_model.dart';
import 'package:frontend/model/status_item_model.dart';
import 'package:frontend/model/story_item_model.dart';
import 'package:frontend/provider/status_provider.dart';
import 'package:frontend/screens/home/chat_detail.dart';
import 'package:frontend/screens/home/status_preview.dart';
import 'package:frontend/screens/home/upload_status.dart';
import 'package:frontend/widget/circle_icon_button_widget.dart';
import 'package:frontend/widget/message_tile_widget.dart';
import 'package:frontend/widget/profile_avatar_widget.dart';
import 'package:frontend/widget/story_avatar_widget.dart';

const _myStory = StoryItemModel(
  name: 'My status',
  initials: 'ME',
  backgroundColor: Color(0xFFD9E8E5),
  ringColor: Color(0xFF5CB6AA),
  isMine: true,
);

List<StoryItemModel> storys = [
  StoryItemModel(
    name: 'Mayowa',
    initials: 'ME',
    backgroundColor: Color(0xFFD9E8E5),
    ringColor: Color(0xFF5CB6AA),
    isMine: false,
  ),
  StoryItemModel(
    name: 'Demola',
    initials: 'ME',
    backgroundColor: Color(0xFFD9E8E5),
    ringColor: Color(0xFF5CB6AA),
    isMine: false,
  ),
  StoryItemModel(
    name: 'Love',
    initials: 'ME',
    backgroundColor: Color(0xFFD9E8E5),
    ringColor: Color(0xFF5CB6AA),
    isMine: false,
  ),
];
const _messages = [
  MessageItemModel(
    name: 'Alex Linderson',
    message: 'How are you today?',
    time: '2 min ago',
    initials: 'AL',
    avatarColor: Color(0xFFD8E0E8),
    statusColor: Color(0xFF1EDB76),
    profilePicUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
    unreadCount: 3,
  ),
  MessageItemModel(
    name: 'Team Align',
    message: "Don't miss to attend the meeting.",
    time: '2 min ago',
    initials: 'TA',
    avatarColor: Color(0xFF63B2F5),
    statusColor: Color(0xFF1EDB76),
    unreadCount: 4,
    isGroup: true,
  ),
  MessageItemModel(
    name: 'John Ahraham',
    message: 'Hey! Can you join the meeting?',
    time: '2 min ago',
    initials: 'JA',
    avatarColor: Color(0xFFFFC94D),
    statusColor: Color(0xFFBEC4C3),
    profilePicUrl:
        'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?auto=format&fit=crop&w=600&q=80',
  ),
  MessageItemModel(
    name: 'Sabila Sayma',
    message: 'How are you today?',
    time: '2 min ago',
    initials: 'SS',
    avatarColor: Color(0xFFF6B6C1),
    statusColor: Color(0xFFBEC4C3),
  ),
  MessageItemModel(
    name: 'John Borino',
    message: 'Have a good day',
    time: '2 min ago',
    initials: 'JB',
    avatarColor: Color(0xFFE0D9D3),
    statusColor: Color(0xFF1EDB76),
  ),
  MessageItemModel(
    name: 'Amanda Robin',
    message: 'I sent the updated files already.',
    time: '8 min ago',
    initials: 'AR',
    avatarColor: Color(0xFFEAD9EE),
    statusColor: Color(0xFFBEC4C3),
  ),
];

class MessageScreen extends ConsumerStatefulWidget {
  const MessageScreen({super.key});

  @override
  ConsumerState<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends ConsumerState<MessageScreen> {
  static const _storyPalette = [
    Color(0xFFFFC94D),
    Color(0xFFF6B6C1),
    Color(0xFFDCE7F8),
    Color(0xFFE2D7CB),
    Color(0xFFD7E0F4),
  ];

  Future<void> _openUploadStatus() async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const UploadStatusScreen()),
    );
    if (mounted) {
      await ref.read(statusProvider.notifier).fetchStatuses();
    }
  }

  Future<void> _openChat(MessageItemModel message) async {
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => ChatDetailScreen(contact: message)),
    );
  }

  List<StoryItemModel> _buildStatusStories(List<StatusItemModel> statuses) {
    final uniqueStatuses = <String, StatusItemModel>{};
    for (final status in statuses) {
      uniqueStatuses.putIfAbsent(status.userId, () => status);
    }

    var index = 0;
    return uniqueStatuses.values.map((status) {
      final parts = status.userName
          .trim()
          .split(RegExp(r'\s+'))
          .where((part) => part.isNotEmpty)
          .toList();
      final initials = parts
          .take(2)
          .map((part) => part[0].toUpperCase())
          .join();
      final color = _storyPalette[index % _storyPalette.length];
      index++;

      return StoryItemModel(
        name: status.userName,
        initials: initials.isEmpty ? 'U' : initials,
        backgroundColor: color,
        ringColor: color,
        profilePicUrl: status.userProfilePicUrl,
        userId: status.userId,
      );
    }).toList();
  }

  Future<void> _openStatusPreview(StoryItemModel story) async {
    if (story.userId == null) {
      return;
    }

    final statuses = await ref
        .read(statusProvider.notifier)
        .fetchStatusesByUser(story.userId!);

    if (!mounted || statuses.isEmpty) {
      return;
    }

    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => StatusPreviewScreen(
          userName: story.name,
          userInitials: story.initials,
          userProfilePicUrl: story.profilePicUrl ?? '',
          statuses: statuses,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final statusesState = ref.watch(statusProvider);

    return DecoratedBox(
      decoration: BoxDecoration(color: context.palette.headerBackground),
      child: SafeArea(
        bottom: false,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 8),
              child: Row(
                children: [
                  CircleIconButtonWidget(
                    icon: AppImages.search,
                    borderColor: context.palette.searchBorder,
                  ),
                  Expanded(
                    child: Text(
                      'Home',
                      textAlign: TextAlign.center,
                      style: AppStyle.circularTextStyle(
                        size: 28,
                        weight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const ProfileAvatarWidget(
                    initials: 'AM',
                    backgroundColor: Color(0xFFC8C5F7),
                    radius: 28,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 168,
              child: statusesState.when(
                data: (statuses) {
                  // final stories = [_myStory, ..._buildStatusStories(statuses)];
                  final stories = [_myStory, ...storys];
                  return ListView.separated(
                    padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final story = stories[index];
                      return StoryAvatarWidget(
                        item: story,
                        onTap: story.isMine
                            ? _openUploadStatus
                            : () => _openStatusPreview(story),
                        onAddTap: story.isMine ? _openUploadStatus : null,
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(width: 20),
                    itemCount: stories.length,
                  );
                },
                loading: () => ListView(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                  scrollDirection: Axis.horizontal,
                  children: [
                    StoryAvatarWidget(
                      item: _myStory,
                      onTap: _openUploadStatus,
                      onAddTap: _openUploadStatus,
                    ),
                  ],
                ),
                error: (error, stackTrace) => ListView(
                  padding: const EdgeInsets.fromLTRB(24, 18, 24, 18),
                  scrollDirection: Axis.horizontal,
                  children: [
                    StoryAvatarWidget(
                      item: _myStory,
                      onTap: _openUploadStatus,
                      onAddTap: _openUploadStatus,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: context.palette.messageSheet,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(42),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(
                        alpha: context.isDarkMode ? 0.18 : 0.08,
                      ),
                      blurRadius: 28,
                      offset: const Offset(0, -8),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 14, bottom: 8),
                      width: 76,
                      height: 6,
                      decoration: BoxDecoration(
                        color: context.palette.handle,
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.fromLTRB(24, 22, 24, 28),
                        itemBuilder: (context, index) {
                          final message = _messages[index];
                          return MessageTileWidget(
                            item: message,
                            onTap: () => _openChat(message),
                          );
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 28),
                        itemCount: _messages.length,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
