import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/provider/theme_provider.dart';

class ThemeSwitch extends ConsumerWidget {
  const ThemeSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: Switch(
        value: ref.watch(themeNotifierProvider) == ThemeMode.dark,
        onChanged: (value) {
          ref.read(themeNotifierProvider.notifier).onChange(value);
        },
      ),
    );
  }
}
