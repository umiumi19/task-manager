import { Scalar } from '@scalar/hono-api-reference';
import type { OpenAPIHono } from '@hono/zod-openapi';
import type { HonoEnv } from '../create_app';

/**
 * 開発時のみ有効。OpenAPI 仕様の配信と Scalar API 参照 UI を追加する。
 * - GET /docs … OpenAPI 3.0 仕様（JSON）
 * - GET /reference … Scalar の GUI（/docs を参照して API を実行可能）
 */
export function configureOpenAPI(app: OpenAPIHono<HonoEnv>): void {
  app.doc('/docs', {
    openapi: '3.0.0',
    info: {
      title: 'Task Manager API',
      version: '1.0.0',
    },
    components: {
      securitySchemes: {
        bearerAuth: {
          type: 'http',
          scheme: 'bearer',
          bearerFormat: 'JWT',
          description: 'Supabase Auth の access token（Authorization: Bearer <token>）',
        },
      },
    },
    security: [{ bearerAuth: [] }],
  } as Parameters<OpenAPIHono<HonoEnv>['doc']>[1]);

  app.get(
    '/reference',
    Scalar({
      url: '/docs',
      theme: 'kepler',
      layout: 'classic',
    }),
  );
}
