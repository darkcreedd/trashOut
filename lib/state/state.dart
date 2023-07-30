// // ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'package:trash_out/models/waste_model.dart';

// final wasteListProvider =
//     StateNotifierProvider<WasteNotifier, List<Waste>>((ref) {
//   return WasteNotifier();
// });

// class WasteNotifier extends StateNotifier<List<Waste>> {
//   WasteNotifier()
//       : super([
// Waste(
//     id: '8556',
//     wasteId: '859648',
//     wasteClass: 'Industrial',
//     wasteTypes: ['Plastic', 'Glass'],
//     date: DateTime.now(),
//     status: 'Completed',
//     time: TimeOfDay.now().toString(),
//     location: "College of Science",
//     points: 40),
// Waste(
//     id: '8556',
//     wasteId: '896745',
//     status: 'Pending',
//     wasteClass: 'Medical',
//     wasteTypes: ['Plastic', 'Glass'],
//     date: DateTime.now(),
//     time: TimeOfDay.now().toString(),
//     location: "College of Science",
//     points: 30),
// Waste(
//     id: '8556',
//     wasteId: '896745',
//     status: 'Completed',
//     wasteClass: 'Medical',
//     wasteTypes: ['Plastic', 'Glass'],
//     date: DateTime.now(),
//     time: TimeOfDay.now().toString(),
//     location: "College of Science",
//     points: 30),
//         ]);

//   void addWaste({
//     required String wasteClass,
//     required List<String> wasteTypes,
//     String? imagePath,
//     required DateTime date,
//     required String time,
//     required String location,
//     String? status,
//     required int points,
//   }) {
//     var rng = Random();
//     var code = rng.nextInt(900000) + 100000;
//     Waste newWaste = Waste(
//         id: UniqueKey().toString(),
//         wasteId: code.toString(),
//         wasteClass: wasteClass,
//         wasteTypes: wasteTypes,
//         date: date,
//         time: time,
//         location: location,
//         points: points);
//     state = [...state, newWaste];
//   }
// }

// //* Waste Class StateNotifier and Provider
// class WasteClassNotifier extends StateNotifier<String> {
//   WasteClassNotifier() : super('');

//   void setWasteClass(String wasteClass) {
//     state = wasteClass;
//   }
// }

// final wasteClassProvider = StateNotifierProvider<WasteClassNotifier, String>(
//     (ref) => WasteClassNotifier());

// //*Completed

// class CompletedWasteNotifier extends StateNotifier<List<Waste>> {
//   CompletedWasteNotifier() : super([]);

//   // In the constructor, filter the state of WasteNotifier to include only 'Completed' wastes.
//   CompletedWasteNotifier.fromWasteNotifierState(List<Waste> wasteList)
//       : super(wasteList.where((waste) => waste.status == 'Completed').toList());
// }

// // Create a new state notifier provider for the CompletedWasteNotifier.
// final completedWasteListProvider =
//     StateNotifierProvider<CompletedWasteNotifier, List<Waste>>((ref) {
//   // Get the state of the WasteNotifier and pass it to the CompletedWasteNotifier constructor.
//   final wasteState = ref.watch(wasteListProvider);
//   return CompletedWasteNotifier.fromWasteNotifierState(wasteState);
// });

// //*Pending
// class PendingWasteNotifier extends StateNotifier<List<Waste>> {
//   PendingWasteNotifier() : super([]);

//   // In the constructor, filter the state of WasteNotifier to include only 'Pending' wastes.
//   PendingWasteNotifier.fromWasteNotifierState(List<Waste> wasteList)
//       : super(wasteList.where((waste) => waste.status == 'Pending').toList());
// }

// // Create a new state notifier provider for the PendingWasteNotifier.
// final pendingWasteListProvider =
//     StateNotifierProvider<PendingWasteNotifier, List<Waste>>((ref) {
//   // Get the state of the WasteNotifier and pass it to the PendingWasteNotifier constructor.
//   final wasteState = ref.watch(wasteListProvider);
//   return PendingWasteNotifier.fromWasteNotifierState(wasteState);
// });

// final wasteTypesProvider =
//     StateNotifierProvider<WasteTypesNotifier, WasteType>((ref) {
//   return WasteTypesNotifier();
// });

// class WasteTypesNotifier extends StateNotifier<WasteType> {
//   WasteTypesNotifier() : super(WasteType());

//   void addWasteType(List<String> wasteTypes) {
//     state = WasteType(wasteTypes: wasteTypes);
//     print(state.wasteTypes);
//   }
// }

// class WasteType {
//   final List<String>? wasteTypes;
//   WasteType({
//     this.wasteTypes,
//   });
// }

// //*Waste Date And Time
// final wasteDateTimeProvider =
//     StateNotifierProvider<WasteDateTimeNotifier, WasteDateTime>((ref) {
//   return WasteDateTimeNotifier();
// });

// class WasteDateTimeNotifier extends StateNotifier<WasteDateTime> {
//   WasteDateTimeNotifier() : super(WasteDateTime());

//   void addWasteDateTime(
//       {required DateTime wasteDate, required String wasteTime}) {
//     state = WasteDateTime(wasteDate: wasteDate, wasteTime: wasteTime);
//     print(state.wasteDate);
//   }
// }

// class WasteDateTime {
//   final DateTime? wasteDate;
//   final String? wasteTime;
//   WasteDateTime({
//     this.wasteDate,
//     this.wasteTime,
//   });
// }

// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:trash_out/models/waste_model.dart';

// Waste Notifier and Provider
// final wasteListProvider =
//     StateNotifierProvider<WasteNotifier, List<Waste>>((ref) {
//   return WasteNotifier();
// });

// class WasteNotifier extends StateNotifier<List<Waste>> {
//   WasteNotifier()
//       : super([
// Initial list of wastes (commented out for now)
//         ]);

//   void addWaste({
//     required String wasteClass,
//     required List<String> wasteTypes,
//     String? imagePath,
//     required DateTime date,
//     required String time,
//     required String location,
//     String? status,
//     required int points,
//   }) {
//     var rng = Random();
//     var code = rng.nextInt(900000) + 100000;
//     Waste newWaste = Waste(
//         id: UniqueKey().toString(),
//         wasteId: code.toString(),
//         wasteClass: wasteClass,
//         wasteTypes: wasteTypes,
//         status: status,
//         date: date,
//         time: time,
//         location: location,
//         points: points);
//     state = [...state, newWaste];
//     print('from state notifier ${state.toList()}');
//   }
// }

// Waste Class StateNotifier and Provider
// class WasteClassNotifier extends StateNotifier<String> {
//   WasteClassNotifier() : super('');

//   void setWasteClass(String wasteClass) {
//     state = wasteClass;
//   }
// }

// final wasteClassProvider = StateNotifierProvider<WasteClassNotifier, String>(
//     (ref) => WasteClassNotifier());

// Completed
// class CompletedWasteNotifier extends StateNotifier<List<Waste>> {
//   CompletedWasteNotifier() : super([]);

// In the constructor, filter the state of WasteNotifier to include only 'Completed' wastes.
//   CompletedWasteNotifier.fromWasteNotifierState(List<Waste> wasteList)
//       : super(wasteList.where((waste) => waste.status == 'Completed').toList());
// }

// // Create a new state notifier provider for the CompletedWasteNotifier.
// final completedWasteListProvider =
//     StateNotifierProvider<CompletedWasteNotifier, List<Waste>>((ref) {
//   // Get the state of the WasteNotifier and pass it to the CompletedWasteNotifier constructor.
//   final wasteState = ref.watch(wasteListProvider);
//   return CompletedWasteNotifier.fromWasteNotifierState(wasteState);
// });

// // Pending
// class PendingWasteNotifier extends StateNotifier<List<Waste>> {
//   PendingWasteNotifier() : super([]);

//   // In the constructor, filter the state of WasteNotifier to include only 'Pending' wastes.
//   PendingWasteNotifier.fromWasteNotifierState(List<Waste> wasteList)
//       : super(wasteList.where((waste) => waste.status == 'Pending').toList());
// }

// // Create a new state notifier provider for the PendingWasteNotifier.
// final pendingWasteListProvider =
//     StateNotifierProvider<PendingWasteNotifier, List<Waste>>((ref) {
//   // Get the state of the WasteNotifier and pass it to the PendingWasteNotifier constructor.
//   final wasteState = ref.watch(wasteListProvider);
//   return PendingWasteNotifier.fromWasteNotifierState(wasteState);
// });

// // Waste Types StateNotifier and Provider
// final wasteTypesProvider =
//     StateNotifierProvider<WasteTypesNotifier, WasteType>((ref) {
//   return WasteTypesNotifier();
// });

// class WasteTypesNotifier extends StateNotifier<WasteType> {
//   WasteTypesNotifier() : super(WasteType());

//   void addWasteType(List<String> wasteTypes) {
//     state = WasteType(wasteTypes: wasteTypes);
//     print(state.wasteTypes);
//   }
// }

// class WasteType {
//   final List<String>? wasteTypes;
//   WasteType({
//     this.wasteTypes,
//   });
// }

// // Waste Date and Time StateNotifier and Provider
// final wasteDateTimeProvider =
//     StateNotifierProvider<WasteDateTimeNotifier, WasteDateTime>((ref) {
//   return WasteDateTimeNotifier();
// });

// class WasteDateTimeNotifier extends StateNotifier<WasteDateTime> {
//   WasteDateTimeNotifier() : super(WasteDateTime());

//   void addWasteDateTime({
//     required DateTime wasteDate,
//     required String wasteTime,
//   }) {
//     state = WasteDateTime(wasteDate: wasteDate, wasteTime: wasteTime);
//     print(state.wasteDate);
//   }
// }

// class WasteDateTime {
//   final DateTime? wasteDate;
//   final String? wasteTime;
//   WasteDateTime({
//     this.wasteDate,
//     this.wasteTime,
//   });
// }

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/waste_model.dart';

// Waste Notifier and Provider
final wasteListProvider = StateNotifierProvider<WasteNotifier, List<Waste>>(
  (ref) => WasteNotifier(),
);

class WasteNotifier extends StateNotifier<List<Waste>> {
  WasteNotifier() : super([]);

  void addWaste({
    required String wasteClass,
    required List<String> wasteTypes,
    String? imagePath,
    required DateTime date,
    required String time,
    required String location,
    String? status,
    required int points,
  }) {
    var rng = Random();
    var code = rng.nextInt(900000) + 100000;
    Waste newWaste = Waste(
      id: UniqueKey().toString(),
      wasteId: code.toString(),
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
  }
}

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
