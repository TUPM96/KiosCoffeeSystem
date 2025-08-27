import 'dart:async';

import 'package:boilerplate/data/local/datasources/container/container_datasource.dart';
import 'package:boilerplate/data/local/datasources/products/products_datasource.dart';
import 'package:boilerplate/data/local/datasources/receipt/receipt_datasource.dart';
import 'package:boilerplate/data/network/apis/container/container_api.dart';
import 'package:boilerplate/data/network/apis/receipt/receipt_api.dart';
import 'package:boilerplate/data/network/apis/user/user_api.dart';
import 'package:boilerplate/data/repository/container/container_repository_impl.dart';
import 'package:boilerplate/data/repository/profile/profile_repository_impl.dart';
import 'package:boilerplate/data/repository/receipt/receipt_repository_impl.dart';
import 'package:boilerplate/data/repository/receipt/setting/setting_repository_impl.dart';
import 'package:boilerplate/data/repository/user/user_repository_impl.dart';
import 'package:boilerplate/data/sharedpref/shared_preference_helper.dart';
import 'package:boilerplate/domain/repository/container/container_repository.dart';
import 'package:boilerplate/domain/repository/profile/profile_repository.dart';
import 'package:boilerplate/domain/repository/receipt/receipt_repository.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';

mixin RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(
        UserRepositoryImpl(getIt<SharedPreferenceHelper>(), getIt<UserApi>()));

    getIt.registerSingleton<ProfileRepository>(ProfileRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<GoodsReceiptRepository>(
      GoodsReceiptRepositoryImpl(
        getIt<GoodsReceiptApi>(),
        getIt<GoodsReceiptDataSource>(),
        getIt<ProductsDataSource>(),
        getIt<ContainerDataSource>(),
      ),
    );

    getIt.registerSingleton<ContainerRepository>(ContainerRepositoryImpl(
      getIt<ContainerDataSource>(),
      getIt<ContainerApi>(),
    ));
  }
}
