import { createClient } from '@supabase/supabase-js';
import { env } from '../config/env';

/**
 * Supabase クライアント（サーバー側での JWT 検証用）。
 * auth.getUser(jwt) でアクセストークンを検証する。
 */
export const supabase = createClient(env.SUPABASE_URL, env.SUPABASE_ANON_KEY, {
  auth: {
    autoRefreshToken: false,
    persistSession: false,
  },
});
