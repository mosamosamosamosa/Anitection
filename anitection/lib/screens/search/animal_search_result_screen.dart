import 'package:anitection/screens/initial_animal_filter/initial_cat_preference_selection_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalSearchResultScreen extends ConsumerStatefulWidget {
  const AnimalSearchResultScreen(
      {super.key,
      required this.animalKind,
      required this.size,
      required this.hairLength,
      required this.age});

  final String animalKind;
  final List<String> size;
  final List<String>? hairLength;
  final List<Age>? age;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalSearchResultState();
  }
}

class AnimalSearchResultState extends ConsumerState<AnimalSearchResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}

String buildQueryParameter(
  String animalKind, {
  List<String>? size,
  List<String>? hairLength,
  Set<Age>? age,
}) {

  final queryParams = {
    "filters[animal_kind][name][\$eq]": animalKind,
  };

  if (size != null) {
    for (int i = 0; i < size.length; i ++) {
      final s = size[i];
      queryParams["filters[\$or][$i][size]"] = s;
    }
  }

  if (hairLength != null) {
    for (int i = 0; i < hairLength.length; i ++) {
      final l = hairLength[i];
      queryParams["filters[\$or][$i][hair_length]"] = l;
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

    queryParams["filters[age][\$gte]"] = max.toString();
    queryParams["filters[age][\$lte]"] = min.toString();
  }

  String params = "";
  final keys = queryParams.keys.toList();
  for (int i = 0; i < keys.length; i ++) {
    if (i == 0) {
      params += ("${keys[i]}=${queryParams[keys[i]]}");
    } else {
      params += ("&${keys[i]}=${queryParams[keys[i]]}");
    }
  }
  return params;
}
