import { z } from '@hono/zod-openapi';

export const booleanParamSchema = z.union([
  z.literal('true').transform(() => true),
  z.literal('false').transform(() => false),
]);