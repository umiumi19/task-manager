import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/utils/local_date_time_converter.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

/// public.users の 1 行（Backend GET /users/me のレスポンスと同形）。
@freezed
abstract class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    String? displayName,
    @LocalDateTimeConverter() required DateTime createdAt,
    @LocalDateTimeConverter() required DateTime updatedAt,
  }) = _AppUser;

  const AppUser._();

  factory AppUser.fromJson(Map<String, dynamic> json) =>
      _$AppUserFromJson(json);
}
