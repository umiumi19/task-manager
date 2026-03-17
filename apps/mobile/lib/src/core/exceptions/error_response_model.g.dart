// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ErrorResponseModel _$ErrorResponseModelFromJson(Map<String, dynamic> json) =>
    _ErrorResponseModel(
      message: json['message'] as String,
      code: json['code'] as String,
    );

Map<String, dynamic> _$ErrorResponseModelToJson(_ErrorResponseModel instance) =>
    <String, dynamic>{'message': instance.message, 'code': instance.code};
