import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';

class GetProfileUseCase extends UseCase<Profile, String> {
  final ProfileRepository profileRepository;

  GetProfileUseCase(this.profileRepository);

  @override
  Future<Profile> call({required void params}) {
    return profileRepository.getProfileInfo();
  }
}
