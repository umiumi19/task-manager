# Step 5: 仮認証を本認証に置き換え（実装済み）

x-user-id を廃止し、Supabase Auth の JWT 検証に統一しました。

## バックエンドの動き

1. **認証ミドルウェア**（`src/middleware/auth.ts`）
   - `Authorization: Bearer <access_token>` を必須とする
   - `supabase.auth.getUser(token)` でトークンを検証
   - 成功時: `c.set('user', user)` と `c.set('userId', user.id)` でコンテキストにセット
   - 失敗時: 401 Unauthorized

2. **環境変数**
   - `SUPABASE_URL` と `SUPABASE_ANON_KEY` を必須に変更（`.env` に設定）

3. **OpenAPI**
   - `/docs` の仕様に Bearer JWT の securityScheme を追加（Scalar の「Authorize」でトークン設定可能）

## クライアント（Flutter）でやること

1. **Supabase でログイン**し、access token を保持する  
   - 本プロジェクトでは **メール＋パスワード**（`signInWithPassword` / `signUp`）で認証。
2. **API 呼び出し時に** `Authorization: Bearer <access_token>` を付与する（例: Dio の Interceptor）
3. **401 が出た場合**  
   - トークン期限切れならリフレッシュして再試行  
   - リフレッシュできない場合はログイン画面へ

### Flutter 側の実装（apps/mobile）

- **AuthRepository**（`auth_repository.dart`）: `signInWithPassword` / `signUp` / `signOut` / `authStateChanges` / `accessToken`
- **ログイン画面**（`login_page.dart`）: メール・パスワード入力 → サインイン → ホームへ
- **サインアップ画面**（`sign_up_page.dart`）: メール・パスワード入力 → サインアップ（メール確認の有無は Supabase の「Auth > Email Auth」設定に依存）
- **ホーム**（`home_page.dart`）: ログイン中メール表示・サインアウト
- 未ログイン時はログイン画面へリダイレクト、ログイン中にログイン/サインアップ URL へ行った場合はホームへリダイレクト

## 参考（別プロジェクト clalin との対応）

| 役割           | 本プロジェクト（task_manager）     |
|----------------|------------------------------------|
| トークン検証   | `auth_middleware` で `supabase.auth.getUser(token)` |
| userId の参照  | ハンドラー内で `c.get('userId')`（従来どおり） |
| ユーザー情報   | `c.get('user')` で Supabase の User オブジェクトも参照可能 |

x-user-id は使用していません。認証は **Authorization: Bearer &lt;token&gt;** のみです。
