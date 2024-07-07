import 'package:apex_smartpay_mobile_test/data/models/register_user.dart';
import 'package:apex_smartpay_mobile_test/utils/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../models/get_email_token.dart';
import '../../models/home.dart';
import '../../models/login_user.dart';
import '../../models/verify_email_token.dart';
import '../../services/dio_wrapper/dio_client_wrapper.dart';

@injectable
class AuthRepository {
  final DioClientWrapper _dioClient;
  final FlutterSecureStorage _secureStorage;

  AuthRepository(this._dioClient, this._secureStorage);

  Future<RegisterUserResponse> register({
    required String fullName,
    required String userName,
    required String email,
    required String country,
    required String password
  }) async {

    final body = {
      'full_name': fullName,
      'username': userName,
      'email': email,
      'country': country,
      'password': password,
      'device_name': 'mobile'
    };

    debugPrint("registration body is: $body");
    final response = await _dioClient.post('/auth/register', body);
    return RegisterUserResponse.fromJson(response.data);
  }

  Future<LoginUserResponse> login(String email, String password) async {
    final body = {
      'email': email,
      'password': password,
      'device_name': "mobile"
    };

    debugPrint("login body is: $body");
    final response = await _dioClient.post('/auth/login', body);
    return LoginUserResponse.fromJson(response.data);
  }

  Future<GetEmailTokenResponse> getEmailToken(String email) async {
    final body = {'email': email};
    debugPrint("getEmailToken body is: $body");
    final response = await _dioClient.post('/auth/email', body);
    return GetEmailTokenResponse.fromJson(response.data);
  }

  Future<VerifyEmailTokenResponse> verifyEmailToken(String email, String token) async {
    final body = {'email': email, 'token': token};
    debugPrint("verifyEmailToken body is: $body");
    final response = await _dioClient.post('/auth/email/verify', body);
    return VerifyEmailTokenResponse.fromJson(response.data);
  }

  Future<HomeResponse> getSecret() async {
    final response = await _dioClient.get("/dashboard");
    return HomeResponse.fromJson(response.data);
  }

  Future<void> logout() async {
    final response = await _dioClient.post('/auth/logout', {});
    if (response.data['status']) {
      await _secureStorage.delete(key: AppKeys.accessToken);
    } else {
      throw SmartPayAppException(response.data['message']);
    }
  }

}