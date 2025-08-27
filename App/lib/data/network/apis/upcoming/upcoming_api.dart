import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:flutter/services.dart';

class UpcomingApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  UpcomingApi(this._dioClient, this._restClient);

  /// Returns list of post in response
  Future<List<GoodsReceipt>> getUpcomingContainers() async {
    try {
      // final res = await _dioClient.dio.get(Endpoints.getPosts);
      final data =
          await rootBundle.loadString("assets/json/goods_receipt.json");
      return [];
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// sample api call with default rest client
//  Future<PostsList> getPosts() {
//
//    return _restClient
//        .get(Endpoints.getPosts)
//        .then((dynamic res) => PostsList.fromJson(res))
//        .catchError((error) => throw NetworkException(message: error));
//  }
}
