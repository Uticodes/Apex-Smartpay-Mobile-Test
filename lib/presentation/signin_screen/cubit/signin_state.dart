import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/login_user.dart';

part 'signin_state.freezed.dart';

@freezed
class SignInState with _$SignInState {
  const factory SignInState.initial() = _Initial;
  const factory SignInState.loading() = Loading;
  const factory SignInState.error({required String errorMessage, Map<String, List<String>>? errors}) = Error;
  const factory SignInState.success({required LoginUserResponse response}) = Success;
}