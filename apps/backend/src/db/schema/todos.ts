import {
    boolean,
    integer,
    pgTable,
    text,
    timestamp,
    uuid,
    smallint,
  } from 'drizzle-orm/pg-core';
  import { users } from './users';
  
  export const todos = pgTable('todos', {
    id: uuid('id').primaryKey().defaultRandom(),
    userId: uuid('user_id')
      .notNull()
      .references(() => users.id, { onDelete: 'cascade' }),
    title: text('title').notNull(),
    memo: text('memo'),
    dueAt: timestamp('due_at', { withTimezone: true }),
    isDone: boolean('is_done').notNull().default(false),
    priority: smallint('priority').notNull().default(2),
    estimatedMinutes: integer('estimated_minutes'),
    createdAt: timestamp('created_at', { withTimezone: true })
      .notNull()
      .defaultNow(),
    updatedAt: timestamp('updated_at', { withTimezone: true })
      .notNull()
      .defaultNow(),
  });