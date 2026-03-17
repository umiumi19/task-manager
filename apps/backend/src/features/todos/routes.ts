import { createRoute, z } from '@hono/zod-openapi';
import { authMiddleware } from '../../middleware/auth';
import { createRouter } from '../../create_app';
import { idParamsSchema } from '../../common/schema/id_params_schema';
import {
  insertTodosSchema,
  listTodosQuerySchema,
  listTodosResponseSchema,
  selectTodosSchema,
  updateTodosSchema,
} from './schema';
import { todoService } from './service';

export const todoRoutes = createRouter();
todoRoutes.use('*', authMiddleware);

const listTodosRoute = createRoute({
  method: 'get',
  path: '/',
  operationId: 'listTodos',
  request: {
    query: listTodosQuerySchema,
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: listTodosResponseSchema,
        },
      },
      description: 'List todos',
    },
    400: {
      description: 'Validation error (invalid query)',
    },
  },
});

const createTodoRoute = createRoute({
  method: 'post',
  path: '/',
  operationId: 'createTodo',
  request: {
    body: {
      content: {
        'application/json': {
          schema: insertTodosSchema,
        },
      },
      required: true,
    },
  },
  responses: {
    201: {
      content: {
        'application/json': {
          schema: selectTodosSchema,
        },
      },
      description: 'Created',
    },
    400: {
      description: 'Validation error (invalid body)',
    },
  },
});

const updateTodoRoute = createRoute({
  method: 'patch',
  path: '/{id}',
  operationId: 'updateTodo',
  request: {
    params: idParamsSchema,
    body: {
      content: {
        'application/json': {
          schema: updateTodosSchema,
        },
      },
    },
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: selectTodosSchema,
        },
      },
      description: 'Updated',
    },
    400: {
      description: 'Validation error (invalid body or params)',
    },
    404: {
      description: 'Todo not found',
    },
  },
});

const deleteTodoRoute = createRoute({
  method: 'delete',
  path: '/{id}',
  operationId: 'deleteTodo',
  request: {
    params: idParamsSchema,
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: z.object({ message: z.literal('Deleted successfully') }),
        },
      },
      description: 'Deleted',
    },
    400: {
      description: 'Validation error (invalid id)',
    },
    404: {
      description: 'Todo not found',
    },
  },
});

todoRoutes.openapi(listTodosRoute, async (c) => {
  const userId = c.get('userId');
  const query = c.req.valid('query');

  const todos = await todoService.listTodos(userId, query.includeDone ?? true);

  return c.json(
    {
      items: todos,
    },
    200,
  );
});

todoRoutes.openapi(createTodoRoute, async (c) => {
  const userId = c.get('userId');
  const body = c.req.valid('json');

  const todo = await todoService.createTodo({
    userId,
    ...body,
  });

  return c.json(todo, 201);
});

todoRoutes.openapi(updateTodoRoute, async (c) => {
  const userId = c.get('userId');
  const { id } = c.req.valid('param');
  const body = c.req.valid('json');

  const updatedTodo = await todoService.updateTodo(id, userId, body);

  if (!updatedTodo) {
    return c.json({ message: 'Todo not found' }, 404);
  }

  return c.json(updatedTodo, 200);
});

todoRoutes.openapi(deleteTodoRoute, async (c) => {
  const userId = c.get('userId');
  const { id } = c.req.valid('param');

  const deletedTodo = await todoService.deleteTodo(id, userId);

  if (!deletedTodo) {
    return c.json({ message: 'Todo not found' }, 404);
  }

  return c.json({ message: 'Deleted successfully' }, 200);
});
