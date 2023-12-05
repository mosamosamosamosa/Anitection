

import 'package:anitection/models/user/user.dart';
import 'package:anitection/providers/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthController extends AsyncNotifier<User> {
  @override
  FutureOr<User> build() {
    return ref.read(anitectionClientProvider).me();
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard<User>(() async {
      final result = await ref.read(anitectionClientProvider).login({
        "identifier": email,
        "password": password,
      });
      return result.user;
    });
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(anitectionClientProvider).register({
        "email": email,
        "password": password,
      });
      return result.user;
    });
  }
}


final authControllerProvider = AsyncNotifierProvider<AuthController, User>(() => AuthController());