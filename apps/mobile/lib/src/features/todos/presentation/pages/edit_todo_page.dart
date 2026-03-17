import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/widgets/custom_app_bar.dart';
import '../../application/todos_providers.dart';
import '../../domain/todo.dart';

class EditTodoPage extends ConsumerStatefulWidget {
  const EditTodoPage({required this.todo, super.key});

  final Todo todo;

  @override
  ConsumerState<EditTodoPage> createState() => _EditTodoPageState();
}

class _EditTodoPageState extends ConsumerState<EditTodoPage> {
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;
  bool _isDone = false;
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.todo.title);
    _memoController = TextEditingController(text: widget.todo.memo ?? '');
    _isDone = widget.todo.isDone;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  Future<void> _update() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _errorMessage = 'タスク名を入力してください');
      return;
    }
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    try {
      final repo = ref.read(todosRepositoryProvider);
      await repo.update(
        widget.todo.id,
        title: title,
        memo: _memoController.text.trim().isEmpty ? null : _memoController.text.trim(),
        dueAt: widget.todo.dueAt,
        isDone: _isDone,
        priority: widget.todo.priority,
        estimatedMinutes: widget.todo.estimatedMinutes,
      );
      if (mounted) context.pop(true);
    } catch (e) {
      if (mounted) {
        setState(() {
          _errorMessage = '更新に失敗しました';
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _delete() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('タスク削除'),
        content: const Text('このタスクを削除しますか？'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('キャンセル')),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.error),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(todosRepositoryProvider);
      await repo.delete(widget.todo.id);
      if (mounted) context.pop(true);
    } catch (_) {
      if (mounted) {
        setState(() {
          _errorMessage = '削除に失敗しました';
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: 'タスク編集',
        onBackButtonPressed: () => context.pop(),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _isLoading ? null : _delete,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'タスク名',
                border: OutlineInputBorder(),
                hintText: 'タスク名を入力',
              ),
              maxLength: 255,
              onChanged: (_) => setState(() => _errorMessage = null),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _memoController,
              decoration: const InputDecoration(
                labelText: 'メモ',
                border: OutlineInputBorder(),
                hintText: 'メモを入力',
                alignLabelWithHint: true,
              ),
              maxLines: 4,
              maxLength: 2000,
            ),
            const SizedBox(height: 16),
            SwitchListTile(
              title: const Text('完了'),
              value: _isDone,
              onChanged: (v) => setState(() => _isDone = v),
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(_errorMessage!, style: TextStyle(color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isLoading ? null : _update,
              child: _isLoading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('更新'),
            ),
          ],
        ),
      ),
    );
  }
}
