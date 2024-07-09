import 'package:apex_smartpay_mobile_test/data/models/home.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.initial() = _Initial;
  const factory HomeState.loading() = Loading;
  const factory HomeState.error({required String errorMessage, Map<String, List<String>>? errors}) = Error;
  const factory HomeState.success({required HomeResponse response}) = Success;
}