import 'dart:developer';

import 'package:anitection/models/animal/favorite/favorite.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/auth_controller.dart';
import 'package:anitection/providers/client.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class FavoriteAnimalsController extends AsyncNotifier<List<Model<FavoriteAttributes>>> {
  @override
  FutureOr<List<Model<FavoriteAttributes>>> build() {
    return _fetchFavoriteAnimals();
  }

  Future<List<Model<FavoriteAttributes>>> _fetchFavoriteAnimals() async {
    try {
      final favoriteAnimals = await ref.read(anitectionClientProvider).getFavorites(null);
      return favoriteAnimals.data;
    } catch(e) {
      rethrow;
    }
  }

  Future<void> createFavorite({required int animalId}) async {
    try {
      final userId = ref.read(authControllerProvider.notifier).state.valueOrNull?.id;
      await ref.read(anitectionClientProvider).createFavorite({
        "data": {
          "animal": animalId,
          "user": userId,
        }
      });
      state = await AsyncValue.guard(() => _fetchFavoriteAnimals());
    } catch(e) {

      log("お気に入り登録失敗", error: e);
      rethrow;
    }
  }
}

final favoriteAnimalsControllerProvider = AsyncNotifierProvider<FavoriteAnimalsController, List<Model<FavoriteAttributes>>>(() => FavoriteAnimalsController());