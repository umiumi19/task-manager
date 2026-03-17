import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../common/utils/date_time_asia.dart';
import '../../../../common/widgets/custom_app_bar.dart';
import '../../../../common/widgets/form_widget_with_title.dart';
import '../../application/schedules_providers.dart';

class AddSchedulePage extends ConsumerStatefulWidget {
  const AddSchedulePage({super.key});

  @override
  ConsumerState<AddSchedulePage> createState() => _AddSchedulePageState();
}

class _AddSchedulePageState extends ConsumerState<AddSchedulePage> {
  final _titleController = TextEditingController();
  final _memoController = TextEditingController();
  final _locationController = TextEditingController();

  /// UTC で保持。表示は toAsiaTokyo で Asia/Tokyo に変換。
  late DateTime _startAt;
  DateTime? _endAt;

  @override
  void initState() {
    super.initState();
    _startAt = DateTime.now().toUtc();
  }

  bool _isLoading = false;
  String? _errorMessage;

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

  Future<void> _create() async {
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
      await repo.create(
        title: title,
        startAt: _startAt,
        memo: _memoController.text.trim().isEmpty ? null : _memoController.text.trim(),
        endAt: _endAt,
        location: _locationController.text.trim().isEmpty ? null : _locationController.text.trim(),
      );
      if (mounted) context.pop(true);
    } catch (e, st) {
      debugPrint('[AddSchedule] 作成失敗: $e');
      debugPrint(st.toString());
      if (mounted) {
        setState(() {
          _errorMessage = '作成に失敗しました';
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
        title: '予定を追加',
        onBackButtonPressed: () => context.pop(),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            FormWidgetWithTitle(
              title: 'タイトル',
              isRequired: true,
              child: TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'タイトルを入力',
                ),
                maxLength: 255,
                onChanged: (_) => setState(() => _errorMessage = null),
              ),
            ),
            const SizedBox(height: 16),
            FormWidgetWithTitle(
              title: '開始日時',
              isRequired: true,
              child: ListTile(
                title: Text(dateFormat.format(startAsia)),
                trailing: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.outline),
                  borderRadius: BorderRadius.circular(4),
                ),
                onTap: _pickStartAt,
              ),
            ),
            const SizedBox(height: 16),
            FormWidgetWithTitle(
              title: '終了日時',
              isRequired: false,
              child: ListTile(
                title: Text(_endAt == null ? '未設定' : dateFormat.format(endAsia!)),
                trailing: const Icon(Icons.calendar_today),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: Theme.of(context).colorScheme.outline),
                  borderRadius: BorderRadius.circular(4),
                ),
                onTap: _pickEndAt,
              ),
            ),
            const SizedBox(height: 16),
            FormWidgetWithTitle(
              title: 'メモ',
              isRequired: false,
              child: TextField(
                controller: _memoController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'メモを入力',
                  alignLabelWithHint: true,
                ),
                maxLines: 3,
                maxLength: 2000,
              ),
            ),
            const SizedBox(height: 16),
            FormWidgetWithTitle(
              title: '場所',
              isRequired: false,
              child: TextField(
                controller: _locationController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: '場所を入力',
                ),
                maxLength: 255,
              ),
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
              onPressed: _isLoading ? null : _create,
              child: _isLoading
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('作成'),
            ),
          ],
        ),
      ),
    );
  }
}
