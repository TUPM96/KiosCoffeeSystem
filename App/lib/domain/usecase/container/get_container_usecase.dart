import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/repository/container/container_repository.dart';

class GetContainerUseCase extends UseCase<ContainerListData, int> {
  final ContainerRepository _containerRepository;

  GetContainerUseCase(this._containerRepository);
  @override
  Future<ContainerListData> call({required void params}) {
    return _containerRepository.getContainerList();
  }
}
