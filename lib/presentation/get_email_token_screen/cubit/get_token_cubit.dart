import 'package:apex_smartpay_mobile_test/data/repositories/auth_repository/auth_repository.dart';
import 'package:apex_smartpay_mobile_test/data/services/dio_wrapper/dio_client_wrapper.dart';
import 'package:apex_smartpay_mobile_test/presentation/get_email_token_screen/cubit/get_token_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';

@injectable
class GetTokenCubit extends Cubit<GetTokenState> {
  final AuthRepository _authRepository;

  GetTokenCubit(this._authRepository) : super(const GetTokenState.initial());

  Future<void> getEmailToken(String email) async {
    emit(const GetTokenState.loading());
    try {
      final response = await _authRepository.getEmailToken(email);
      emit(GetTokenState.success(response: response));
    } on SmartPayAppException catch (exception, stackTrace) {
      debugPrint("SmartPayAppException: $exception, $stackTrace");
      emit(GetTokenState.error(errorMessage: exception.errorMessage));
    } catch (error) {
      emit(GetTokenState.error(errorMessage: error.toString()));
    }
  }

  Future<void> verifyEmailToken(String email, String token) async {
    emit(const GetTokenState.loading());
    try {
      final response = await _authRepository.verifyEmailToken(email, token);
      emit(GetTokenState.verifyEmailToken(response: response));
    } on SmartPayAppException catch (exception, stackTrace) {
      debugPrint("SmartPayAppException: $exception, $stackTrace");
      emit(GetTokenState.error(errorMessage: exception.errorMessage));
    } catch (error) {
      emit(GetTokenState.error(errorMessage: error.toString()));
    }
  }

}