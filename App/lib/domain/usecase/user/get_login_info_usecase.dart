import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';

class GetLoginInfoUsecase extends UseCase<LoginParams, int> {
  final UserRepository _userRepository;

  GetLoginInfoUsecase(this._userRepository);

  @override
  Future<LoginParams> call({required int params}) {
    return _userRepository.getLoginInfo();
  }
}
