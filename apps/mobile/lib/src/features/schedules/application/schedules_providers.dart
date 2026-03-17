import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/api/api_providers.dart';
import '../data/schedules_repository.dart';
import '../domain/schedule.dart';

final schedulesRepositoryProvider = Provider<SchedulesRepository>((ref) {
  final dio = ref.watch(apiDioProvider);
  return SchedulesRepository(dio);
});

/// 予定一覧取得。
final scheduleListProvider =
    FutureProvider.autoDispose<List<Schedule>>((ref) async {
  final repo = ref.watch(schedulesRepositoryProvider);
  return repo.list();
});

/// 今日の予定（startAt が今日のもの）。
final todaySchedulesProvider =
    FutureProvider.autoDispose<List<Schedule>>((ref) async {
  final list = await ref.watch(scheduleListProvider.future);
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final tomorrow = today.add(const Duration(days: 1));
  return list
      .where((s) =>
          !s.startAt.isBefore(today) && s.startAt.isBefore(tomorrow))
      .toList()
    ..sort((a, b) => a.startAt.compareTo(b.startAt));
});
