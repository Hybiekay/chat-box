import 'package:flint_client/flint_client.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constant/app_images.dart';
import 'package:frontend/core/theme/theme.dart';
import 'package:frontend/provider/home_provider.dart';
import 'package:frontend/provider/recent_chat_provider.dart';
import 'package:frontend/repositry/chat_repositry.dart';
import 'package:frontend/screens/home/call.dart';
import 'package:frontend/screens/home/contact.dart';
import 'package:frontend/screens/home/message.dart';
import 'package:frontend/screens/home/settings.dart';
import 'package:frontend/widget/image_widget.dart';

final List<Widget> listWidget = [
  const MessageScreen(),
  const CallScreen(),
  const ContactScreen(),
  const SettingsScreen(),
];

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  FlintWebSocketClient? _socket;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => handShack(ref.read(chatRepositryProvider)));
  }

  @override
  void dispose() {
    _socket?.dispose();
    super.dispose();
  }

  Future handShack(ChatRepositry chatRepository) async {
    _socket = await chatRepository.handShackSocket();

    _socket?.on("messageReceived", (data) {
      debugPrint('chat notification: $data');
      ref.invalidate(recentChatsProvider);
    });

    _socket?.on('chat:error', (dynamic data) {
      debugPrint('chat notification error: $data');
    });

    await _socket?.connect();
  }

  @override
  Widget build(BuildContext context) {
    final homeProviderv = ref.watch(homeIndexProvider);
    final palette = Theme.of(context).extension<AppThemeColors>()!;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: listWidget[homeProviderv],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: homeProviderv,
        backgroundColor: Theme.of(
          context,
        ).bottomNavigationBarTheme.backgroundColor,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: palette.inactiveIcon,
        onTap: (index) {
          ref.read(homeIndexProvider.notifier).changeIndex(index);
        },
        items: [
          BottomNavigationBarItem(
            icon: ImageWidget(
              AppImages.homeMessage,
              color: homeProviderv == 0
                  ? colorScheme.primary
                  : palette.inactiveIcon,
            ),
            label: "Message",
          ),
          BottomNavigationBarItem(
            icon: ImageWidget(
              AppImages.call,
              color: homeProviderv == 1
                  ? colorScheme.primary
                  : palette.inactiveIcon,
            ),
            label: "Calls",
          ),
          BottomNavigationBarItem(
            icon: ImageWidget(
              AppImages.contact,
              color: homeProviderv == 2
                  ? colorScheme.primary
                  : palette.inactiveIcon,
            ),
            label: "Contacts",
          ),
          BottomNavigationBarItem(
            icon: ImageWidget(
              AppImages.settings,
              color: homeProviderv == 3
                  ? colorScheme.primary
                  : palette.inactiveIcon,
            ),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
