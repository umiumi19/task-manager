import { z } from '@hono/zod-openapi';

export const idParamsSchema = z.object({
  id: z.string().uuid().openapi({
    param: { name: 'id', in: 'path' },
  }),
});