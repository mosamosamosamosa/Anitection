
import 'package:anitection/client/client.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/models/pedigree/pedigree.dart';
import 'package:anitection/providers/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final dogPedigreesFutureProvider = FutureProvider.autoDispose((ref) {
  return _getAllPatterns(ref.read(anitectionClientProvider));
});

// recursive get patterns if next page
Future<List<Model<PedigreeAttributes>>> _getAllPatterns(
    AnitectionClient client, {
      List<Model<PedigreeAttributes>> fetchedPatterns = const [],
      int? nextPage,
      int? pageCount,
    }) async {
  if (pageCount != null && nextPage != null && nextPage > pageCount) {
    return fetchedPatterns;
  }
  final page = await client.getPedigree(nextPage);
  final patterns = page.data;
  final meta = page.meta;
  final newFetchedPatterns = [...fetchedPatterns, ...patterns];
  return _getAllPatterns(
    client,
    fetchedPatterns: newFetchedPatterns,
    nextPage: meta.pagination.page + 1,
    pageCount: meta.pagination.pageCount,
  );
}
