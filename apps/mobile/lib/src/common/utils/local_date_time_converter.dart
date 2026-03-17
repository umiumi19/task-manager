import 'package:json_annotation/json_annotation.dart';

/// JSON の ISO8601 文字列と [DateTime] の双方向変換。
class LocalDateTimeConverter implements JsonConverter<DateTime?, String?> {
  const LocalDateTimeConverter();

  @override
  DateTime? fromJson(String? json) {
    if (json == null || json.isEmpty) return null;
    return DateTime.parse(json);
  }

  @override
  String? toJson(DateTime? object) {
    if (object == null) return null;
    return object.toIso8601String();
  }
}
