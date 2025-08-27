import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/container/container_detail.dart';
import 'package:boilerplate/domain/repository/container/container_repository.dart';

class GetContainerDetailUseCase extends UseCase<ContainerDetailModel, String> {
  final ContainerRepository _containerRepository;

  GetContainerDetailUseCase(this._containerRepository);

  @override
  Future<ContainerDetailModel> call({required String params}) {
    return _containerRepository.getContainerDetail(params);
  }
}
