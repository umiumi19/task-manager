import 'dotenv/config';
import { serve } from '@hono/node-server';
import { app } from './app';
import { env } from './config/env';

serve(
  {
    fetch: app.fetch,
    port: env.PORT,
  },
  (info) => {
    console.log(`🚀 Backend server is running on http://localhost:${info.port}`);
  },
);