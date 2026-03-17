import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../router/route_names.dart';
import '../../application/schedules_providers.dart';
import '../../domain/schedule.dart';
import '../schedule_list_tile/schedule_list_tile.dart';

class ScheduleListPage extends ConsumerWidget {
  const ScheduleListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final schedulesAsync = ref.watch(scheduleListProvider);

    return Scaffold(
      appBar: const CustomAppBar(title: '予定一覧'),
      body: schedulesAsync.when(
        data: (schedules) {
          if (schedules.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 64,
                    color: Theme.of(context).colorScheme.outline,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '予定はありません',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '右下の＋から追加してください。',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          return RefreshIndicator(
            onRefresh: () async => ref.invalidate(scheduleListProvider),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: AppSizes.p8,
              ),
              itemCount: schedules.length,
              separatorBuilder: (_, __) => gapH8,
              itemBuilder: (context, index) {
                final schedule = schedules[index];
                return ScheduleListTile(
                  schedule: schedule,
                  onTap: () => _openEdit(context, schedule, ref),
                  showDate: true,
                );
              },
            ),
          );
        },
        loading: () =>
            const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '読み込みに失敗しました',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(scheduleListProvider),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAdd(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _openAdd(BuildContext context, WidgetRef ref) async {
    await context.push<bool>(RouteNames.addSchedule);
    if (context.mounted) {
      ref.invalidate(scheduleListProvider);
    }
  }

  Future<void> _openEdit(
      BuildContext context, Schedule schedule, WidgetRef ref) async {
    await context.push<bool>(
      '${RouteNames.scheduleList}/${schedule.id}',
      extra: schedule,
    );
    if (context.mounted) {
      ref.invalidate(scheduleListProvider);
    }
  }
}
