
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/client.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animalsFutureProvider = FutureProvider.autoDispose((ref) {
  return ref.read(anitectionClientProvider).getAnimals();
});

final animalFutureProvider = FutureProvider.autoDispose.family<SingleData<Model<AnimalAttributes>>, int>((ref, id) {
  return ref.read(anitectionClientProvider).getAnimal(id);
});

final searchAnimalFutureProvider = FutureProvider.autoDispose.family<PagingData<Model<AnimalAttributes>>, Map<String, dynamic>>((ref, query) {
  return ref.read(anitectionClientProvider).searchAnimals(query);
});