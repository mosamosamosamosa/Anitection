
import 'package:anitection/client/client.dart';
import 'package:dio/dio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final anitectionClientProvider = Provider<AnitectionClient>((ref) {
  final dio = Dio();
  return AnitectionClient(dio);
});
