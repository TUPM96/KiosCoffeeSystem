import 'dart:convert';
import 'dart:io';

import 'package:boilerplate/constants/assets.dart';
import 'package:boilerplate/constants/dimens.dart';
import 'package:boilerplate/core/stores/global/global_variables.dart';
import 'package:boilerplate/data/network/constants/endpoints.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/di/service_locator.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/utils/conversion/extensions.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/material.dart';

import 'configs/dio_configs.dart';

class DioClient {
  final SharedPreferenceHelper prefs;
  final DioConfigs dioConfigs;
  final Dio _dio;

  final SharedPreferenceHelper storage = getIt<SharedPreferenceHelper>();
  final GlobalVariables _globalVariables = getIt<GlobalVariables>();

  DioClient({required this.dioConfigs, required this.prefs})
      : _dio = Dio()
          ..options.baseUrl = dioConfigs.baseUrl
          ..options.connectTimeout =
              Duration(milliseconds: dioConfigs.connectionTimeout)
          ..options.receiveTimeout =
              Duration(milliseconds: dioConfigs.receiveTimeout) {
    initDio();
  }

  initDio() async {
    _dio.options.receiveTimeout = Duration(milliseconds: 10000);
    _dio.options.connectTimeout = Duration(milliseconds: 10000);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          bool isConnected = await checkConnectivity();
          print(isConnected);

          if (!isConnected) {
            return handler.reject(
              DioException.connectionTimeout(
                timeout: _dio.options.connectTimeout!,
                requestOptions: RequestOptions(),
              ),
            );
          }

          // var token = await prefs.authToken;

          // if (token == null || token.isEmpty) {
          //   getIt<UserStore>().isLoggedIn = false;
          //   return handler
          //       .reject(DioException(requestOptions: RequestOptions()));
          // }

          return handler.next(options);
        },
        onError: (e, handler) async {
          var token = await prefs.authToken;

          if (token == null || token.isEmpty) {
            getIt<UserStore>().isLoggedIn = false;
            return handler
                .reject(DioException(requestOptions: RequestOptions()));
          }
          if (e.type == DioExceptionType.badResponse &&
              e.message!.toLowerCase() == 'unauthenticated') {
            getIt<UserStore>().isLoggedIn = false;
            return handler.reject(
              DioException.badResponse(
                statusCode: 401,
                requestOptions: RequestOptions(),
                response: Response(
                  requestOptions: RequestOptions(),
                  data: {'message': 'Unauthenticated'},
                ),
              ),
            );
          }
        },
      ),
    );

    (_dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
      var client = new HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) {
        return true;
      };
      return client;
    };
  }

  Dio get dio => _dio;

  String get url => Endpoints.baseUrl;

  Dio addInterceptors(Iterable<Interceptor> interceptors) {
    return _dio..interceptors.addAll(interceptors);
  }

  Future<Response> getData(String path) async {
    _dio.options.headers = await addAuthorOpt();
    try {
      var response = await _dio.get(path);
      return response;
    } on DioException catch (ex) {
      throw Exception(json.decode(ex.response.toString())['message']);
    }
  }

  Future<Response> postData(String path, dynamic data) async {
    _dio.options.headers = await addAuthorOpt();
    try {
      var response = await _dio.post(path, data: data);
      return response;
    } on DioException catch (ex) {
      throw Exception(json.decode(ex.response.toString())['message']);
    }
  }

  Future<Map<String, dynamic>?> addAuthorOpt() async {
    var token = await storage.authToken;
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  Future<bool> checkConnectivity() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    print(connectivityResult.toString());
    if (connectivityResult == ConnectivityResult.none) {
      noInternetWarning();
      return false;
    } else {
      return true;
    }
  }

  noInternetWarning() async {
    var context = _globalVariables.scaffoldKey.currentContext!;

    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                Assets.noInternetIcon,
                height: 100,
                width: double.infinity,
              ),
              Dimens.vSpaceMedium,
              Text(
                'Oops!',
                style: context.textTheme.titleMedium,
              ),
              Dimens.vSpaceSmall,
              Text(
                'No Internet Connection',
                style: context.textTheme.titleMedium,
              ),
              Dimens.vSpaceSmall,
              Text(
                'Please check your internet conenction and try again',
                style: context.textTheme.bodyMedium,
              ),
            ],
          ),
        );
      },
    );
  }
}
