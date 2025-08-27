import 'dart:async';

import 'package:boilerplate/domain/usecase/user/login_usecase.dart';

import '../../entity/user/user.dart';

abstract class UserRepository {
  Future<UserInfo?> login(LoginParams params);

  Future<void> saveIsLoggedIn(bool value);

  Future<bool> get isLoggedIn;

  Future<void> saveAccessToken(String value);

  Future<void> saveLoginInfo(LoginParams params);

  Future<LoginParams> getLoginInfo();

  Future<void> saveProfile(UserInfo value);
}
