import 'package:boilerplate/di/module/global_variables_module.dart';
import 'package:boilerplate/presentation/di/module/store_module.dart';

mixin PresentationLayerInjection {
  static Future<void> configurePresentationLayerInjection() async {
    await StoreModule.configureStoreModuleInjection();
  }
}

mixin GlobalLayerInjection {
  static Future<void> configureGlobalLayerInjection() async {
    await GlobalVariablesModule.configureGlobalVariables();
  }
}
