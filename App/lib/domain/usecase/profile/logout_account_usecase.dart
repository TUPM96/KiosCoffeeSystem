import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';

class LogoutAccountUseCase extends UseCase<void, int> {
  final ProfileRepository profileRepository;

  LogoutAccountUseCase(this.profileRepository);

  @override
  Future<void> call({required void params}) {
    return profileRepository.logoutProfile();
  }
}
