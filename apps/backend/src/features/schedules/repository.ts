import { and, asc, eq } from 'drizzle-orm';
import { db } from '../../db/client';
import { schedules, todos } from '../../db/schema';

export type CreateScheduleInput = {
  userId: string;
  todoId?: string | null;
  title: string;
  memo?: string | null;
  startAt: Date;
  endAt?: Date | null;
  location?: string | null;
};

export type UpdateScheduleInput = {
  todoId?: string | null;
  title?: string;
  memo?: string | null;
  startAt?: Date;
  endAt?: Date | null;
  location?: string | null;
};

export const scheduleRepository = {
  async findManyByUserId(userId: string) {
    return db
      .select()
      .from(schedules)
      .where(eq(schedules.userId, userId))
      .orderBy(asc(schedules.startAt));
  },

  async findById(scheduleId: string, userId: string) {
    const result = await db
      .select()
      .from(schedules)
      .where(and(eq(schedules.id, scheduleId), eq(schedules.userId, userId)))
      .limit(1);

    return result[0] ?? null;
  },

  async findTodoById(todoId: string, userId: string) {
    const result = await db
      .select()
      .from(todos)
      .where(and(eq(todos.id, todoId), eq(todos.userId, userId)))
      .limit(1);

    return result[0] ?? null;
  },

  async create(input: CreateScheduleInput) {
    const result = await db
      .insert(schedules)
      .values({
        userId: input.userId,
        todoId: input.todoId ?? null,
        title: input.title,
        memo: input.memo ?? null,
        startAt: input.startAt,
        endAt: input.endAt ?? null,
        location: input.location ?? null,
      })
      .returning();

    return result[0];
  },

  async update(scheduleId: string, userId: string, input: UpdateScheduleInput) {
    const set: Record<string, unknown> = { updatedAt: new Date() };
    if (input.todoId !== undefined) set.todoId = input.todoId;
    if (input.title !== undefined) set.title = input.title;
    if (input.memo !== undefined) set.memo = input.memo;
    if (input.startAt !== undefined) set.startAt = input.startAt;
    if (input.endAt !== undefined) set.endAt = input.endAt;
    if (input.location !== undefined) set.location = input.location;

    const result = await db
      .update(schedules)
      .set(set)
      .where(
        and(eq(schedules.id, scheduleId), eq(schedules.userId, userId)),
      )
      .returning();

    return result[0] ?? null;
  },

  async remove(scheduleId: string, userId: string) {
    const result = await db
      .delete(schedules)
      .where(
        and(eq(schedules.id, scheduleId), eq(schedules.userId, userId)),
      )
      .returning();

    return result[0] ?? null;
  },
};