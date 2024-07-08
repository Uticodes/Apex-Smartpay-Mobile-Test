import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'smartpay_user.freezed.dart';

part 'smartpay_user.g.dart';

@freezed
class SmartPayUser with _$SmartPayUser {
  factory SmartPayUser({
    @JsonKey(name: "id") required String id,
    @JsonKey(name: "full_name") required String fullName,
    @JsonKey(name: "username") @Default('') String userName,
    @JsonKey(name: "email") required String email,
    @JsonKey(name: "phone") String? phoneNumber,
    @JsonKey(name: "phone_country") String? phoneCountry,
    @JsonKey(name: "country") String? country,
    @JsonKey(name: "avatar") String? avatar,
    @JsonKey(name: "token") String? token,
  }) = _SmartPayUser;

  SmartPayUser._();

  factory SmartPayUser.fromJson(Map<String, dynamic> json) => _$SmartPayUserFromJson(json);
}
