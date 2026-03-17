import { todoRepository } from './repository';

export const todoService = {
  async listTodos(userId: string, includeDone: boolean) {
    return todoRepository.findManyByUserId(userId, includeDone);
  },

  async createTodo(input: {
    userId: string;
    title: string;
    memo?: string | null;
    dueAt?: Date | null;
    priority?: number;
    estimatedMinutes?: number | null;
  }) {
    return todoRepository.create({
      userId: input.userId,
      title: input.title,
      memo: input.memo ?? null,
      dueAt: input.dueAt ?? null,
      priority: input.priority ?? 2,
      estimatedMinutes: input.estimatedMinutes ?? null,
    });
  },

  async updateTodo(
    todoId: string,
    userId: string,
    input: {
      title?: string;
      memo?: string | null;
      dueAt?: Date | null;
      isDone?: boolean;
      priority?: number;
      estimatedMinutes?: number | null;
    },
  ) {
    const existingTodo = await todoRepository.findById(todoId, userId);

    if (!existingTodo) {
      return null;
    }

    return todoRepository.update(todoId, userId, {
      title: input.title,
      memo: input.memo,
      dueAt: input.dueAt,
      isDone: input.isDone,
      priority: input.priority,
      estimatedMinutes: input.estimatedMinutes,
    });
  },

  async deleteTodo(todoId: string, userId: string) {
    return todoRepository.remove(todoId, userId);
  },
};