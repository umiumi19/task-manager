import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../common/constants/error_codes.dart';
import '../../common/constants/error_messages.dart';

part 'error_response_model.freezed.dart';
part 'error_response_model.g.dart';

@freezed
abstract class ErrorResponseModel with _$ErrorResponseModel {
  const factory ErrorResponseModel({
    required String message,
    required String code,
  }) = _ErrorResponseModel;

  factory ErrorResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ErrorResponseModelFromJson(json);

  static String getErrorMessage(dynamic data) {
    try {
      final dioExeption = data as DioException?;
      if (dioExeption == null) {
        return ErrorMessages.unknown;
      }

      final errorResponse = dioExeption.response?.data as Map<String, dynamic>?;

      final error = errorResponse?['error'] as Map<String, dynamic>?;

      if (error == null) {
        return ErrorMessages.unknown;
      }

      final errorResopnse = ErrorResponseModel.fromJson(error);

      final errorCode = errorResopnse.code;

      switch (errorCode) {
        case ErrorCodes.tooSmall:
          return ErrorMessages.tooSmall;
        case ErrorCodes.invalidString:
          return ErrorMessages.invalidString;
        case ErrorCodes.emailNotConfirmed:
          return ErrorMessages.emailNotConfirmed;
        case ErrorCodes.userAlreadyExists:
          return ErrorMessages.userAlreadyExists;
        case ErrorCodes.weakPassword:
          return ErrorMessages.weakPassword;
        case ErrorCodes.invalidCredentials:
          return ErrorMessages.invalidCredentials;
        case ErrorCodes.validationFailed:
          return ErrorMessages.validationFailed;
        case ErrorCodes.otpExpired:
          return ErrorMessages.otpExpired;
        default:
          return ErrorMessages.unknown;
      }
    } on Exception {
      return ErrorMessages.unknown;
    }
  }

  // get error code
  static String? getErrorCode(dynamic data) {
    try {
      final errorResponse = ErrorResponseModel.fromJson(
        data as Map<String, dynamic>,
      );
      final errorCode = errorResponse.code;

      return errorCode;
    } on Exception {
      return null;
    }
  }
}
