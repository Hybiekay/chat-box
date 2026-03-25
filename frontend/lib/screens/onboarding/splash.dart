import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constant/app_images.dart';
import 'package:frontend/core/constant/app_style.dart';
import 'package:frontend/provider/splash_provider.dart';
import 'package:frontend/widget/image_widget.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadInitialRoute();
    });
  }

  Future<void> _loadInitialRoute() async {
    final route = await ref.read(splashProvider).getInitialRoute();

    print(route);
    Navigator.pushReplacementNamed(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          crossAxisAlignment: .center,

          children: [
            ImageWidget(AppImages.logo),
            Text(
              'ChatBox',
              style: AppStyle.circularMediumStyle.copyWith(fontSize: 40),
            ),
          ],
        ),
      ),
    );
  }
}
