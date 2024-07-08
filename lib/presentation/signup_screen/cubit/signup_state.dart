import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/models/register_user.dart';

part 'signup_state.freezed.dart';

@freezed
class SignUpState with _$SignUpState {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.loading() = Loading;
  const factory SignUpState.error({required String errorMessage, Map<String, List<String>>? errors}) = Error;
  const factory SignUpState.success({required RegisterUserResponse response}) = Success;
}