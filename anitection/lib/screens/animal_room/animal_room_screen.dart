import 'dart:developer';

import 'package:anitection/models/animal/animal.dart';
import 'package:anitection/models/base.dart';
import 'package:anitection/providers/animal.dart';
import 'package:anitection/screens/animal_room/animal_room_profile_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AnimalRoomScreen extends ConsumerStatefulWidget {
  const AnimalRoomScreen({super.key, required this.animalId});

  final int animalId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return AnimalRoomScreenState();
  }
}

class AnimalRoomScreenState extends ConsumerState<AnimalRoomScreen> {
  @override
  Widget build(BuildContext context) {
    final animalAsyncState = ref.watch(animalFutureProvider(widget.animalId));
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Animal Room"),
      ),
      body: Center(
        child: animalAsyncState.when(data: (data) {
          return ElevatedButton(
            onPressed: () {
              showAnimalRoomProfileDialog(context, size, data.data);
            },
            child: const Text("Button"),
          );
        }, error: (e, st) {
          log("error", error: e, stackTrace: st);
          return const Text("error");
        }, loading: () {
          return const CircularProgressIndicator();
        }),
      ),
    );
  }
}

Future<void> showAnimalRoomProfileDialog(
  BuildContext context,
  Size screenSize,
  Model<AnimalAttributes> animal,
) {
  return showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    context: context,
    builder: (context) {
      return FractionallySizedBox(
        heightFactor: 0.75,
        child: AnimalRoomProfileDialog(
          height: screenSize.height * 0.9,
          animal: animal,
        ),
      );
    },
  );
}
