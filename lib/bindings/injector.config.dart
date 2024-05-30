// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:app_user/bindings/injector.dart' as _i16;
import 'package:app_user/modules/auth/data/datasource/auth_datasource.dart'
    as _i11;
import 'package:app_user/modules/auth/data/datasource/auth_datasource_impl.dart'
    as _i12;
import 'package:app_user/modules/auth/data/repositories/auth_remote_repository_impl.dart'
    as _i14;
import 'package:app_user/modules/auth/domain/repositories/auth_repository.dart'
    as _i13;
import 'package:app_user/modules/auth/domain/usecases/login_usecase.dart'
    as _i15;
import 'package:app_user/services/auth/auth_service.dart' as _i10;
import 'package:app_user/services/network/dio_provider.dart' as _i7;
import 'package:app_user/services/storage_manager/hive/hive_service.dart'
    as _i4;
import 'package:app_user/services/storage_manager/share_prefs/preference_manager.dart'
    as _i8;
import 'package:app_user/services/storage_manager/share_prefs/preference_manager_impl.dart'
    as _i9;
import 'package:dio/dio.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:go_router/go_router.dart' as _i6;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i1.GetIt> init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i3.SharedPreferences>(
      () => registerModule.prefs(),
      preResolve: true,
    );
    await gh.factoryAsync<_i4.HiveService>(
      () => registerModule.hiveService(),
      preResolve: true,
    );
    gh.singleton<_i5.Dio>(() => registerModule.getDio);
    gh.singleton<_i6.GoRouter>(() => registerModule.goRoute);
    gh.singleton<_i7.DioProvider>(() => _i7.DioProvider());
    gh.singleton<_i8.PreferenceManager>(() =>
        _i9.PreferenceManagerImpl(preferences: gh<_i3.SharedPreferences>()));
    gh.singleton<_i10.AuthService>(
      () => _i10.AuthService(gh<_i4.HiveService>()),
      dispose: (i) => i.dispose(),
    );
    gh.lazySingleton<_i11.AuthDataSource>(
        () => _i12.AuthDataSourceImpl(dio: gh<_i5.Dio>()));
    gh.lazySingleton<_i13.AuthRepository>(() => _i14.AuthRemoteRepositoryImpl(
        authDataSource: gh<_i11.AuthDataSource>()));
    gh.lazySingleton<_i15.LoginUseCase>(() => _i15.LoginUseCase(
          authRepository: gh<_i13.AuthRepository>(),
          authService: gh<_i10.AuthService>(),
        ));
    return this;
  }
}

class _$RegisterModule extends _i16.RegisterModule {}
