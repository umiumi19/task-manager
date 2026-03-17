import { OpenAPIHono } from '@hono/zod-openapi';
import type { Context } from 'hono';
import type { AuthenticatedVariables } from './middleware/auth';

export type HonoEnv = {
  Variables: AuthenticatedVariables;
};

function formatZodErrors(result: { error: import('zod').ZodError }): unknown {
  return result.error.flatten();
}

export function zodErrorHandler(
  result: { success: true; data: unknown } | { success: false; error: import('zod').ZodError },
  c: Context<HonoEnv>,
) {
  if (!result.success) {
    console.warn('Validation error', result.error.flatten());
    return c.json(
      {
        message: 'Validation Error',
        errors: formatZodErrors(result),
      },
      400,
    );
  }
}

export function createRouter() {
  return new OpenAPIHono<HonoEnv>({
    strict: false,
    defaultHook: zodErrorHandler,
  });
}
