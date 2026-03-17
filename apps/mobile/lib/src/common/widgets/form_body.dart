import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';

class FormBody extends StatelessWidget {
  const FormBody({
    required this.formWidgets,
    required this.isLoading,
    required this.appBar,
    this.bottomButton,
    this.backgroundColor,
    super.key,
  });

  final List<Widget> formWidgets;
  final bool isLoading;
  final Widget? bottomButton;
  final PreferredSizeWidget appBar;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: !isLoading, // ローディング中はスライドバック禁止
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: appBar, // Scaffold で囲み、appBar を受け取る
        body: AbsorbPointer(
          absorbing: isLoading, // ローディング中はタップ禁止
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              // フォーカス外し（背景タップ）
              final currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus &&
                  currentFocus.focusedChild != null) {
                currentFocus.focusedChild?.unfocus();
              }
            },
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        padding: formPagePadding,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: formWidgetSpacing,
                          children: [...formWidgets],
                        ),
                      ),
                    ),
                  ),
                  ?bottomButton,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
