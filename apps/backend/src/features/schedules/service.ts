import { scheduleRepository } from './repository';

export const scheduleService = {
  async listSchedules(userId: string) {
    return scheduleRepository.findManyByUserId(userId);
  },

  async createSchedule(input: {
    userId: string;
    todoId?: string | null;
    title: string;
    memo?: string | null;
    startAt: Date;
    endAt?: Date | null;
    location?: string | null;
  }) {
    if (input.todoId) {
      const todo = await scheduleRepository.findTodoById(
        input.todoId,
        input.userId,
      );

      if (!todo) {
        throw new Error('Linked todo not found');
      }
    }

    const startAt = input.startAt;
    const endAt = input.endAt ?? null;

    if (endAt && endAt < startAt) {
      throw new Error('endAt must be greater than or equal to startAt');
    }

    return scheduleRepository.create({
      userId: input.userId,
      todoId: input.todoId ?? null,
      title: input.title,
      memo: input.memo ?? null,
      startAt,
      endAt,
      location: input.location ?? null,
    });
  },

  async updateSchedule(
    scheduleId: string,
    userId: string,
    input: {
      todoId?: string | null;
      title?: string;
      memo?: string | null;
      startAt?: Date;
      endAt?: Date | null;
      location?: string | null;
    },
  ) {
    const existingSchedule = await scheduleRepository.findById(scheduleId, userId);

    if (!existingSchedule) {
      return null;
    }

    if (input.todoId) {
      const todo = await scheduleRepository.findTodoById(input.todoId, userId);
      if (!todo) {
        throw new Error('Linked todo not found');
      }
    }

    const nextStartAt = input.startAt ?? existingSchedule.startAt;
    const nextEndAt =
      input.endAt === undefined
        ? existingSchedule.endAt
        : input.endAt;

    if (nextEndAt && nextEndAt < nextStartAt) {
      throw new Error('endAt must be greater than or equal to startAt');
    }

    return scheduleRepository.update(scheduleId, userId, {
      todoId: input.todoId,
      title: input.title,
      memo: input.memo,
      startAt: input.startAt,
      endAt: input.endAt,
      location: input.location,
    });
  },

  async deleteSchedule(scheduleId: string, userId: string) {
    return scheduleRepository.remove(scheduleId, userId);
  },
};