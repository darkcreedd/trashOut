//Todo: Waste points Computation
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'state.dart';

class WastePointsNotifier extends StateNotifier<int> {
  WastePointsNotifier() : super(0);

  update(int redeemedPoints) {
    state = state - redeemedPoints;
  }
}

final wastePointsProvider =
    StateNotifierProvider<WastePointsNotifier, int>((ref) {
  final wasteList = ref.watch(wasteListProvider);
  int totalPoints = 0;

  wasteList.where((element) => element.status == 'Completed').forEach((waste) {
    totalPoints += waste.points;
  });

  // ignore: invalid_use_of_protected_member
  return WastePointsNotifier()..state = totalPoints;
});

class RedeemedPointsNotifier extends StateNotifier<int> {
  RedeemedPointsNotifier() : super(0);

  set(int newRedeemed) {
    state = state + newRedeemed;
  }
}

final redeemedPointsProvider =
    StateNotifierProvider<RedeemedPointsNotifier, int>((ref) {
  return RedeemedPointsNotifier();
});
