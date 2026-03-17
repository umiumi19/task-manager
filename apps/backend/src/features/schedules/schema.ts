import { createInsertSchema, createSelectSchema } from 'drizzle-zod';
import { z } from '@hono/zod-openapi';
import { schedules } from '../../db/schema';

export const selectSchedulesSchema = createSelectSchema(schedules).openapi(
  'selectSchedulesSchema',
  {
    example: {
      id: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
      userId: 'aaaaaaaa-aaaa-aaaa-aaaa-aaaaaaaaaaaa',
      todoId: null,
      title: 'Team meeting',
      memo: null,
      startAt: new Date('2025-07-16T09:00:00Z'),
      endAt: new Date('2025-07-16T10:00:00Z'),
      location: 'Room 1',
      createdAt: new Date('2025-07-16T00:00:00Z'),
      updatedAt: new Date('2025-07-16T00:00:00Z'),
    },
  },
);

const dateOrString = z.union([
  z.string().datetime().transform((s) => new Date(s)),
  z.date(),
  z.null(),
]);
const dateOrStringRequired = z.union([
  z.string().datetime().transform((s) => new Date(s)),
  z.date(),
]);

export const insertSchedulesSchema = createInsertSchema(schedules)
  .pick({
    todoId: true,
    title: true,
    memo: true,
    startAt: true,
    endAt: true,
    location: true,
  })
  .required({
    title: true,
    startAt: true,
  })
  .extend({
    startAt: dateOrStringRequired,
    endAt: dateOrString.optional(),
  })
  .openapi('insertSchedulesSchema', {
    example: {
      title: 'Team meeting',
      memo: 'Quarterly review',
      startAt: new Date('2025-07-16T09:00:00Z'),
      endAt: new Date('2025-07-16T10:00:00Z'),
      location: 'Room 1',
      todoId: null,
    },
  });

export const updateSchedulesSchema = createInsertSchema(schedules)
  .pick({
    todoId: true,
    title: true,
    memo: true,
    startAt: true,
    endAt: true,
    location: true,
  })
  .partial()
  .extend({
    startAt: z
      .union([z.string().datetime().transform((s) => new Date(s)), z.date()])
      .optional(),
    endAt: dateOrString.optional(),
  })
  .openapi('updateSchedulesSchema', {
    example: {
      title: 'Team meeting',
      memo: null,
      startAt: new Date('2025-07-16T09:00:00Z'),
      endAt: new Date('2025-07-16T10:00:00Z'),
      location: 'Room 1',
      todoId: null,
    },
  });

export const listSchedulesQuerySchema = z
  .object({})
  .openapi('listSchedulesQuerySchema');

export const listSchedulesResponseSchema = z
  .object({
    items: z.array(selectSchedulesSchema),
  })
  .openapi('listSchedulesResponseSchema');

export type SelectSchedules = z.infer<typeof selectSchedulesSchema>;
export type InsertSchedules = z.infer<typeof insertSchedulesSchema>;
export type UpdateSchedules = z.infer<typeof updateSchedulesSchema>;
