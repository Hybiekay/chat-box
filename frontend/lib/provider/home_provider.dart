import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/core/constant/app_colors.dart';

class HomeIndexNotifier extends Notifier<int> {
  @override
  build() {
    return 0;
  }

  void changeIndex(int index) {
    state = index;
  }

  bool isIndex(int index) {
    return state == index;
  }

  Color getIndexColor(int index) {
    return state == index ? AppColors.primary : AppColors.grey;
  }
}

final homeIndexProvider = NotifierProvider(HomeIndexNotifier.new);
