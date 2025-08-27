// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';

class SaveAccessTokenUseCase extends UseCase<void, String> {
  final UserRepository userRepository;

  SaveAccessTokenUseCase({
    required this.userRepository,
  });

  @override
  Future<void> call({required String params}) {
    return userRepository.saveAccessToken(params);
  }
}
