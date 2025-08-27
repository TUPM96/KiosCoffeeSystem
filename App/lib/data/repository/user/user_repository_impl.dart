import 'dart:async';

import 'package:boilerplate/data/network/apis/user/user_api.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/entity/user/user.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';

import '../../../domain/usecase/user/login_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  final UserApi _userApi;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper, this._userApi);

  // Login:---------------------------------------------------------------------
  @override
  Future<UserInfo?> login(LoginParams params) async {
    late UserInfo user;
    await _userApi.login(params).then((value) {
      print('from repository: ${value.data!.accessToken}');
      user = value.data!;
    });
    return user;
  }

  @override
  Future<void> saveIsLoggedIn(bool value) =>
      _sharedPrefsHelper.saveIsLoggedIn(value);

  Future<void> saveLoginInfo(LoginParams params) async {
    _sharedPrefsHelper.saveEmail(params.username);
    _sharedPrefsHelper.savePassword(params.password);
  }

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;

  @override
  Future<void> saveAccessToken(String value) {
    return _sharedPrefsHelper.saveAuthToken(value);
  }

  @override
  Future<void> saveProfile(UserInfo value) {
    print('from repository: ${value.toJson()}');
    return _sharedPrefsHelper.saveProfile(
      value.convertToJson(),
    );
  }

  @override
  Future<LoginParams> getLoginInfo() async {
    var email = await _sharedPrefsHelper.getEmail() ?? '';
    var password = await _sharedPrefsHelper.getPassword() ?? '';

    return LoginParams(password: password, username: email);
  }
}
