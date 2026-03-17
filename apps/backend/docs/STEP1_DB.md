# Step 1: DB をつなぐ

Postgres と Drizzle をローカルで動かす手順です。マイグレーションの生成は Drizzle Kit、適用は Supabase CLI（ローカルのみ）で行います。

## 1. ローカル Postgres を用意する

Supabase ローカルで Postgres を起動します。

```bash
cd apps/backend
pnpm supabase:start
```

起動後、ターミナルに表示される **Database** の接続情報を確認してください。  
ローカルでは通常 **ポート 54322** です。

---

## 2. DATABASE_URL を .env に入れる

`apps/backend/.env` に、`supabase start` の出力に表示された接続文字列を入れます。

例（Supabase ローカル標準）:

```env
DATABASE_URL=postgresql://postgres:postgres@127.0.0.1:54322/postgres
```

- 表示されているパスワード・ホストが異なる場合は、その値に合わせてください。
- ステップ 1 の段階では `SUPABASE_URL` / `SUPABASE_ANON_KEY` は不要です（空で起動します）。

---

## 3. スキーマとマイグレーションの構成

### Drizzle スキーマ

- **テーブル定義**: `src/db/schema/` で管理（users, todos, schedules など）

### Drizzle 設定

- **drizzle.config.ts**: スキーマ `./src/db/schema/index.ts`、出力先 `./drizzle/migrations` を指定

### マイグレーションの流れ

| 形式 | 場所 |
|------|------|
| Drizzle（ディレクトリ形式） | `drizzle/migrations/<timestamp>_<name>/migration.sql` + snapshot.json |
| Supabase（フラット） | `supabase/migrations/<timestamp>_<name>.sql` |

`pnpm sql <name>` 実行時に、Drizzle で生成した SQL を `sync-migrations.sh` が `supabase/migrations/` にコピーします。既に同名の .sql がある場合は上書きしません（手で直したものを残す想定）。

**最初のテーブル定義 SQL を自動生成する**: `src/db/schema/` の定義から、初期マイグレーション（CREATE TABLE 一式）を出すには `pnpm sql initial` を実行します。既存のマイグレーションが無い状態で実行すると、現在のスキーマ全体が 1 本の SQL として生成され、`drizzle/migrations/` と `supabase/migrations/` に出力されます。

### テーブル一覧

| テーブル    | 役割 |
|------------|------|
| `users`    | ユーザー（id, display_name, created_at, updated_at） |
| `todos`    | ToDo（user_id, title, memo, due_at, is_done, priority など） |
| `schedules`| 予定（user_id, todo_id optional, title, start_at, end_at など） |

---

## 4. 運用の流れ

| ステップ | コマンド／作業 |
|----------|----------------|
| 1. スキーマ変更 | `src/db/schema/` の該当ファイルを編集 |
| 2. マイグレーション生成 | `pnpm sql <migration_name>`（例: `pnpm sql add_note`） |
| 3. 中身 | drizzle-kit generate で `drizzle/migrations/` に SQL + snapshot 生成 → sync-migrations.sh で `supabase/migrations/` に .sql をコピー |
| 4. ローカル適用 | `pnpm supabase:reset` で DB をリセットして全マイグレーションを適用（Supabase はローカルのみ利用） |

補足: `supabase/migrations/` には、Drizzle 由来ではないファイル（RLS・cron・ストレージ用など Supabase 専用の SQL）を直接置くこともできます。

---

## 5. テーブル作成を実行する（初回）

Postgres を起動し、`.env` の `DATABASE_URL` を設定したうえで:

```bash
cd apps/backend
pnpm supabase:reset
```

成功すると、`supabase/migrations/*.sql` が順に実行され、`users` / `todos` / `schedules` が作成されます。

### 動作確認

- サーバー起動: `pnpm dev`（開発時は **http://localhost:9999** で起動）
- **API を GUI でテスト**: 開発時のみ **http://localhost:9999/reference** で Scalar の API 参照 UI を開き、`/docs` の OpenAPI 仕様を読みながらリクエスト送信ができる
- （ステップ 2 以降で）ToDo API を叩いて、DB にレコードが入るか確認

### 関連コマンド

| コマンド | 説明 |
|----------|------|
| `pnpm sql <name>` | マイグレーション生成（drizzle-kit generate）+ Supabase 用への sync |
| `pnpm drop` | drizzle-kit drop（不要なマイグレーションの削除） |
| `pnpm supabase:reset` | ローカル DB をリセットしてマイグレーションを最初から適用 |

---

Step 2: 2. ToDo API を先に完成させる

schedules より todos のほうが単純なので、先にこちらを通します。

最初の完成目標はこれです。
	•	GET /todos
	•	POST /todos
	•	PATCH /todos/:id
	•	DELETE /todos/:id

確認観点は、
	•	user_id で自分のデータだけ取れるか
	•	作成できるか
	•	完了更新できるか
	•	404 と 400 が適切に返るか

です。

⸻

3. Schedule API を作る

次に schedules を実装します。

最初は
	•	GET /schedules
	•	POST /schedules
	•	PATCH /schedules/:id
	•	DELETE /schedules/:id

までで十分です。

この段階では、todoId は optional のままでよいです。

⸻

4. ToDo と Schedule を連携させる

このアプリの特徴になる部分です。

追加で確認したいことは、
	•	todoId を指定して schedule を作れるか
	•	その todoId が 自分の ToDo のときだけ成功するか
	•	他人の ToDo を紐づけられないか

です。

ここまでできると、ただの CRUD ではなくなります。

⸻

5. 仮認証を本認証に置き換える

今は x-user-id で進めているので、次に Supabase Auth の JWT 検証 に置き換えます。

流れはこうです。
	•	Flutter で Supabase ログイン
	•	access token を取得
	•	API に Authorization: Bearer ... を付ける
	•	backend 側で token を検証
	•	userId を context に入れる

最初からこれをやるより、CRUD が通ってから差し替えるほうが安全です。

⸻

6. OpenAPI を整える

その次に、
	•	request schema
	•	response schema
	•	endpoint 定義

を @hono/zod-openapi に寄せていきます。

すると後で
	•	API ドキュメント
	•	クライアント生成

につなげやすくなります。

⸻

7. Flutter をつなぐ

backend が安定してから Flutter 側を接続します。

順番はこれがおすすめです。
	•	Supabase Auth でログイン
	•	Dio で /todos を叩く
	•	ToDo 一覧表示
	•	ToDo 追加
	•	ToDo 完了更新
	•	Schedule 一覧表示
	•	Schedule 追加

⸻

今のおすすめ優先順位

今の時点で次にやるべきなのは、この順です。
	1.	Postgres 起動
	2.	Drizzle migration
	3.	todos CRUD 完成
	4.	schedules CRUD 完成
	5.	todoId 連携
	6.	仮認証を Supabase JWT に置換
	7.	Flutter 接続
