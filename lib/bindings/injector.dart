import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../router/app_router.dart';
import '../services/network/dio_provider.dart';
import '../services/storage_manager/hive/hive_service.dart';
import 'injector.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: false)
Future<void> configureDependencies() async => getIt.init();

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> prefs() => SharedPreferences.getInstance();

  @preResolve
  Future<HiveService> hiveService() async {
    final hiveService = await HiveService.init();
    return hiveService;
  }

  @singleton
  Dio get getDio => DioProvider.dioWithHeaderToken;

  @singleton
  GoRouter get goRoute => goRouter();
}
