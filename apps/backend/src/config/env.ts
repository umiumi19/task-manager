const getRequiredEnv = (key: string): string => {
  const value = process.env[key];
  if (!value) {
    throw new Error(`Missing required environment variable: ${key}`);
  }
  return value;
};

export const env = {
  NODE_ENV: process.env.NODE_ENV ?? 'development',
  PORT: Number(
    process.env.PORT ??
      (process.env.NODE_ENV === 'development' ? 9999 : 8787),
  ),
  DATABASE_URL: getRequiredEnv('DATABASE_URL'),
  SUPABASE_URL: getRequiredEnv('SUPABASE_URL'),
  SUPABASE_ANON_KEY: getRequiredEnv('SUPABASE_ANON_KEY'),
};