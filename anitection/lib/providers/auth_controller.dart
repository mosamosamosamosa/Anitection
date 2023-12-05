

import 'dart:developer';

import 'package:anitection/models/user/user.dart';
import 'package:anitection/providers/client.dart';
import 'package:anitection/repositories/token_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class AuthController extends AsyncNotifier<User> {
  @override
  FutureOr<User> build() {
    return _fetchUser();
  }

  Future<void> signIn({required String email, required String password}) async {
    state = const AsyncValue.loading();

    final result = await ref.read(anitectionClientProvider).login({
      "identifier": email,
      "password": password,
    });
    await ref.read(tokenRepositoryProvider).save(token: result.jwt);
    state = await AsyncValue.guard(() => _fetchUser());
  }

  Future<void> signUp({required String email, required String password}) async {
    state = const AsyncValue.loading();

    final result = await ref.read(anitectionClientProvider).register({
      "email": email,
      "username": email,
      "password": password,
    });
    await ref.read(tokenRepositoryProvider).save(token: result.jwt);
    state = await AsyncValue.guard(() => _fetchUser());
  }

  Future<User> _fetchUser() async {
    try {
      final user = await ref.read(anitectionClientProvider).me();
      return user;
    } catch(e) {
      log("ユーザ取得失敗", error: e);
      rethrow;
    }
  }
}


final authControllerProvider = AsyncNotifierProvider<AuthController, User>(() => AuthController());