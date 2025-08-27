import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/user/user.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';

class SaveProfileUseCase extends UseCase<void, UserInfo> {
  final UserRepository _userRepository;

  SaveProfileUseCase(this._userRepository);

  @override
  FutureOr<void> call({required UserInfo params}) {
    return _userRepository.saveProfile(params);
  }
}
