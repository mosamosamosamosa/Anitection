import 'package:anitection/providers/animal.dart';
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
    final searchResult = ref.watch(searchAnimalFutureProvider(buildQueryParameter(
      widget.animalKind,
      size: widget.size,
      hairLength: widget.hairLength,
      age: widget.age?.toSet(),
    )));
    return Scaffold(
      body: searchResult.when(
        data: (data) {
          return ListView.builder(
            itemBuilder: (context, index) {
              final animal = data.data[index];
              return ListTile(
                title: Text(animal.attributes.name ?? ""),
              );
            },
            itemCount: data.data.length,
          );
        },
        loading: () {
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        error: (error, stackTrace) {
          return const Center(
            child: Text("エラーが発生しました"),
          );
        },
      )
    );
  }
}

Map<String, dynamic> buildQueryParameter(
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
      queryParams["filters[\$or][$i][size][\$eq]"] = s;
    }
  }

  if (hairLength != null) {
    for (int i = 0; i < hairLength.length; i ++) {
      final l = hairLength[i];
      queryParams["filters[\$or][$i][hair_length][\$eq]"] = l;
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
