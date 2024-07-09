import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart';
import 'package:apex_smartpay_mobile_test/data/services/dio_wrapper/dio_client_wrapper.dart';
import 'package:apex_smartpay_mobile_test/presentation/signup_screen/cubit/signup_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final AuthRepository _authRepository;

  SignUpCubit(this._authRepository) : super(const SignUpState.initial());

  Future<void> registerUser(
      {required String fullName,
      required String userName,
      required String email,
      required String country,
      required String password}) async {
    emit(const SignUpState.loading());
    try {
      final response = await _authRepository.registerUser(
          fullName: fullName,
          userName: userName,
          email: email,
          country: country,
          password: password);
      emit(SignUpState.success(response: response));
    } on SmartPayAppException catch (exception, stackTrace) {
      debugPrint("SmartPayAppException: $exception, $stackTrace");
      emit(SignUpState.error(
          errorMessage: exception.errorMessage, errors: exception.errors));
    } catch (error) {
      emit(SignUpState.error(errorMessage: error.toString()));
    }
  }
}
