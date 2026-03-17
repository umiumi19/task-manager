# task_manager

モノレポ: バックエンド（Node/Postgres）とモバイル（Flutter）でタスク・予定を管理するアプリ。

## 環境変数（.env の置き場所）

**.env はアプリごとに分けて置く。**

| 場所 | 用途 |
|------|------|
| `apps/backend/.env` | バックエンド用（DATABASE_URL, SUPABASE_URL, SUPABASE_ANON_KEY など） |
| `apps/mobile/.env` | モバイル用（SUPABASE_URL, SUPABASE_ANON_KEY） |

- ルートには共通の .env を置かない。
- 各アプリで `.env.example` をコピーして `.env` を作成し、値を埋める。

```bash
# バックエンド
cp apps/backend/.env.example apps/backend/.env

# モバイル
cp apps/mobile/.env.example apps/mobile/.env
```

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.
