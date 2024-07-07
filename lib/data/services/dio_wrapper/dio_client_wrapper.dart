import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

typedef ProgressCallback = void Function(int count, int total);

@injectable
class DioClientWrapper {
  final FlutterSecureStorage _secureStorage;

  Dio? _dioClient;

  DioClientWrapper(this._secureStorage);

  Future<void> initialize() async {
    _dioClient = Dio(await _baseOptions);
  }

  Future<BaseOptions> get _baseOptions async {
    final String? accessToken = await _secureStorage.read(key: 'accessToken');
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
        () => _dioClient!.get(url, options: options, queryParameters: data));
  }

  Future<Response<dynamic>> post(
    url,
    data, {
    Options? options,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
  }) async {
    return _makeRequest(() => _dioClient!.post(url,
        data: data,
        options: options,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress));
  }

  Future<Response<dynamic>> put(url, data, {Options? options}) async {
    return _makeRequest(
        () => _dioClient!.put(url, data: data, options: options));
  }

  Future<Response<dynamic>> patch(url, {Options? options, dynamic data}) async {
    return _makeRequest(
        () => _dioClient!.patch(url, data: data, options: options));
  }

  Future<Response<dynamic>> delete(url,
      {Options? options, dynamic data}) async {
    return _makeRequest(
        () => _dioClient!.delete(url, data: data, options: options));
  }

  Future<Response<dynamic>> _makeRequest(
      Future<Response<dynamic>> Function() dioRequest) async {
    try {
      return await dioRequest.call();
    } on DioException catch (e) {
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
          if (e.response == null)
            throw SmartPayAppException("An unknown error occurred");
          switch (e.response!.statusCode) {
            case 409:
            case 400:
              debugPrint("server error is ${e.response!.data}");
              final errorMap = e.response!.data;
              String message;
              if (errorMap["error"] == null) {
                message = errorMap["message"];
              } else {
                message = errorMap["error"];
              }
              return throw SmartPayAppException(message);
            case 401:
              return throw SmartPayAppException("Authorization error");
            case 404:
              throw SmartPayAppException("Resource not found");
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
}

class SmartPayAppException implements Exception {
  final String errorMessage;

  SmartPayAppException(this.errorMessage);

  @override
  String toString() {
    return 'AppException{errorMessage: $errorMessage}';
  }
}
