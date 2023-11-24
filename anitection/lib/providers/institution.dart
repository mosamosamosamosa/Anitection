

import 'package:anitection/models/base.dart';
import 'package:anitection/models/institution/institution.dart';
import 'package:anitection/providers/client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final institutionFutureProvider = FutureProvider.autoDispose.family<Model<InstitutionAttributes>, int>((ref, id) async {
  final client = ref.watch(anitectionClientProvider);
  final response = await client.getInstitution(id);
  return response.data;
});