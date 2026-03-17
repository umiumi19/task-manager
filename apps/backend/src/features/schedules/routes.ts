import { createRoute, z } from '@hono/zod-openapi';
import { authMiddleware } from '../../middleware/auth';
import { createRouter } from '../../create_app';
import { idParamsSchema } from '../../common/schema/id_params_schema';
import {
  insertSchedulesSchema,
  listSchedulesQuerySchema,
  listSchedulesResponseSchema,
  selectSchedulesSchema,
  updateSchedulesSchema,
} from './schema';
import { scheduleService } from './service';

export const scheduleRoutes = createRouter();
scheduleRoutes.use('*', authMiddleware);

const listSchedulesRoute = createRoute({
  method: 'get',
  path: '/',
  operationId: 'listSchedules',
  request: {
    query: listSchedulesQuerySchema,
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: listSchedulesResponseSchema,
        },
      },
      description: 'List schedules',
    },
  },
});

const createScheduleRoute = createRoute({
  method: 'post',
  path: '/',
  operationId: 'createSchedule',
  request: {
    body: {
      content: {
        'application/json': {
          schema: insertSchedulesSchema,
        },
      },
      required: true,
    },
  },
  responses: {
    201: {
      content: {
        'application/json': {
          schema: selectSchedulesSchema,
        },
      },
      description: 'Created',
    },
    400: {
      description: 'Bad request',
    },
  },
});

const updateScheduleRoute = createRoute({
  method: 'patch',
  path: '/{id}',
  operationId: 'updateSchedule',
  request: {
    params: idParamsSchema,
    body: {
      content: {
        'application/json': {
          schema: updateSchedulesSchema,
        },
      },
    },
  },
  responses: {
    200: {
      content: {
        'application/json': {
          schema: selectSchedulesSchema,
        },
      },
      description: 'Updated',
    },
    400: {
      description: 'Bad request',
    },
    404: {
      description: 'Schedule not found',
    },
  },
});

const deleteScheduleRoute = createRoute({
  method: 'delete',
  path: '/{id}',
  operationId: 'deleteSchedule',
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
    404: {
      description: 'Schedule not found',
    },
  },
});

scheduleRoutes.openapi(listSchedulesRoute, async (c) => {
  const userId = c.get('userId');

  const schedules = await scheduleService.listSchedules(userId);

  return c.json(
    {
      items: schedules,
    },
    200,
  );
});

scheduleRoutes.openapi(createScheduleRoute, async (c) => {
  const userId = c.get('userId');
  const body = c.req.valid('json');

  try {
    const schedule = await scheduleService.createSchedule({
      userId,
      ...body,
    });

    return c.json(schedule, 201);
  } catch (error) {
    return c.json(
      {
        message:
          error instanceof Error ? error.message : 'Failed to create schedule',
      },
      400,
    );
  }
});

scheduleRoutes.openapi(updateScheduleRoute, async (c) => {
  const userId = c.get('userId');
  const { id } = c.req.valid('param');
  const body = c.req.valid('json');

  try {
    const updatedSchedule = await scheduleService.updateSchedule(
      id,
      userId,
      body,
    );

    if (!updatedSchedule) {
      return c.json({ message: 'Schedule not found' }, 404);
    }

    return c.json(updatedSchedule, 200);
  } catch (error) {
    return c.json(
      {
        message:
          error instanceof Error ? error.message : 'Failed to update schedule',
      },
      400,
    );
  }
});

scheduleRoutes.openapi(deleteScheduleRoute, async (c) => {
  const userId = c.get('userId');
  const { id } = c.req.valid('param');

  const deletedSchedule = await scheduleService.deleteSchedule(id, userId);

  if (!deletedSchedule) {
    return c.json({ message: 'Schedule not found' }, 404);
  }

  return c.json({ message: 'Deleted successfully' }, 200);
});
