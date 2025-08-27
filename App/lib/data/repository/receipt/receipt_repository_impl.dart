import 'dart:async';

import 'package:boilerplate/data/local/constants/db_constants.dart';
import 'package:boilerplate/data/local/datasources/container/container_datasource.dart';
import 'package:boilerplate/data/local/datasources/products/products_datasource.dart';
import 'package:boilerplate/data/local/datasources/receipt/receipt_datasource.dart';
import 'package:boilerplate/data/network/apis/receipt/receipt_api.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt_response.dart';
import 'package:boilerplate/domain/entity/receipt/packing_response.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';
import 'package:boilerplate/presentation/receipt/add_receipt/store/add_goods_receipt_store.dart';
import 'package:sembast/sembast.dart';

class GoodsReceiptRepositoryImpl extends GoodsReceiptRepository {
  // data source object
  final GoodsReceiptDataSource _receiptDataSource;

  final ProductsDataSource _productsDataSource;

  final ContainerDataSource _containersDataSource;

  // api objects
  final GoodsReceiptApi _receiptApi;

  // constructor
  GoodsReceiptRepositoryImpl(this._receiptApi, this._receiptDataSource,
      this._productsDataSource, this._containersDataSource);

  // Post: ---------------------------------------------------------------------
  @override
  Future<GoodsReceiptData> getGoodsReceipt() async {
    // check to see if posts are present in database, then fetch from database
    // else make a network call to get all posts, store them into database for
    // later use
    return await _receiptApi.getPackingReceive().then((receiptData) {
      receiptData.content.forEach((post) {
        _receiptDataSource.insert(post);
      });

      return receiptData;
    }).catchError((error) => throw error);
  }

  @override
  Future<List<GoodsReceipt>> findPostById(int id) {
    //creating filter
    List<Filter> filters = [];

    //check to see if dataLogsType is not null
    Filter dataLogTypeFilter = Filter.equals(DBConstants.FIELD_ID, id);
    filters.add(dataLogTypeFilter);

    //making db call
    return _receiptDataSource
        .getAllSortedByFilter(filters: filters)
        .then((posts) => posts)
        .catchError((error) => throw error);
  }

  @override
  Future<int> insert(GoodsReceipt good) => _receiptDataSource
      .insert(good)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<int> update(GoodsReceipt good) => _receiptDataSource
      .update(good)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<int> delete(GoodsReceipt good) => _receiptDataSource
      .update(good)
      .then((id) => id)
      .catchError((error) => throw error);

  @override
  Future<List<String>> getProducts() async {
    return _receiptApi.getProducts().then((value) async {
      var sortedValue = value.map((e) => e.toLowerCase()).toSet().map((e2) {
        var index = value.map((e) => e.toLowerCase()).toList().indexOf(e2);
        return value[index];
      }).toList();

      await _productsDataSource.getProductsFromDb().then(
        (value2) {
          var unmatchedElements = value2
              .where((element) => !sortedValue.contains(element))
              .toList();
          for (var i in unmatchedElements) {
            _productsDataSource.insert(i);
          }
        },
      );
      return sortedValue;
    });
  }

  Future<List<ContainerDropdownData>> getContainers() async {
    List<ContainerDropdownData> datas = [];
    await _receiptApi.getContainers().then((value) {
      for (ContainerListContent e in value.content) {
        try {
          datas.add(ContainerDropdownData(
              id: e.id, name: e.history!.packing!.containerNoInternal));
          print('heh' + e.id);
        } catch (e) {
          print('error 1');
        }
      }
    });

    return datas;
  }

  Future<List<PackingContent>> getPackingContent() async {
    List<PackingContent> datas = [];
    await _receiptApi.getPackingContent().then((value) {
      datas = List.from(value);
    });
    return datas;
  }
}
