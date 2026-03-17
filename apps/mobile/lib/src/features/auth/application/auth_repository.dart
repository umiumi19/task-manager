import 'package:supabase_flutter/supabase_flutter.dart';

/// Supabase Auth（メール＋パスワード）の操作をまとめたリポジトリ。
/// サインイン・サインアップ・サインアウトとセッション/トークン取得を提供する。
class AuthRepository {
  AuthRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  final SupabaseClient _client;

  GoTrueClient get _auth => _client.auth;

  /// メール＋パスワードでサインイン。
  Future<AuthResponse> signInWithPassword({
    required String email,
    required String password,
  }) {
    return _auth.signInWithPassword(email: email, password: password);
  }

  /// メール＋パスワードでサインアップ。
  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) {
    return _auth.signUp(email: email, password: password);
  }

  /// サインアウト。
  Future<void> signOut() => _auth.signOut();

  /// 認証状態の変化ストリーム（ルーターのリフレッシュ用）。
  Stream<AuthState> authStateChanges() => _auth.onAuthStateChange;

  /// 現在のセッション。未ログインなら null。
  Session? get currentSession => _auth.currentSession;

  /// 現在のユーザー。未ログインなら null。
  User? get currentUser => _auth.currentUser;

  /// API 呼び出し用のアクセストークン。未ログインなら null。
  String? get accessToken => currentSession?.accessToken;
}
