// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:apex_smartpay_mobile_test/data/cache/shared_preference_service.dart'
    as _i6;
import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart'
    as _i7;
import 'package:apex_smartpay_mobile_test/data/services/dio_wrapper/dio_client_wrapper.dart'
    as _i5;
import 'package:apex_smartpay_mobile_test/di/app_module.dart' as _i12;
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/cubit/get_token_cubit.dart'
    as _i9;
import 'package:apex_smartpay_mobile_test/presentation/home_screen/cubit/home_cubit.dart'
    as _i10;
import 'package:apex_smartpay_mobile_test/presentation/signin_screen/cubit/signin_cubit.dart'
    as _i11;
import 'package:apex_smartpay_mobile_test/presentation/signup_screen/cubit/signup_cubit.dart'
    as _i8;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:shared_preferences/shared_preferences.dart' as _i4;

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
    final appModule = _$AppModule();
    gh.lazySingleton<_i3.FlutterSecureStorage>(() => appModule.secureStorage);
    await gh.lazySingletonAsync<_i4.SharedPreferences>(
      () => appModule.sharedPref,
      preResolve: true,
    );
    gh.singleton<_i5.DioClientWrapper>(
        () => _i5.DioClientWrapper(gh<_i3.FlutterSecureStorage>()));
    gh.singleton<_i6.SharedPreferencesService>(
        () => _i6.SharedPreferencesService(gh<_i4.SharedPreferences>()));
    gh.factory<_i7.AuthRepository>(() => _i7.AuthRepository(
          gh<_i5.DioClientWrapper>(),
          gh<_i3.FlutterSecureStorage>(),
        ));
    gh.factory<_i8.SignUpCubit>(
        () => _i8.SignUpCubit(gh<_i7.AuthRepository>()));
    gh.factory<_i9.GetTokenCubit>(
        () => _i9.GetTokenCubit(gh<_i7.AuthRepository>()));
    gh.factory<_i10.HomeCubit>(() => _i10.HomeCubit(gh<_i7.AuthRepository>()));
    gh.factory<_i11.SignInCubit>(
        () => _i11.SignInCubit(gh<_i7.AuthRepository>()));
    return this;
  }
}

class _$AppModule extends _i12.AppModule {}
