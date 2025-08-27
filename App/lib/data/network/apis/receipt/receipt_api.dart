import 'dart:async';

import 'package:boilerplate/core/data/network/dio/dio_client.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt.dart';
import 'package:boilerplate/domain/entity/receipt/goods_receipt_response.dart';
import 'package:boilerplate/domain/entity/receipt/packing_response.dart';
import 'package:dio/dio.dart';

class GoodsReceiptApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  GoodsReceiptApi(this._dioClient, this._restClient);

  final String _receiptUrl = Endpoints.receiptUrl;
  final String _productsUrl = Endpoints.productUrl;
  final String _receiveUrl = Endpoints.mainReceiveUrl;
  final String _packingUrl = Endpoints.packingUrl;

  /// Returns list of post in response
  Future<GoodsReceiptData> getPackingReceive() async {
    late GoodsReceiptData receiptsData;

    await _dioClient.getData(_receiptUrl).then((value) {
      if (value.statusCode == 200) {
        var data = GoodsReceiptResponse.fromJson(value.data);
        var index = 0;
        var contents = <GoodsReceipt>[];

        for (var i in data.goodsData.content) {
          var addedIdContent = i.copyWith(id: index.toString());
          contents.add(addedIdContent);
          index++;
        }

        receiptsData = data.goodsData.copyWith(content: contents);
      } else {
        var message = value.data['message'];
        print(message);
        throw DioException(
          message: message,
          response: value.data,
          requestOptions: RequestOptions(),
        );
      }
    });

    return receiptsData;
  }

  Future<List<String>> getProducts() async {
    List<String> products = [];

    await _dioClient.getData(_productsUrl).then((value) {
      if (value.statusCode == 200) {
        List<dynamic> contentList = value.data['data']['content'];
        for (var i in contentList) {
          products.add(
            i['name'],
          );
        }
      } else {
        var message = value.data['message'];
        print(message);
        throw DioException(
          message: message,
          response: value.data,
          requestOptions: RequestOptions(),
        );
      }
    });

    return products;
  }

  Future<ContainerListData> getContainers() async {
    late ContainerListData containerListData;
    try {
      await _dioClient.getData(_receiveUrl).then((value) {
        if (value.statusCode == 200) {
          var data = ContainerListResponse.fromJson(value.data);

          containerListData = data.data;
        } else {
          var message = value.data['message'];
          throw DioException(
            message: message,
            response: value.data,
            requestOptions: RequestOptions(),
          );
        }
      });
    } on DioException catch (ex) {
      switch (ex.type) {
        case DioExceptionType.connectionTimeout:
          throw Exception('Connection timeout');
        case DioExceptionType.sendTimeout:
          throw Exception('Send Connection timeout');
        case DioExceptionType.receiveTimeout:
          throw Exception('Receive Connection timeout');
        case DioExceptionType.badCertificate:
          throw Exception('Bad Certificate Issue');
        case DioExceptionType.badResponse:
          throw Exception('Bad Response');
        case DioExceptionType.cancel:
          throw Exception('Cancel Exception');
        case DioExceptionType.connectionError:
          throw Exception('Connection Error');
        case DioExceptionType.unknown:
          throw Exception('Unknown Error');
      }
    } on TypeError catch (ex) {
      throw ex;
    }

    return containerListData;
  }

  Future<List<PackingContent>> getPackingContent() async {
    List<PackingContent> packingContent = [];
    await _dioClient.getData(_packingUrl).then((value) {
      if (value.statusCode == 200) {
        PackingResponse packingResponse = PackingResponse.fromJson(value.data);
        for (var i in packingResponse.data.content) {
          packingContent.add(i);
        }
      } else {
        var message = value.data['message'];
        print(message);
        throw DioException(
          message: message,
          response: value.data,
          requestOptions: RequestOptions(),
        );
      }
    });

    return packingContent;
  }
}
