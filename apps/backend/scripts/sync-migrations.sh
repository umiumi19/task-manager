#!/bin/bash
# Drizzle のディレクトリ形式マイグレーションを
# Supabase CLI 用のフラット .sql にコピーする
DRIZZLE_DIR="./drizzle/migrations"
SUPABASE_DIR="./supabase/migrations"
for dir in "$DRIZZLE_DIR"/*/; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  sql_file="$SUPABASE_DIR/${name}.sql"
  if [ ! -f "$sql_file" ]; then
    cp "$dir/migration.sql" "$sql_file"
    echo "Copied: ${name}.sql"
  fi
done
