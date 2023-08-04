import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:trash_out/repository/auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(FirebaseAuth.instance);
});

final authStateProvider = StreamProvider<User?>((ref) {
  return ref.read(authRepositoryProvider).authStateChange;
});

class UserProfilePictureNotifier extends StateNotifier<String?> {
  UserProfilePictureNotifier() : super(null);

  void updateProfilePicture(String newImageUrl) {
    state = newImageUrl;
  }
}

final userProfilePictureProvider =
    StateNotifierProvider<UserProfilePictureNotifier, String?>((ref) {
  return UserProfilePictureNotifier();
});
