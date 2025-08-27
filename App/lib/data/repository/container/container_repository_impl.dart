import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/container/container_datasource.dart';
import 'package:boilerplate/data/network/apis/container/container_api.dart';
import 'package:boilerplate/domain/entity/container/container_data.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/container/container_detail.dart';
import 'package:boilerplate/domain/repository/container/container_repository.dart';
import 'package:sembast/sembast.dart';

class ContainerRepositoryImpl extends ContainerRepository {
  //data source api
  final ContainerDataSource _containerDataSource;

  //network api
  final ContainerApi _containerApi;

  ContainerRepositoryImpl(this._containerDataSource, this._containerApi);

  // ContainerRepository surface => fetch main data
  @override
  Future<ContainerListData> getContainerList() async {
    return await _containerApi.getContainerList().then((value) {
      value.content.forEach((element) {
        _containerDataSource.insert(element);
      });
      return value;
    }).catchError((error) => throw error);
  }

  @override
  Future<ContainerDetailModel> getContainerDetail(String id) async {
    return await _containerApi
        .getContainerDetail(id)
        .then((value) => value)
        .catchError((err) => throw err);
  }

  Future<ContainerListContent> findContainerById(int id) {
    List<Filter> filters = [];
    Filter idTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(idTypeFilter);

    return _containerDataSource
        .getAllSortedByFilter(filters: filters)
        .then((value) => value.last)
        .catchError((error) => throw error);
  }

  Future<ContainerListData> getUpcomingContainerList() async {
    final content = await _containerDataSource.getAllSortedByFilter(filters: [
      Filter.equals('history.status', "waiting_for_stuffing"),
    ]);
    const perPage = 15;

    return ContainerListData(
      content: content,
      pagination: Pagination(
        currentPage: 1,
        perPage: 15,
        lastPage: (content.length / perPage).floor(),
        total: content.length,
      ),
    );
  }

  @override
  Future<int> update(ContainerData data) => _containerDataSource
      .update(data)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<int> delete(ContainerData data) => _containerDataSource
      .delete(data)
      .then((id) => id)
      .catchError((error) => throw error);
}
