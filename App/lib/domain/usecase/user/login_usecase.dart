// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:boilerplate/domain/entity/user/user.dart';

import '../../../core/domain/usecase/use_case.dart';
import '../../repository/user/user_repository.dart';

class LoginParams {
  final String username;
  final String password;

  LoginParams({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': username,
      'password': password,
    };
  }

  factory LoginParams.fromMap(Map<String, dynamic> map) {
    return LoginParams(
      username: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginParams.fromJson(String source) =>
      LoginParams.fromMap(json.decode(source) as Map<String, dynamic>);
}

class LoginUseCase implements UseCase<UserInfo?, LoginParams> {
  final UserRepository _userRepository;

  LoginUseCase(this._userRepository);

  @override
  Future<UserInfo?> call({required LoginParams params}) async {
    return _userRepository.login(params).then((value) {
      print('from use case:' + value!.accessToken.toString());
      return value;
    });
  }
}
