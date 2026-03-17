import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'api_config.dart';
import '../../features/auth/application/auth_repository.dart';

/// Backend API 用の Dio クライアント。
/// [AuthRepository] の accessToken を Authorization: Bearer で付与する。
Dio createApiDio(AuthRepository authRepository) {
  final dio = Dio(
    BaseOptions(
      baseUrl: apiBaseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ),
  );
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        final token = authRepository.accessToken;
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
          debugPrint('[API] Request with Bearer token: ${options.uri}');
        } else {
          debugPrint(
            '[API] Request WITHOUT token (session may not be restored yet): ${options.uri}',
          );
        }
        return handler.next(options);
      },
      onError: (error, handler) {
        debugPrint(
          '[API Error] ${error.requestOptions.method} ${error.requestOptions.uri}',
        );
        debugPrint(
          '[API Error] status: ${error.response?.statusCode} message: ${error.message}',
        );
        if (error.response?.data != null) {
          debugPrint('[API Error] body: ${error.response?.data}');
        }
        return handler.next(error);
      },
    ),
  );
  return dio;
}
