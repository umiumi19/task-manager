# Task Manager

**タスクと予定を一括管理するモバイルアプリ**です。  

---

## このリポジトリの特徴

- **フルスタック** … モノレポで Backend（Node/TypeScript）と Mobile（Flutter）を同一リポジトリで管理
- **API 設計** … RESTful API、OpenAPI（Scalar）による API ドキュメント、Zod によるバリデーション
- **認証** … Supabase Auth（メール/パスワード）を利用したログイン・サインアップと、API の JWT 検証
- **データベース** … Postgres + Drizzle ORM、マイグレーションの管理（Drizzle → Supabase ローカル）
- **モバイルアプリ** … Riverpod による状態管理、go_router による画面遷移、Dio による API 通信

---

## 主な機能

| 機能 | 説明 |
|------|------|
| **認証** | メール・パスワードでのサインアップ／ログイン、サインアウト |
| **タスク（Todos）** | タスクの一覧・追加・完了トグル。完了時は一覧を再取得せず UI だけ更新するよう配慮 |
| **予定（Schedules）** | 予定の一覧・追加（日時・タイトルなど） |
| **ホーム** | タブで「予定」「タスク」を切り替え、ログイン中ユーザー表示 |

---

## 拡張性・今後の展望

### 概要
ユーザーがあらかじめ登録した「固定の予定（授業・アルバイト・外出など）」「直近のタスク（優先度・見積工数）」「生活ルーティン（食事・睡眠など）」をもとに、AIがその日のタイムテーブルを自動生成する。
1日の終わりに、タスクの完了可否や実績時間・ズレた理由を入力すると、見積もり誤差や集中しやすい時間帯の傾向を反映して、翌日以降はより現実的で破綻しにくい予定を提案する。

### 具体的機能案

| 分野 | 内容 |
|------|------|
| **カレンダー** | 今日以外の予定も一覧・カレンダー表示で確認できるようにする |
| **お気に入り** | 予定・タスクのお気に入り登録で、よく使う項目を素早く参照 |
| **ユーザー** | パスワード変更など、アカウント・プロフィール周りの機能 |
| **AI 提案** | AI によるタスク配分の提案（優先度・時間帯の最適化など） |
| **24時間計画** | 1日のスケジュールを「24時間の計画」として立てるイメージの UI・フロー |

---

## 技術スタック

### Backend（`apps/backend`）

| 用途 | 技術 | 選定理由 |
|------|------|----------|
| ランタイム | Node.js (TypeScript) | 型安全に API を実装するため |
| Web フレームワーク | [Hono](https://hono.dev/) | 軽量・高速で TypeScript との相性が良いため |
| ORM | [Drizzle ORM](https://orm.drizzle.team/) | SQL に近い記述と型推論、マイグレーション管理のしやすさ |
| DB | PostgreSQL | Supabase ローカル／クラウドと統一 |
| 認証 | [Supabase Auth](https://supabase.com/docs/guides/auth) | JWT 検証をバックエンドで行い、API を保護 |
| API 仕様 | Zod + OpenAPI（@hono/zod-openapi） | リクエスト検証と API ドキュメント（Scalar）を一括で管理 |

### Mobile（`apps/mobile`）

| 用途 | 技術 | 選定理由 |
|------|------|----------|
| UI | Flutter | クロスプラットフォームで実機確認しやすいため |
| 状態管理 | [Riverpod](https://riverpod.dev/) | テストや依存注入と相性が良く、非同期データの扱いが明確 |
| ルーティング | [go_router](https://pub.dev/packages/go_router) | 宣言的ルートと認証ガード（未ログイン時リダイレクト） |
| 認証・API クライアント | Supabase Flutter, [Dio](https://pub.dev/packages/dio) | 認証状態の取得と、Bearer トークン付き API 呼び出し |
| データモデル | freezed + json_serializable | イミュータブルなモデルと JSON シリアライズの一元管理 |

---

## アーキテクチャのポイント

- **モノレポ** … `apps/backend` と `apps/mobile` を分離しつつ、仕様（API・認証）を揃えて開発
- **認証フロー** … モバイルで Supabase にログイン → 取得した JWT を `Authorization: Bearer` で API に付与 → バックエンドのミドルウェアで検証し `userId` をコンテキストにセット
- **モバイルの構成** … `features` ごとに presentation / application / domain を意識したフォルダ構成（common, core, router は共有）

---

## 動作環境・セットアップ

### 必要環境

- Node.js 22+（Volta 推奨）
- pnpm
- Flutter 3.8+
- Supabase CLI（`supabase start` でローカル Postgres 等を起動）

### 環境変数

`.env` は **アプリごと** に用意します。

| 場所 | 主な変数 |
|------|----------|
| `apps/backend/.env` | `DATABASE_URL`, `SUPABASE_URL`, `SUPABASE_ANON_KEY` |
| `apps/mobile/.env` | `SUPABASE_URL`, `SUPABASE_ANON_KEY` |

各ディレクトリの `.env.example` をコピーして `.env` を作成し、値を設定してください。  
ローカル開発時は `apps/backend` で `pnpm supabase:start` を実行し、表示される接続情報を上記の `.env` に反映します。

### 起動手順

```bash
# バックエンド
cd apps/backend
pnpm install
pnpm supabase:start   # 初回のみ（必要に応じてマイグレーションは docs 参照）
pnpm dev              # http://localhost:9999

# モバイル（別ターミナル）
cd apps/mobile
flutter pub get
flutter run
```

---

## リポジトリ構成

```
task_manager/
├── apps/
│   ├── backend/              # Hono API
│   │   ├── src/
│   │   │   ├── config/       # 環境変数 (env.ts)
│   │   │   ├── db/           # Drizzle スキーマ・クライアント
│   │   │   ├── lib/          # Supabase クライアントなど
│   │   │   ├── middleware/   # JWT 認証
│   │   │   └── routes/       # users, todos, schedules API
│   │   ├── docs/             # セットアップ手順（DB, Auth）
│   │   └── supabase/         # ローカル用マイグレーション
│   └── mobile/
│       └── lib/src/
│           ├── common/       # 共通ウィジェット・テーマ・ユーティリティ
│           ├── core/         # API クライアント・認証
│           ├── features/     # home, schedules, todos（各 feature で presentation/application）
│           └── router/       # go_router 定義・ルート名
└── README.md
```

