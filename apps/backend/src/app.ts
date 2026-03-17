import { loggerMiddleware } from './middleware/logger';
import { createRouter } from './create_app';
import { todoRoutes } from './features/todos/routes';
import { scheduleRoutes } from './features/schedules/routes';
import { userRoutes } from './features/users/routes';
import { configureOpenAPI } from './lib/configure_open_api';
import { env } from './config/env';

export const app = createRouter();

app.use('*', loggerMiddleware);

app.get('/', (c) => {
  return c.json({
    message: 'task_manager backend is running',
  });
});

app.route('/users', userRoutes);
app.route('/todos', todoRoutes);
app.route('/schedules', scheduleRoutes);

if (env.NODE_ENV === 'development') {
  configureOpenAPI(app);
}

app.notFound((c) => {
  return c.json(
    {
      message: 'Not Found',
    },
    404,
  );
});

app.onError((error, c) => {
  console.error(error);

  return c.json(
    {
      message: 'Internal Server Error',
    },
    500,
  );
});