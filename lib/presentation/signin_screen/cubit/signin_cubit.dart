import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart';
import 'package:apex_smartpay_mobile_test/data/services/dio_wrapper/dio_client_wrapper.dart';
import 'package:apex_smartpay_mobile_test/presentation/signin_screen/cubit/signin_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';

@injectable
class SignInCubit extends Cubit<SignInState> {
  final AuthRepository _authRepository;

  SignInCubit(this._authRepository) : super(const SignInState.initial());

  Future<void> login({required String email, required String password}) async {
    emit(const SignInState.loading());
    try {
      final response = await _authRepository.login(email, password);
      emit(SignInState.success(response: response));
    } on SmartPayAppException catch (exception, stackTrace) {
      debugPrint("SmartPayAppException: $exception, $stackTrace");
      emit(SignInState.error(
          errorMessage: exception.errorMessage, errors: exception.errors));
    } catch (error) {
      emit(SignInState.error(errorMessage: error.toString()));
    }
  }
}
