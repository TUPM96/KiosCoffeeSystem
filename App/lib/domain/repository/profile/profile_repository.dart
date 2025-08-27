import 'package:boilerplate/presentation/profile/store/profile_store.dart';

abstract class ProfileRepository {
  Future<void> logoutProfile();

  Future<Profile> getProfileInfo();
}
