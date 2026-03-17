import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../common/theme/app_colors.dart';
import '../../../../common/theme/app_text_styles.dart';
import '../../../../common/widgets/async_value_widget.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/custom_floating_action_button.dart';
import '../../../../common/widgets/form_widget_with_title.dart';
import '../../../../common/widgets/see_all_button.dart';
import '../../../../router/route_names.dart';
import '../../../schedules/application/schedules_providers.dart';
import '../../../schedules/domain/schedule.dart';
import '../../../schedules/presentation/schedule_list_tile/schedule_list_tile.dart';
import '../../../todos/application/todos_providers.dart';
import '../../../todos/domain/todo.dart';
import '../../../todos/presentation/todo_list_tile/todo_list_tile.dart';
import '../../application/home_providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeAsync = ref.watch(homePageDataProvider);

    return ScaffoldAsyncValueWidget<HomePageData>(
      value: homeAsync,
      onRetry: () => ref.invalidate(homePageDataProvider),
      data: (data) => Scaffold(
        appBar: const _AppBar(),
        body: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(homePageDataProvider);
          },
          child: _Body(data: data),
        ),
        floatingActionButton: _FloatingActionButton(ref: ref),
      ),
    );
  }
}

class _AppBar extends ConsumerWidget implements PreferredSizeWidget {
  const _AppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomAppBar(hasBackButton: false, title: 'Task Manager');
  }
}

class _Body extends ConsumerWidget {
  const _Body({required this.data});

  final HomePageData data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: pagePadding,
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              FormWidgetWithTitle(
                title: '今日の予定',
                isRequired: false,
                topRightWidget: SeeAllButton(
                  onTap: () => context.push(RouteNames.scheduleList),
                ),
                child: _TodaySchedulesSection(
                  schedules: data.todaySchedules,
                  onAddTap: () async {
                    await context.push<bool>(RouteNames.addSchedule);
                    if (context.mounted) {
                      ref.invalidate(scheduleListProvider);
                      ref.invalidate(homePageDataProvider);
                    }
                  },
                ),
              ),
              const SizedBox(height: sectionSpacing),
              FormWidgetWithTitle(
                title: '期日の近いタスク',
                isRequired: false,
                topRightWidget: SeeAllButton(
                  onTap: () => context.go(RouteNames.todoList),
                ),
                child: _NearestTodosSection(
                  todos: data.nearestTodos,
                  onAddTap: () async {
                    await context.push<bool>(RouteNames.addTodo);
                    if (context.mounted) {
                      ref.invalidate(todoListProvider);
                      ref.invalidate(homePageDataProvider);
                    }
                  },
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _TodaySchedulesSection extends ConsumerWidget {
  const _TodaySchedulesSection({
    required this.schedules,
    required this.onAddTap,
  });

  final List<Schedule> schedules;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (schedules.isEmpty) {
      return _AddNewCard(
        icon: Icons.add_outlined,
        message: '今日の予定はありません',
        onTap: onAddTap,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: schedules.length,
      separatorBuilder: (_, __) => gapH8,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final s = schedules[index];
        return ScheduleListTile(
          schedule: s,
          onTap: () => _openEditSchedule(context, s, ref),
        );
      },
    );
  }

  Future<void> _openEditSchedule(
    BuildContext context,
    Schedule schedule,
    WidgetRef ref,
  ) async {
    final result = await context.push<bool>(
      '${RouteNames.scheduleList}/${schedule.id}',
      extra: schedule,
    );
    if (context.mounted && result == true) {
      ref.invalidate(homePageDataProvider);
    }
  }
}

class _NearestTodosSection extends ConsumerWidget {
  const _NearestTodosSection({required this.todos, required this.onAddTap});

  final List<Todo> todos;
  final VoidCallback onAddTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (todos.isEmpty) {
      return _AddNewCard(
        icon: Icons.add_outlined,
        message: '未完了のタスクはありません',
        onTap: onAddTap,
      );
    }
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: todos.length,
      separatorBuilder: (_, __) => gapH8,
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoListTile(
          todo: todo,
          onTap: () => _openEditTodo(context, todo, ref),
        );
      },
    );
  }

  Future<void> _openEditTodo(
    BuildContext context,
    Todo todo,
    WidgetRef ref,
  ) async {
    final result = await context.push<bool>(
      '${RouteNames.todoList}/${todo.id}',
      extra: todo,
    );
    if (context.mounted && result == true) {
      ref.invalidate(homePageDataProvider);
    }
  }
}

/// 参照: RecentScheduleList の _AddNewSchedule に倣った空状態（タップで追加画面へ）
class _AddNewCard extends StatelessWidget {
  const _AddNewCard({
    required this.icon,
    required this.message,
    required this.onTap,
  });

  final IconData icon;
  final String message;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: AppSizes.tileHeight,
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
        decoration: BoxDecoration(
          color: context.appColors.surface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(icon, color: context.appColors.emptyText),
            gapW16,
            Text(
              message,
              style: context.textStyles.bodyMediumRegular.withSubtleTextColor(
                context,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FloatingActionButton extends StatelessWidget {
  const _FloatingActionButton({required this.ref});

  final WidgetRef ref;

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    return CustomFloatingActionButton(
      heroTag: 'home_fab',
      onPressed: () {
        unawaited(
          showGeneralDialog(
            barrierLabel: 'todoOrSchedule',
            barrierDismissible: true,
            barrierColor: context.appColors.overlayColor,
            transitionDuration: Duration.zero,
            context: context,
            pageBuilder: (dialogContext, anim1, anim2) {
              return SafeArea(
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(AppSizes.p12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(dialogContext).pop();
                                unawaited(
                                  router
                                      .push<bool>(RouteNames.addSchedule)
                                      .then((_) {
                                        ref.invalidate(scheduleListProvider);
                                        ref.invalidate(homePageDataProvider);
                                      }),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: AppSizes.p48,
                                    height: AppSizes.p48,
                                    decoration: BoxDecoration(
                                      color: context.appColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.calendar_today_outlined,
                                      color: context.appColors.surface,
                                    ),
                                  ),
                                  gapW8,
                                  Text(
                                    '予定を追加',
                                    style: context.textStyles.labelSmallRegular
                                        .copyWith(
                                          color: context.appColors.primaryText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(AppSizes.p12),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(dialogContext).pop();
                                unawaited(
                                  router.push<bool>(RouteNames.addTodo).then((
                                    _,
                                  ) {
                                    ref.invalidate(todoListProvider);
                                    ref.invalidate(homePageDataProvider);
                                  }),
                                );
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: AppSizes.p48,
                                    height: AppSizes.p48,
                                    decoration: BoxDecoration(
                                      color: context.appColors.primary,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.checklist_outlined,
                                      color: context.appColors.surface,
                                    ),
                                  ),
                                  gapW8,
                                  Text(
                                    'タスクを追加',
                                    style: context.textStyles.labelSmallRegular
                                        .copyWith(
                                          color: context.appColors.primaryText,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
