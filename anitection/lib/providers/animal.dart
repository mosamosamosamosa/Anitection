
import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/client.dart';
import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animalsFutureProvider = FutureProvider.autoDispose((ref) {
  return ref.read(anitectionClientProvider).getAnimals();
});

final animalFutureProvider = FutureProvider.autoDispose.family<SingleData<Model<AnimalAttributes>>, int>((ref, id) {
  return ref.read(anitectionClientProvider).getAnimal(id);
});

final searchAnimalFutureProvider = FutureProvider.autoDispose.family<PagingData<Model<AnimalAttributes>>, AnimalSearchQueries>((ref, query) {
  return ref.read(anitectionClientProvider).searchAnimals(query.toQueries());
});

Map<String, dynamic> buildQueryParameter(
    String animalKind, {
      List<String>? size,
      List<String>? hairLength,
      Set<Age>? age,
      List<int>? patternIds,
    }) {

  final queryParams = {
    "filters[animal_kind][name][\$eq]": animalKind,
  };

  if (size != null) {
    for (int i = 0; i < size.length; i ++) {
      final s = size[i];
      queryParams["filters[\$or][$i][size][\$eq]"] = s;
    }
  }

  if (hairLength != null) {
    for (int i = 0; i < hairLength.length; i ++) {
      final l = hairLength[i];
      queryParams["filters[\$or][$i][hair_length][\$eq]"] = l;
    }
  }

  if (patternIds != null && patternIds.isNotEmpty) {
    for (int i = 0; i < patternIds.length; i ++) {
      final id = patternIds[i];
      queryParams["filters[pattern][id][\$in][$i]"] = id.toString();
    }
  }

  if (age != null) {
    int min;
    int max;
    if (age.contains(Age.kitten)) {
      min = 0;
    } else if (age.contains(Age.adult)) {
      min = 1;
    } else {
      min = 6;
    }

    if (age.contains(Age.senior)) {
      max = 2147483647;
    } else if (age.contains(Age.adult)) {
      max = 11;
    } else {
      max = 1;
    }

    queryParams["filters[age][\$lte]"] = max.toString();
    queryParams["filters[age][\$gte]"] = min.toString();
  }

  return queryParams;
}

class AnimalSearchQueries {
  AnimalSearchQueries({
    required this.animalKind,
    required this.size,
    required this.hairLength,
    required this.age,
    required this.patternIds,
  });

  final String animalKind;
  final List<String>? size;
  final List<String>? hairLength;
  final List<Age>? age;
  final List<int>? patternIds;

  Map<String, dynamic> toQueries() {
    return buildQueryParameter(animalKind, size: size, hairLength: hairLength, age: age?.toSet(), patternIds: patternIds);
  }

  // equals
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is AnimalSearchQueries &&
        other.animalKind == animalKind &&
        listEquals(other.size, size) &&
        listEquals(other.hairLength, hairLength) &&
        listEquals(other.age, age) &&
        listEquals(other.patternIds, patternIds);
  }

  @override
  int get hashCode => animalKind.hashCode ^ size.hashCode ^ hairLength.hashCode ^ age.hashCode ^ patternIds.hashCode;

}