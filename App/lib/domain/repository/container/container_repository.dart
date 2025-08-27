import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/container/container_detail.dart';

abstract class ContainerRepository {
  Future<ContainerListData> getContainerList();

  Future<ContainerDetailModel> getContainerDetail(String id);

  Future<ContainerListData> getUpcomingContainerList();
}
