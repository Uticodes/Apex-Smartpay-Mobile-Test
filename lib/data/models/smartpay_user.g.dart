// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'smartpay_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SmartPayUserImpl _$$SmartPayUserImplFromJson(Map<String, dynamic> json) =>
    _$SmartPayUserImpl(
      id: json['id'] as String,
      fullName: json['full_name'] as String,
      userName: json['username'] as String? ?? '',
      email: json['email'] as String,
      phoneNumber: json['phone'] as String?,
      phoneCountry: json['phone_country'] as String?,
      country: json['country'] as String?,
      avatar: json['avatar'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$$SmartPayUserImplToJson(_$SmartPayUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'username': instance.userName,
      'email': instance.email,
      'phone': instance.phoneNumber,
      'phone_country': instance.phoneCountry,
      'country': instance.country,
      'avatar': instance.avatar,
      'token': instance.token,
    };
