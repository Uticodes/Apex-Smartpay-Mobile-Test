import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart';
import 'package:apex_smartpay_mobile_test/data/services/dio_wrapper/dio_client_wrapper.dart';
import 'package:apex_smartpay_mobile_test/presentation/home_screen/cubit/home_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final AuthRepository _authRepository;

  HomeCubit(this._authRepository) : super(const HomeState.initial()) {
    getSecret();
  }

  Future<void> getSecret() async {
    emit(const HomeState.loading());
    try {
      final response = await _authRepository.getSecret();
      emit(HomeState.success(response: response));
    } on SmartPayAppException catch (exception, stackTrace) {
      debugPrint("SmartPayAppException: $exception, $stackTrace");
      emit(HomeState.error(
          errorMessage: exception.errorMessage, errors: exception.errors));
    } catch (error) {
      emit(HomeState.error(errorMessage: error.toString()));
    }
  }
}
