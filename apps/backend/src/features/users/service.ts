import { userRepository } from './repository';

export const userService = {
  async getCurrentUser(userId: string) {
    return userRepository.findById(userId);
  },
};
