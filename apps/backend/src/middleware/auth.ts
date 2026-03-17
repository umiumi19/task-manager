import type { User } from '@supabase/supabase-js';
import type { MiddlewareHandler } from 'hono';
import { supabase } from '../lib/supabase';

export type AuthenticatedVariables = {
  user: User;
  userId: string;
};

const BEARER_PREFIX = 'Bearer ';

const authMiddleware: MiddlewareHandler<{
  Variables: AuthenticatedVariables;
}> = async (c, next) => {
  const authHeader = c.req.header('Authorization');

  if (!authHeader || !authHeader.startsWith(BEARER_PREFIX)) {
    return c.json({ message: 'Unauthorized' }, 401);
  }

  const token = authHeader.slice(BEARER_PREFIX.length).trim();
  if (!token) {
    return c.json({ message: 'Unauthorized' }, 401);
  }

  const {
    data: { user },
    error,
  } = await supabase.auth.getUser(token);

  if (error || !user) {
    return c.json({ message: 'Unauthorized' }, 401);
  }

  c.set('user', user);
  c.set('userId', user.id);

  await next();
};

export { authMiddleware };