import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/network/rest_client.dart';
import 'package:boilerplate/domain/entity/container/container_data_list.dart';
import 'package:boilerplate/domain/entity/container/container_detail.dart';
import 'package:dio/dio.dart';

import '../../../../core/data/network/dio/dio_client.dart';

class ContainerApi {
  final DioClient _dioClient;

  final RestClient _restClient;

  ContainerApi(this._dioClient, this._restClient);

  final String _receiveUrl = Endpoints.mainReceiveUrl;

  Future<ContainerListData> getContainerList() async {
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

  Future<ContainerDetailModel> getContainerDetail(String id) async {
    late ContainerDetailModel containerDetailModel;
    try {
      final data = await _dioClient.getData(_receiveUrl + '/${id}');
      final mappedData = ContainerDetailModel.fromJson(data.data);
      // _restClient.get(path)
      return mappedData;
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
  }
}
