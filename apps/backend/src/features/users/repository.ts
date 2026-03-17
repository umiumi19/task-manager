import { eq } from 'drizzle-orm';
import { db } from '../../db/client';
import { users } from '../../db/schema';

export const userRepository = {
  async findById(userId: string) {
    const result = await db
      .select()
      .from(users)
      .where(eq(users.id, userId))
      .limit(1);

    return result[0] ?? null;
  },
};
