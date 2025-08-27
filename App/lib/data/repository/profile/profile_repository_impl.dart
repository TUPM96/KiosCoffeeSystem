import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';

class ProfileRepositoryImpl extends ProfileRepository {
  final SharedPreferenceHelper _sharedPreferenceHelper;

  ProfileRepositoryImpl(this._sharedPreferenceHelper);

  @override
  Future<void> logoutProfile() async {
    await _sharedPreferenceHelper.removeAuthToken();
    await _sharedPreferenceHelper.saveIsLoggedIn(false);
  }

  @override
  Future<Profile> getProfileInfo() async {
    var profile = await _sharedPreferenceHelper.getProfile();
    print(profile);
    return Profile.fromJson(profile);
  }
}
