import 'package:boilerplate/domain/entity/upcoming/upcoming_container_list.dart';

abstract class UpcomingContainerRepository {
  Future<UpcomingContainerList> getUpcomingContainerList();
}
