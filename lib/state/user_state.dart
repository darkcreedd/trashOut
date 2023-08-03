import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_model.dart';

class UserDetailsNotifier extends StateNotifier<AppUser> {
  UserDetailsNotifier()
      : super(AppUser(
            name: 'name',
            email: 'email',
            totalPoints: 0,
            totalDisposals: 0,
            wasteList: [],
            redeemed: 0));
  updateUser({required AppUser user}) {
    state = user;
  }
}

final userDetailsNotifierProvider =
    StateNotifierProvider<UserDetailsNotifier, AppUser>((ref) {
  return UserDetailsNotifier();
});
