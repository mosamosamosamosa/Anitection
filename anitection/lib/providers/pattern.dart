import 'package:anitection/providers/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final catPatternsFutureProvider = FutureProvider.autoDispose((ref) {
  return ref.read(anitectionClientProvider).getPatterns();
});