import { and, desc, eq } from 'drizzle-orm';
import { db } from '../../db/client';
import { todos } from '../../db/schema';

export type CreateTodoInput = {
  userId: string;
  title: string;
  memo?: string | null;
  dueAt?: Date | null;
  priority?: number;
  estimatedMinutes?: number | null;
};

export type UpdateTodoInput = {
  title?: string;
  memo?: string | null;
  dueAt?: Date | null;
  isDone?: boolean;
  priority?: number;
  estimatedMinutes?: number | null;
};

export const todoRepository = {
  async findManyByUserId(userId: string, includeDone = true) {
    if (includeDone) {
      return db
        .select()
        .from(todos)
        .where(eq(todos.userId, userId))
        .orderBy(desc(todos.createdAt));
    }

    return db
      .select()
      .from(todos)
      .where(and(eq(todos.userId, userId), eq(todos.isDone, false)))
      .orderBy(desc(todos.createdAt));
  },

  async findById(todoId: string, userId: string) {
    const result = await db
      .select()
      .from(todos)
      .where(and(eq(todos.id, todoId), eq(todos.userId, userId)))
      .limit(1);

    return result[0] ?? null;
  },

  async create(input: CreateTodoInput) {
    const result = await db
      .insert(todos)
      .values({
        userId: input.userId,
        title: input.title,
        memo: input.memo ?? null,
        dueAt: input.dueAt ?? null,
        priority: input.priority ?? 2,
        estimatedMinutes: input.estimatedMinutes ?? null,
      })
      .returning();

    return result[0];
  },

  async update(todoId: string, userId: string, input: UpdateTodoInput) {
    const set: Record<string, unknown> = { updatedAt: new Date() };
    if (input.title !== undefined) set.title = input.title;
    if (input.memo !== undefined) set.memo = input.memo;
    if (input.dueAt !== undefined) set.dueAt = input.dueAt;
    if (input.isDone !== undefined) set.isDone = input.isDone;
    if (input.priority !== undefined) set.priority = input.priority;
    if (input.estimatedMinutes !== undefined)
      set.estimatedMinutes = input.estimatedMinutes;

    const result = await db
      .update(todos)
      .set(set)
      .where(and(eq(todos.id, todoId), eq(todos.userId, userId)))
      .returning();

    return result[0] ?? null;
  },

  async remove(todoId: string, userId: string) {
    const result = await db
      .delete(todos)
      .where(and(eq(todos.id, todoId), eq(todos.userId, userId)))
      .returning();

    return result[0] ?? null;
  },
};