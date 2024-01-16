
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

}

final cleanHistoryRepository = Provider((ref) => CleanHistoryRepository());