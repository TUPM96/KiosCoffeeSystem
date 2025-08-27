import 'dart:async';

import 'package:boilerplate/core/domain/usecase/use_case.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/repository/container/container_repository.dart';

class GetUpcomingContainerUseCase extends UseCase<ContainerListData, int> {
  final ContainerRepository _containerRepository;

  GetUpcomingContainerUseCase(
      {required ContainerRepository containerRepository})
      : _containerRepository = containerRepository;

  @override
  Future<ContainerListData> call({required void params}) {
    return _containerRepository.getUpcomingContainerList();
  }
}
