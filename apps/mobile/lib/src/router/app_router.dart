import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/application/auth_providers.dart';
import '../features/auth/presentation/pages/login_page.dart';
import '../features/auth/presentation/pages/sign_up_page.dart';
import '../features/home/presentation/pages/home_page.dart';
import '../features/schedules/domain/schedule.dart';
import '../features/schedules/presentation/pages/add_schedule_page.dart';
import '../features/schedules/presentation/pages/edit_schedule_page.dart';
import '../features/schedules/presentation/pages/schedule_list_page.dart';
import '../features/todos/domain/todo.dart';
import '../features/todos/presentation/pages/add_todo_page.dart';
import '../features/todos/presentation/pages/edit_todo_page.dart';
import '../features/todos/presentation/pages/todo_list_page.dart';
import 'main_tab_scaffold.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  ref.watch(authStateProvider);

  return GoRouter(
    initialLocation: RouteNames.home,
    redirect: (context, state) {
      final isLoggedIn = ref.read(currentUserProvider) != null;
      final isGoingToLogin = state.matchedLocation == RouteNames.login;
      final isGoingToSignUp = state.matchedLocation == RouteNames.signUp;

      if (!isLoggedIn && !isGoingToLogin && !isGoingToSignUp) {
        return RouteNames.login;
      }

      if (isLoggedIn && (isGoingToLogin || isGoingToSignUp)) {
        return RouteNames.home;
      }

      return null;
    },
    refreshListenable: GoRouterRefreshStream(
      ref.read(authRepositoryProvider).authStateChanges(),
    ),
    routes: [
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: RouteNames.signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            MainTabScaffold(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomePage(),
                routes: [
                  GoRoute(
                    path: 'schedules',
                    builder: (context, state) => const ScheduleListPage(),
                  ),
                  GoRoute(
                    path: 'schedules/add',
                    builder: (context, state) => const AddSchedulePage(),
                  ),
                  GoRoute(
                    path: 'schedules/:id',
                    builder: (context, state) {
                      final schedule = state.extra as Schedule?;
                      if (schedule == null) {
                        return const Scaffold(
                          body: Center(child: Text('予定が見つかりません')),
                        );
                      }
                      return EditSchedulePage(schedule: schedule);
                    },
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.todoList,
                builder: (context, state) => const TodoListPage(),
                routes: [
                  GoRoute(
                    path: 'add',
                    builder: (context, state) => const AddTodoPage(),
                  ),
                  GoRoute(
                    path: ':id',
                    builder: (context, state) {
                      final todo = state.extra as Todo?;
                      if (todo == null) {
                        return const Scaffold(
                          body: Center(child: Text('タスクが見つかりません')),
                        );
                      }
                      return EditTodoPage(todo: todo);
                    },
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
