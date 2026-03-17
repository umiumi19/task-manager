import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils/date_time_asia.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../application/schedules_providers.dart';
import '../../domain/schedule.dart';

class EditSchedulePage extends ConsumerStatefulWidget {
  const EditSchedulePage({required this.schedule, super.key});

  final Schedule schedule;

  @override
  ConsumerState<EditSchedulePage> createState() => _EditSchedulePageState();
}

class _EditSchedulePageState extends ConsumerState<EditSchedulePage> {
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;
  late final TextEditingController _locationController;

  late DateTime _startAt;
  DateTime? _endAt;

  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.schedule.title);
    _memoController = TextEditingController(text: widget.schedule.memo ?? '');
    _locationController =
        TextEditingController(text: widget.schedule.location ?? '');
    _startAt = widget.schedule.startAt;
    _endAt = widget.schedule.endAt;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickStartAt() async {
    final startAsia = toAsiaTokyo(_startAt);
    final date = await showDatePicker(
      context: context,
      initialDate: startAsia,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(startAsia),
    );
    if (!mounted || time == null) return;
    final pickedUtc = jstToUtc(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    setState(() {
      _startAt = pickedUtc;
      if (_endAt != null && _endAt!.isBefore(_startAt)) _endAt = null;
    });
  }

  Future<void> _pickEndAt() async {
    final startAsia = toAsiaTokyo(_startAt);
    final endAsia = _endAt != null ? toAsiaTokyo(_endAt!) : startAsia;
    final date = await showDatePicker(
      context: context,
      initialDate: endAsia,
      firstDate: startAsia,
      lastDate: DateTime(2100),
    );
    if (!mounted || date == null) return;
    final time = await showTimePicker(
      context: context,
      initialTime: _endAt != null
          ? TimeOfDay.fromDateTime(endAsia)
          : TimeOfDay.fromDateTime(startAsia.add(const Duration(hours: 1))),
    );
    if (!mounted || time == null) return;
    final pickedUtc = jstToUtc(DateTime(date.year, date.month, date.day, time.hour, time.minute));
    if (pickedUtc.isBefore(_startAt)) return;
    setState(() => _endAt = pickedUtc);
  }

  Future<void> _update() async {
    final title = _titleController.text.trim();
    if (title.isEmpty) {
      setState(() => _errorMessage = 'タイトルを入力してください');
      return;
    }
    if (_endAt != null && _endAt!.isBefore(_startAt)) {
      setState(() => _errorMessage = '終了日時は開始日時より後にしてください');
      return;
    }
    setState(() {
      _errorMessage = null;
      _isLoading = true;
    });
    try {
      final repo = ref.read(schedulesRepositoryProvider);
      await repo.update(
        widget.schedule.id,
        title: title,
        memo: _memoController.text.trim().isEmpty ? null : _memoController.text.trim(),
        startAt: _startAt,
        endAt: _endAt,
        location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
        todoId: widget.schedule.todoId,
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
      builder: (ctx) => AlertDialog(
        title: const Text('予定を削除'),
        content: const Text('この予定を削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: FilledButton.styleFrom(
              backgroundColor: Theme.of(ctx).colorScheme.error,
            ),
            child: const Text('削除'),
          ),
        ],
      ),
    );
    if (!mounted || confirmed != true) return;
    setState(() => _isLoading = true);
    try {
      final repo = ref.read(schedulesRepositoryProvider);
      await repo.delete(widget.schedule.id);
      if (mounted) context.pop(true);
    } catch (e) {
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
    final dateFormat = DateFormat('M/d (E) HH:mm', 'ja');
    final startAsia = toAsiaTokyo(_startAt);
    final endAsia = _endAt != null ? toAsiaTokyo(_endAt!) : null;

    return Scaffold(
      appBar: CustomAppBar(
        title: '予定を編集',
        onBackButtonPressed: () => context.pop(),
        actions: [
          TextButton(
            onPressed: _isLoading ? null : _delete,
            child: Text(
              '削除',
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
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
                labelText: 'タイトル',
                border: OutlineInputBorder(),
                hintText: 'タイトルを入力',
              ),
              maxLength: 255,
              onChanged: (_) => setState(() => _errorMessage = null),
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('開始日時'),
              subtitle: Text(dateFormat.format(startAsia)),
              trailing: const Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(4),
              ),
              onTap: _pickStartAt,
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('終了日時'),
              subtitle: Text(_endAt == null ? '未設定' : dateFormat.format(endAsia!)),
              trailing: const Icon(Icons.calendar_today),
              shape: RoundedRectangleBorder(
                side: BorderSide(color: Theme.of(context).colorScheme.outline),
                borderRadius: BorderRadius.circular(4),
              ),
              onTap: _pickEndAt,
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
              maxLines: 3,
              maxLength: 2000,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(
                labelText: '場所',
                border: OutlineInputBorder(),
                hintText: '場所を入力',
              ),
              maxLength: 255,
            ),
            if (_errorMessage != null) ...[
              const SizedBox(height: 16),
              Text(
                _errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ],
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _isLoading ? null : _update,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('更新'),
            ),
          ],
        ),
      ),
    );
  }
}
