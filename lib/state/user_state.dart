import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserDetailsNotifier extends StateNotifier<AppUser> {
  UserDetailsNotifier()
      : super(AppUser(
            name: 'name',
            email: 'email',
            password: 'password',
            totalPoints: 0,
            totalDisposals: 0,
            redeemed: 0));
  updateUser(
      {required String name,
      required String email,
      required String password,
      required int totalPoints,
      required int totalDisposals,
      required int redeemed}) {
    state = AppUser(
        name: name,
        email: email,
        password: password,
        totalPoints: totalPoints,
        totalDisposals: totalDisposals,
        redeemed: redeemed);
  }
}

final userDetailsNotifierProvider =
    StateNotifierProvider<UserDetailsNotifier, AppUser>((ref) {
  return UserDetailsNotifier();
});
