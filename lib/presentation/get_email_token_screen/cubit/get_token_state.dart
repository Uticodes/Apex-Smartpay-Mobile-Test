import 'package:apex_smartpay_mobile_test/data/models/get_email_token.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/verify_email_token.dart';

part 'get_token_state.freezed.dart';

@freezed
class GetTokenState with _$GetTokenState {
  const factory GetTokenState.initial() = _Initial;
  const factory GetTokenState.loading() = Loading;
  const factory GetTokenState.error({required String errorMessage, Map<String, List<String>>? errors}) = Error;
  const factory GetTokenState.success({required GetEmailTokenResponse response}) = Success;
  const factory GetTokenState.verifyEmailToken({required VerifyEmailTokenResponse response}) = VerifySuccess;
}