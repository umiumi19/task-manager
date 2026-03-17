import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from '@hono/zod-openapi';
import { todos } from '../../db/schema';
import coerceDate from '../../utils/coerce_date';

export const selectTodosSchema = createSelectSchema(todos).openapi(
  'selectTodosSchema',
  {
    example: {
      id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
      userId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
      title: 'Buy groceries',
      memo: null,
      dueAt: new Date('2025-07-16T00:00:00Z'),
      isDone: false,
      priority: 2,
      estimatedMinutes: 30,
      createdAt: new Date('2025-07-16T00:00:00Z'),
      updatedAt: new Date('2025-07-16T00:00:00Z'),
    },
  },
);

/** optional かつ null 許容（PATCH で締切をクリアする場合） */
const optionalDate = z.union([coerceDate(), z.null()]).optional();

export const insertTodosSchema = createInsertSchema(todos)
  .pick({
    title: true,
    memo: true,
    dueAt: true,
    priority: true,
    estimatedMinutes: true,
  })
  .required({
    title: true,
  })
  .extend({
    dueAt: optionalDate,
  })
  .refine((data) => data.priority === undefined || (data.priority >= 1 && data.priority <= 3), {
    message: 'priority must be between 1 and 3',
    path: ['priority'],
  })
  .refine(
    (data) =>
      data.estimatedMinutes === undefined ||
      data.estimatedMinutes === null ||
      data.estimatedMinutes > 0,
    {
      message: 'estimatedMinutes must be positive',
      path: ['estimatedMinutes'],
    },
  )
  .openapi('insertTodosSchema', {
    example: {
      title: 'Buy groceries',
      memo: 'milk, eggs',
      dueAt: new Date('2025-07-16T00:00:00Z'),
      priority: 2,
      estimatedMinutes: 30,
    },
  });

export const updateTodosSchema = createInsertSchema(todos)
  .pick({
    title: true,
    memo: true,
    dueAt: true,
    isDone: true,
    priority: true,
    estimatedMinutes: true,
  })
  .partial()
  .extend({
    dueAt: optionalDate,
  })
  .refine((data) => data.priority === undefined || (data.priority >= 1 && data.priority <= 3), {
    message: 'priority must be between 1 and 3',
    path: ['priority'],
  })
  .refine(
    (data) =>
      data.estimatedMinutes === undefined ||
      data.estimatedMinutes === null ||
      data.estimatedMinutes > 0,
    {
      message: 'estimatedMinutes must be positive',
      path: ['estimatedMinutes'],
    },
  )
  .openapi('updateTodosSchema', {
    example: {
      title: 'Buy groceries',
      memo: null,
      dueAt: new Date('2025-07-16T00:00:00Z'),
      isDone: false,
      priority: 2,
      estimatedMinutes: 30,
    },
  });

export const listTodosQuerySchema = z
  .object({
    includeDone: z
      .union([z.literal('true'), z.literal('false')])
      .optional()
      .transform((value) => value === 'true')
      .openapi({
        param: {
          name: 'includeDone',
          in: 'query',
          required: false,
        },
        example: 'true',
      }),
  })
  .openapi('listTodosQuerySchema');

export const listTodosResponseSchema = z
  .object({
    items: z.array(selectTodosSchema),
  })
  .openapi('listTodosResponseSchema');

export type SelectTodos = z.infer<typeof selectTodosSchema>;
export type InsertTodos = z.infer<typeof insertTodosSchema>;
export type UpdateTodos = z.infer<typeof updateTodosSchema>;
