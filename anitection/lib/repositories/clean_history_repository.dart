
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CleanHistoryRepository {

  Future<DateTime?> getLastCleanDateTime(int animalId) async {
    final preferences = await SharedPreferences.getInstance();
    final dt = preferences.getString('last_clean_date_time-$animalId');
    if (dt == null) {
      return null;
    }
    return DateTime.parse(dt);
  }

  Future<void> setLastCleanDateTime(int animalId, DateTime dateTime) async {
    final preferences = await SharedPreferences.getInstance();
    await preferences.setString('last_clean_date_time-$animalId', dateTime.toIso8601String());
  }

  Stream<int> getDirtyLevelStream(int animalId) async* {
    while (true) {
      final lastCleanDateTime = await getLastCleanDateTime(animalId);
      final now = DateTime.now();
      yield (lastCleanDateTime == null ? 255 : ((now.difference(lastCleanDateTime).inSeconds / 1).floor())).clamp(0, 255);
      await Future.delayed(const Duration(seconds: 1));
    }
  }

  Future<int> getDirtyLevel(int animalId) async {
    final lastCleanDateTime = await getLastCleanDateTime(animalId);
    final now = DateTime.now();
    return (lastCleanDateTime == null ? 255 : ((now.difference(lastCleanDateTime).inSeconds / 1).floor())).clamp(0, 255);
  }

}

final cleanHistoryRepository = Provider((ref) => CleanHistoryRepository());