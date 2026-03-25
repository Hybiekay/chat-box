import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/provider/auth_provider.dart';

class SplashProvider {
  SplashProvider(this.ref);

  final Ref ref;

  Future<String> getInitialRoute() async {
    await Future.delayed(const Duration(seconds: 1));

    try {
      print("getInitialRoute");
      final user = await ref.read(authProvider.future);
      print("this is user $user");
      return user == null ? 'onboarding' : 'home';
    } catch (error) {
      print("this is error $error");

      return 'onboarding';
    }
  }
}

final splashProvider = Provider((ref) => SplashProvider(ref));
