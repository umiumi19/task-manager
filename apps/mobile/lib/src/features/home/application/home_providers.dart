import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_providers.dart';
import '../../schedules/application/schedules_providers.dart';
import '../../schedules/domain/schedule.dart';
import '../../todos/application/todos_providers.dart';
import '../../todos/domain/todo.dart';

/// ホーム画面用に「今日の予定」と「期日の近いタスク3件」をまとめて取得。
typedef HomePageData = ({
  List<Schedule> todaySchedules,
  List<Todo> nearestTodos,
});

final homePageDataProvider = FutureProvider.autoDispose<HomePageData>((
  ref,
) async {
  final user = ref.watch(currentUserProvider);
  if (user == null) {
    throw Exception(
      'セッションがありません。アプリ再起動直後は復元に時間かかることがあります。再試行するか、再度ログインしてください。',
    );
  }
  final today = await ref.watch(todaySchedulesProvider.future);
  final nearest = await ref.watch(nearestTodosProvider(3).future);
  return (todaySchedules: today, nearestTodos: nearest);
});
