// ignore_for_file: avoid_print, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:trash_out/state/firestore_db.dart';

import '../models/waste_model.dart';

// Waste Notifier and Provider
final wasteListProvider = StateNotifierProvider<WasteNotifier, List<Waste>>(
  (ref) => WasteNotifier(),
);

class WasteNotifier extends StateNotifier<List<Waste>> {
  WasteNotifier() : super([]);
  updateState() async {
    state = await FirestoreService()
        .getWasteListForUser(FirebaseAuth.instance.currentUser!.uid);
  }

  void updateList() async {
    state = await FirestoreService()
        .getWasteListForUser(FirebaseAuth.instance.currentUser!.uid);
  }

  void addWaste({
    required String wasteClass,
    required List<String> wasteTypes,
    String? imagePath,
    required DateTime date,
    required String time,
    required String location,
    String? status,
    required int points,
  }) async {
    Waste newWaste = Waste(
      wasteId: UniqueKey().toString(),
      wasteClass: wasteClass,
      wasteTypes: wasteTypes,
      status: status,
      date: date,
      time: time,
      location: location,
      points: points,
    );
    state = [...state, newWaste];
    print('from state notifier ${state.toList()}');
    await FirestoreService()
        .addWasteToUserInFirestore(
            FirebaseAuth.instance.currentUser!.uid, newWaste)
        .then((value) => print('data written to database'));
    state = await FirestoreService()
        .getWasteListForUser(FirebaseAuth.instance.currentUser!.uid);

    //todo: Write this info to firestore if it gets approved, then you retrieve it from firestore to completed
    print('waste list from firestore ${state.toList()}');
  }
}
//todo: Write this to firestore

//ToDo: Completed Waste Notifier

class CompletedWasteNotifier extends StateNotifier<List<Waste>> {
  CompletedWasteNotifier() : super([]);
}

final completedWasteProvider = Provider<List<Waste>>((ref) {
  final wasteList = ref.watch(wasteListProvider);
  return wasteList.where((element) => element.status == 'Completed').toList();
});

//ToDo: Pending Waste Notifier

class PendingWasteNotifier extends StateNotifier<List<Waste>> {
  PendingWasteNotifier() : super([]);
}

final pendingWasteProvider = Provider<List<Waste>>((ref) {
  final wasteList = ref.watch(wasteListProvider);
  return wasteList.where((element) => element.status == 'Pending').toList();
});

//ToDo: Waste Class Notifier

class WasteClassNotifier extends StateNotifier<String> {
  WasteClassNotifier() : super('');

  void setWasteClass(String wasteClass) {
    state = wasteClass;
  }
}

final wasteClassProvider = StateNotifierProvider<WasteClassNotifier, String>(
  (ref) => WasteClassNotifier(),
);

//ToDo: Waste Type Notifier
final wasteTypesProvider = StateNotifierProvider<WasteTypesNotifier, WasteType>(
  (ref) => WasteTypesNotifier(),
);

class WasteTypesNotifier extends StateNotifier<WasteType> {
  WasteTypesNotifier() : super(WasteType());

  void addWasteType(List<String> wasteTypes) {
    state = WasteType(wasteTypes: wasteTypes);
    print(state.wasteTypes);
  }
}

//Todo: Date and Time
final wasteDateTimeProvider =
    StateNotifierProvider<WasteDateTimeNotifier, WasteDateTime>(
  (ref) => WasteDateTimeNotifier(),
);

class WasteDateTimeNotifier extends StateNotifier<WasteDateTime> {
  WasteDateTimeNotifier() : super(WasteDateTime());

  void addWasteDateTime({
    required DateTime wasteDate,
    required String wasteTime,
  }) {
    state = WasteDateTime(wasteDate: wasteDate, wasteTime: wasteTime);
    print(state.wasteDate);
  }
}

class WasteDateTime {
  final DateTime? wasteDate;
  final String? wasteTime;
  WasteDateTime({
    this.wasteDate,
    this.wasteTime,
  });
}

class WasteType {
  final List<String>? wasteTypes;
  WasteType({
    this.wasteTypes,
  });
}

class ImagesNotifier extends StateNotifier<List<XFile?>> {
  ImagesNotifier() : super([]);

  // Method to add images to the state
  void addImages(List<XFile?> newImages) {
    // Get the current state
    final currentState = state;

    // Add the new images to the current state
    final updatedState = [...currentState, ...newImages];

    // Update the state with the new list of images
    state = updatedState;
  }

  void clearImages() {
    // Clear the state of the new list of images
    state = [];
  }
}

final imagesProvider =
    StateNotifierProvider<ImagesNotifier, List<XFile?>>((ref) {
  return ImagesNotifier();
});

final statsProvider = Provider<List<int>>((ref) {
  final wasteList = ref.watch(wasteListProvider);

  int plastic = 0;
  int metal = 0;
  int organic = 0;
  int glass = 0;
  int ewaste = 0;
  int others = 0;
  int total = 0;

  for (final waste in wasteList) {
    for (final wastetype in waste.wasteTypes) {
      total += 1;
      switch (wastetype) {
        case 'Plastic':
          plastic += 1;
          break;
        case 'Glass':
          glass += 1;
          break;
        case 'Metal':
          metal += 1;
          break;
        case 'E-waste':
          ewaste += 1;
          break;
        case 'Organic':
          organic += 1;
          break;
        default:
          others += 1;
      }
    }
  }

  return [plastic, metal, organic, glass, ewaste, others, total];
});

final gpsAddressProvider =
    StateNotifierProvider<WasteDateTimeNotifier, WasteDateTime>(
  (ref) => WasteDateTimeNotifier(),
);

class GPSAddressNotifier extends StateNotifier<String> {
  GPSAddressNotifier() : super('');

  void update(String address) {
    state = address;
  }
}
