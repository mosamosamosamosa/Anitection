
import 'package:anitection/client/client.dart';
import 'package:anitection/repositories/token_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final anitectionClientProvider = Provider<AnitectionClient>((ref) {
  return create(ref.read(tokenRepositoryProvider));
});
