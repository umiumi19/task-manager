import { createRoute } from '@hono/zod-openapi';
import { authMiddleware } from '../../middleware/auth';
import { createRouter } from '../../create_app';
import { selectUsersSchema } from './schema';
import { userService } from './service';

export const userRoutes = createRouter();
userRoutes.use('*', authMiddleware);

const getMeRoute = createRoute({
  method: 'get',
  path: '/me',
  operationId: 'getCurrentUser',
  responses: {
    200: {
      content: {
        'application/json': {
          schema: selectUsersSchema,
        },
      },
      description: 'Current user (public.users)',
    },
    404: {
      description: 'User not found in public.users',
    },
  },
});

userRoutes.openapi(getMeRoute, async (c) => {
  const userId = c.get('userId');

  const user = await userService.getCurrentUser(userId);

  if (!user) {
    return c.json({ message: 'User not found' }, 404);
  }

  return c.json(user, 200);
});
