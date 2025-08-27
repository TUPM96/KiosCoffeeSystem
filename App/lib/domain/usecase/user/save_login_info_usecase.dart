import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';

class SaveLoginInformationUseCase extends UseCase<void, LoginParams> {
  final UserRepository _userRepository;

  SaveLoginInformationUseCase(this._userRepository);

  @override
  FutureOr<void> call({required LoginParams params}) {
    return _userRepository.saveLoginInfo(params);
  }
}
