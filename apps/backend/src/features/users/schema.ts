import { createSelectSchema } from 'drizzle-zod';
import { z } from '@hono/zod-openapi';
import { users } from '../../db/schema';

export const selectUsersSchema = createSelectSchema(users).openapi(
  'selectUsersSchema',
  {
    example: {
      id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
      displayName: 'Alice',
      createdAt: new Date('2025-07-16T00:00:00Z'),
      updatedAt: new Date('2025-07-16T00:00:00Z'),
    },
  },
);

export type SelectUser = z.infer<typeof selectUsersSchema>;
