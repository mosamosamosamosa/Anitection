
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StrollRepository {
  Future<void> create({required int animalId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    prefs.setString("stroll-animal-$animalId", now.toString());
  }

  Future<bool> isStrolled({required int animalId}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final now = DateTime.now();
    final lastStroll = prefs.getString("stroll-animal-$animalId");
    if (lastStroll == null) {
      return false;
    }
    final lastStrollDateTime = DateTime.parse(lastStroll);
    final diff = now.difference(lastStrollDateTime);
    return diff.inSeconds < 30;
  }

  Future<void> delete({required int animalId}) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.remove("stroll-animal-$animalId");
  }

  Stream<bool> isStrolledStream({required int animalId}) async* {
    while (true) {
      yield await isStrolled(animalId: animalId);
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

final strollRepositoryProvider = Provider((ref) => StrollRepository());
