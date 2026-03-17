import 'package:dio/dio.dart';

import '../domain/app_user.dart';

class UsersRepository {
  UsersRepository(this._dio);

  final Dio _dio;

  static const _path = '/users';

  /// 認証中ユーザーの public.users を取得。
  Future<AppUser> getMe() async {
    final response = await _dio.get<Map<String, dynamic>>('$_path/me');
    return AppUser.fromJson(response.data!);
  }
}
