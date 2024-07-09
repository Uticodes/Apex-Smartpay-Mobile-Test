import 'dart:io';

import 'package:apex_smartpay_mobile_test/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

typedef ProgressCallback = void Function(int count, int total);

@Singleton()
class DioClientWrapper {
  final FlutterSecureStorage _secureStorage;
  Dio? _dioClient;

  DioClientWrapper(this._secureStorage);

  Future<void> initialize() async {
    _dioClient = Dio(await _baseOptions);

    _dioClient!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final String? accessToken = await _secureStorage.read(key: AppKeys.accessToken);
          if (accessToken != null && accessToken.isNotEmpty) {
            options.headers[HttpHeaders.authorizationHeader] = 'Bearer $accessToken';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) {
          return handler.next(e);
        }
    ));
  }

  Future<BaseOptions> get _baseOptions async {
    final String? accessToken = await _secureStorage.read(key: AppKeys.accessToken);
    debugPrint("user token is: $accessToken");
    return BaseOptions(
      baseUrl: "https://mobile-test-2d7e555a4f85.herokuapp.com/api/v1",
      connectTimeout: const Duration(minutes: 1),
      receiveTimeout: const Duration(minutes: 1),
      contentType: 'application/json',
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        HttpHeaders.acceptHeader: 'application/json',
        if (accessToken != null && accessToken.isNotEmpty)
          HttpHeaders.authorizationHeader: 'Bearer $accessToken',
      },
    );
  }

  Future<Response<dynamic>> get(url, {Options? options, dynamic data}) async {
    return _makeRequest(
            () async => _dioClient!.get(url, options: options ?? await _getOption(), queryParameters: data));
  }

  Future<Response<dynamic>> post(
      url,
      data, {
        Options? options,
        ProgressCallback? onSendProgress,
        ProgressCallback? onReceiveProgress,
      }) async {
    return _makeRequest(() async => _dioClient!.post(url,
        data: data,
        options: options ?? await _getOption(),
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress));
  }

  Future<Response<dynamic>> put(url, data, {Options? options}) async {
    return _makeRequest(
            () async => _dioClient!.put(url, data: data, options: options ?? await _getOption()));
  }

  Future<Response<dynamic>> patch(url, {Options? options, dynamic data}) async {
    return _makeRequest(
            () async => _dioClient!.patch(url, data: data, options: options ?? await _getOption()));
  }

  Future<Response<dynamic>> delete(url,
      {Options? options, dynamic data}) async {
    return _makeRequest(
            () async => _dioClient!.delete(url, data: data, options: options ?? await _getOption()));
  }

  Future<Response<dynamic>> _makeRequest(
      Future<Response<dynamic>> Function() dioRequest) async {
    try {
      final String? accessToken = await _secureStorage.read(key: AppKeys.accessToken);
      debugPrint("Making request with token: $accessToken"); // Ensure this prints the correct token

      debugPrint("Request Headers: ${_dioClient?.options.headers}");
      return await dioRequest.call();
    } on DioException catch (e) {
      debugPrint("DioException: ${e.response?.data}");
      switch (e.type) {
        case DioExceptionType.connectionError:
        case DioExceptionType.sendTimeout:
        case DioExceptionType.receiveTimeout:
        case DioExceptionType.connectionTimeout:
          throw SmartPayAppException(
              "Your internet connection is unstable, please wait and try again");

        case DioExceptionType.cancel:
          throw SmartPayAppException("Request cancelled");

        case DioExceptionType.unknown:
          throw SmartPayAppException("An unknown error occurred");

        case DioExceptionType.badResponse:
          if (e.response == null) {
            throw SmartPayAppException("An unknown error occurred");
          }
          switch (e.response!.statusCode) {
            case 409:
            case 400:
              debugPrint("server error is ${e.response!.data}");
              final errorMap = e.response!.data;
              String message = errorMap["message"];
              Map<String, List<String>> errors = {};
              if (errorMap["errors"] != null) {
                errorMap["errors"].forEach((key, value) {
                  errors[key] = List<String>.from(value);
                });
              }
              throw SmartPayAppException(message, errors: errors);
            case 401:
              throw SmartPayAppException("Authorization error");
            case 404:
              throw SmartPayAppException("Resource not found");
            case 422:
              debugPrint("server error is ${e.response!.data}");
              final errorMap = e.response!.data;
              String message = errorMap["message"];
              Map<String, List<String>> errors = {};
              if (errorMap["errors"] != null) {
                errorMap["errors"].forEach((key, value) {
                  errors[key] = List<String>.from(value);
                });
              }
              throw SmartPayAppException(message, errors: errors);
            case 500:
              throw SmartPayAppException("Internal server error");
            default:
              throw SmartPayAppException("'Oops something went wrong'");
          }

        default:
          throw SmartPayAppException("An unknown error occurred");
      }
    } catch (e) {
      debugPrint(e.toString());
      throw SmartPayAppException("An unknown error occurred");
    }
  }

  Future<Options> _getOption({bool upload = false}) async {
    final String? token = await _secureStorage.read(key: AppKeys.accessToken);
    return Options(headers: {
      "Authorization": "Bearer $token",
      'Accept': 'application/json',
      'x-channel': 'mobile',
      if (upload) "Content-Disposition": "form-data",
      if (upload) "Content-Type": "multipart/form-data",
    });
  }
}

class SmartPayAppException implements Exception {
  final String errorMessage;
  final Map<String, List<String>>? errors;

  SmartPayAppException(this.errorMessage, {this.errors});

  @override
  String toString() {
    return 'SmartPayAppException{errorMessage: $errorMessage, errors: $errors}';
  }
}
