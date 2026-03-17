import { relations } from 'drizzle-orm/_relations';
import { users } from './users';
import { todos } from './todos';
import { schedules } from './schedules';

export const usersRelations = relations(users, ({ many }) => ({
  todos: many(todos),
  schedules: many(schedules),
}));

export const todosRelations = relations(todos, ({ one, many }) => ({
  user: one(users, {
    fields: [todos.userId],
    references: [users.id],
  }),
  schedules: many(schedules),
}));

export const schedulesRelations = relations(schedules, ({ one }) => ({
  user: one(users, {
    fields: [schedules.userId],
    references: [users.id],
  }),
  todo: one(todos, {
    fields: [schedules.todoId],
    references: [todos.id],
  }),
}));