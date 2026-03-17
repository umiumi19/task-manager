import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../theme/app_colors.dart';
import 'custom_app_bar.dart';

/// AsyncValue に応じて loading / error / data を表示する Scaffold 用ラッパー。
/// lecture_page の ScaffoldAsyncValueWidget に倣った仮実装。
class ScaffoldAsyncValueWidget<T> extends StatelessWidget {
  const ScaffoldAsyncValueWidget({
    required this.value,
    required this.data,
    super.key,
    this.appBar,
    this.loadingColor,
    this.errorMessage,
    this.onRetry,
  });

  final AsyncValue<T> value;
  final Widget Function(T) data;
  final PreferredSizeWidget? appBar;
  final Color? loadingColor;
  final String? errorMessage;

  /// エラー時に「再試行」ボタンで呼ばれる。指定するとボタンを表示する。
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    final color = loadingColor ?? context.appColors.primary;
    return value.when(
      data: data,
      error: (error, stackTrace) {
        debugPrint('[Home] 読み込みエラー: $error');
        debugPrint(stackTrace.toString());
        return Scaffold(
          appBar: appBar ?? const CustomAppBar(title: 'Deadline Planner'),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    errorMessage ?? '読み込みに失敗しました',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: context.appColors.error,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    error.toString(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: context.appColors.secondaryText,
                    ),
                  ),
                  if (onRetry != null) ...[
                    const SizedBox(height: 24),
                    FilledButton.tonal(
                      onPressed: onRetry,
                      child: const Text('再試行'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
      loading: () => Scaffold(
        appBar: appBar ?? const CustomAppBar(title: 'Deadline Planner'),
        body: Center(child: CircularProgressIndicator(color: color)),
      ),
    );
  }
}
