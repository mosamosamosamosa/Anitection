
import 'package:anitection/models/base.dart';
import 'package:anitection/models/timeline/timeline.dart';
import 'package:anitection/providers/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class TimelineController extends AsyncNotifier<List<Model<TimelineAttributes>>> {
  @override
  FutureOr<List<Model<TimelineAttributes>>> build() {
    return _fetchTimelines();
  }

  Future<List<Model<TimelineAttributes>>> _fetchTimelines() async {
    try {
      final timelines = await ref.read(anitectionClientProvider).getTimelines(null, null);
      return timelines.data;
    } catch(e) {
      rethrow;
    }
  }
}

final timelineControllerProvider = AsyncNotifierProvider<TimelineController, List<Model<TimelineAttributes>>>(() => TimelineController());