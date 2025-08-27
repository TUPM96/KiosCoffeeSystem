import 'dart:async';

import 'package:boilerplate/core/stores/error/error_store.dart';
import 'package:boilerplate/core/stores/form/form_store.dart';
import 'package:boilerplate/domain/repository/setting/setting_repository.dart';
import 'package:boilerplate/domain/usecase/container/get_container_detail_usecase.dart';
import 'package:boilerplate/domain/usecase/container/get_container_usecase.dart';
import 'package:boilerplate/domain/usecase/container/get_upcoming_container_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/get_profile_usecase.dart';
import 'package:boilerplate/domain/usecase/profile/logout_account_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/add_receipt_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_containers_dropdown_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_packing_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/fetch_products_dropdown_usecase.dart';
import 'package:boilerplate/domain/usecase/receipt/get_receipt_usecase.dart';
import 'package:boilerplate/domain/usecase/user/get_login_info_usecase.dart';
import 'package:boilerplate/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:boilerplate/domain/usecase/user/login_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_access_token_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_login_info_usecase.dart';
import 'package:boilerplate/domain/usecase/user/save_profile_usecase.dart';
import 'package:boilerplate/presentation/container/store/container_store.dart';
import 'package:boilerplate/presentation/home/store/language/language_store.dart';
import 'package:boilerplate/presentation/home/store/theme/theme_store.dart';
import 'package:boilerplate/presentation/login/store/login_store.dart';
import 'package:boilerplate/presentation/profile/store/profile_store.dart';
import 'package:boilerplate/presentation/receipt/add_receipt/store/add_goods_receipt_store.dart';
import 'package:boilerplate/presentation/receipt/store/goods_receipt_store.dart';
import 'package:boilerplate/presentation/upcoming/store/upcoming_container_store.dart';

import '../../../di/service_locator.dart';

mixin StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(UserStore(
      getIt<IsLoggedInUseCase>(),
      getIt<SaveLoginStatusUseCase>(),
      getIt<SaveAccessTokenUseCase>(),
      getIt<SaveProfileUseCase>(),
      getIt<SaveLoginInformationUseCase>(),
      getIt<GetLoginInfoUsecase>(),
      getIt<LoginUseCase>(),
      getIt<FormErrorStore>(),
      getIt<ErrorStore>(),
    ));

    getIt.registerSingleton<GoodsReceiptStore>(
      GoodsReceiptStore(
        getIt<GetGoodsReceiptUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<AddGoodsReceiptStore>(
      AddGoodsReceiptStore(
        getIt<AddGoodsReceiptUseCase>(),
        getIt<FetchProductsDropdownUsecase>(),
        getIt<FetchContainersDropdownUseCase>(),
        getIt<FetchPackingUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ContainerStore>(
      ContainerStore(
          getIt<GetContainerUseCase>(),
          getIt<GetContainerDetailUseCase>(),
          getIt<GetUpcomingContainerUseCase>(),
          getIt<ErrorStore>()),
    );

    getIt.registerSingleton<UpcomingContainerStore>(
      UpcomingContainerStore(
        getUpcomingContainerUseCase: getIt<GetUpcomingContainerUseCase>(),
        errorStore: getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ProfileStore>(
      ProfileStore(
        getIt<LogoutAccountUseCase>(),
        getIt<GetProfileUseCase>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
