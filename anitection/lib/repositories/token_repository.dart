
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TokenRepository {

  Future<void> save({required String? token}) async {
    (await SharedPreferences.getInstance()).setString("TOKEN", token ?? "");
  }

  Future<String?> get() async {
    return (await SharedPreferences.getInstance()).getString("TOKEN");
  }
}

final tokenRepositoryProvider = Provider((ref) => TokenRepository());