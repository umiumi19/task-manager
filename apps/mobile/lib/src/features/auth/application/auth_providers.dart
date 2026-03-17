import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../core/api/api_providers.dart';
import '../data/users_repository.dart';
import '../domain/app_user.dart';
import 'auth_repository.dart';

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

/// 現在の Supabase Auth ユーザー。未ログインなら null。
final currentUserProvider = Provider<User?>((ref) {
  return Supabase.instance.client.auth.currentUser;
});

final usersRepositoryProvider = Provider<UsersRepository>((ref) {
  final dio = ref.watch(apiDioProvider);
  return UsersRepository(dio);
});

/// 認証中ユーザーの public.users を取得。未ログインなら null。
final currentAppUserProvider = FutureProvider.autoDispose<AppUser?>((ref) async {
  final authUser = ref.watch(currentUserProvider);
  if (authUser == null) return null;
  try {
    final repo = ref.watch(usersRepositoryProvider);
    return await repo.getMe();
  } catch (_) {
    return null;
  }
});

/// ルーターのリダイレクト用。認証状態が変わるたびに GoRouter がリフレッシュされるようにする。
final authStateProvider = Provider<Listenable>((ref) {
  final auth = ref.watch(authRepositoryProvider);
  return GoRouterRefreshStream(auth.authStateChanges());
});

/// [Stream] の購読結果で [notifyListeners] する [ChangeNotifier]。
/// GoRouter の [refreshListenable] に渡して、認証状態変化でリダイレクトをやり直す。
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<AuthState> stream) {
    _subscription = stream.listen((_) => notifyListeners());
  }

  late final StreamSubscription<AuthState> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
