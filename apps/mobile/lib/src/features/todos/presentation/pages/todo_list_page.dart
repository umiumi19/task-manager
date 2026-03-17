import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/app_sizes.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../router/route_names.dart';
import '../../application/todos_providers.dart';
import '../../domain/todo.dart';
import '../todo_list_tile/todo_list_tile.dart';

class TodoListPage extends ConsumerStatefulWidget {
  const TodoListPage({super.key});

  @override
  ConsumerState<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends ConsumerState<TodoListPage> {
  bool _includeDone = false;

  @override
  Widget build(BuildContext context) {
    final todosAsync = ref.watch(todoListProvider(_includeDone));

    return Scaffold(
      appBar: CustomAppBar(
        hasBackButton: false,
        title: _includeDone ? '完了済みのタスク' : '未完了のタスク',
        actions: [
          TextButton(
            onPressed: () => setState(() => _includeDone = !_includeDone),
            child: Text(_includeDone ? '未完了' : '完了済み'),
          ),
        ],
      ),
      body: todosAsync.when(
        data: (todos) {
          if (todos.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.check_circle_outline, size: 64, color: Theme.of(context).colorScheme.outline),
                  const SizedBox(height: 16),
                  Text(
                    _includeDone ? '該当するタスクはありません' : '未完了のタスクはありません',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _includeDone
                        ? '「未完了」をタップしてください。'
                        : '「完了済み」をタップするか、右下の＋で追加してください。',
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
            onRefresh: () async => ref.invalidate(todoListProvider(_includeDone)),
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSizes.p16,
                vertical: AppSizes.p8,
              ),
              itemCount: todos.length,
              separatorBuilder: (_, __) => gapH8,
              itemBuilder: (context, index) {
                final todo = todos[index];
                return TodoListTile(
                  todo: todo,
                  onTap: () => _openEdit(context, todo),
                );
              },
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('読み込みに失敗しました', style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => ref.invalidate(todoListProvider(_includeDone)),
                child: const Text('再試行'),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: _includeDone
          ? null
          : FloatingActionButton(
              onPressed: () => _openAdd(context),
              child: const Icon(Icons.add),
            ),
    );
  }

  Future<void> _openAdd(BuildContext context) async {
    final result = await context.push<bool>(RouteNames.addTodo);
    if (context.mounted && result == true) {
      ref.invalidate(todoListProvider(_includeDone));
    }
  }

  Future<void> _openEdit(BuildContext context, Todo todo) async {
    final result = await context.push<bool>('${RouteNames.todoList}/${todo.id}', extra: todo);
    if (context.mounted && result == true) {
      ref.invalidate(todoListProvider(_includeDone));
    }
  }
}
