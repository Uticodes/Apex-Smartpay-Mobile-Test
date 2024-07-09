import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/smartpay_user.dart';

@singleton
class SharedPreferencesService {
  final SharedPreferences _sharedPreferences;

  static const _userAccessToken = 'access_token';
  static const _userVerificationToken = 'verification_token';
  static const _userInfo = 'user_info';
  static const _hasOnBoarded = 'has_onboarded';
  static const _hasPin = 'has_pin';

  SharedPreferencesService(this._sharedPreferences);

  Future<void> clear(BuildContext context) async {
    await _sharedPreferences.clear();
    await setHasOnboarded();
  }

  Future<bool> saveUserAccessToken(String accessToken) async {
    await _sharedPreferences.setString(_userAccessToken, accessToken);
    return true;
  }

  Future<bool> saveUserVerificationToken(String verificationToken) async {
    return await _sharedPreferences.setString(_userVerificationToken, verificationToken);
  }

  Future<bool> setHasOnboarded() async {
    return await _sharedPreferences.setBool(_hasOnBoarded, true);
  }

  Future<bool> setHasSetPin() async {
    return await _sharedPreferences.setBool(_hasPin, true);
  }

  Future<bool> saveUserInfo(SmartPayUser smartPayUser, {String? token}) async {
    if (token != null) smartPayUser = smartPayUser.copyWith(token: token);
    return await _sharedPreferences.setString(_userInfo, jsonEncode(smartPayUser));
  }

  String get accessToken {
    final String? userAccessToken = _sharedPreferences.getString(_userAccessToken);
    return userAccessToken ?? '';
  }

  String get verificationToken => _sharedPreferences.getString(_userVerificationToken) ?? "";

  bool get hasOnboarded => _sharedPreferences.getBool(_hasOnBoarded) ?? false;

  bool get hasPin => _sharedPreferences.getBool(_hasPin) ?? false;

  SmartPayUser? get currentUserInfo {
    try {
      final String? cachedUserInfoData = _sharedPreferences.getString(_userInfo);
      if (cachedUserInfoData == null) return null;
      return SmartPayUser.fromJson(jsonDecode(cachedUserInfoData));
    } catch (exception) {
      return null;
    }
  }

}
