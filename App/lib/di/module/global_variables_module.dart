import 'package:boilerplate/core/stores/global/global_variables.dart';
import 'package:boilerplate/di/service_locator.dart';

mixin GlobalVariablesModule {
  static Future<void> configureGlobalVariables() async {
    await getIt.registerSingleton<GlobalVariables>(GlobalVariables());
  }
}
