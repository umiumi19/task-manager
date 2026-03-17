import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'router/app_router.dart';
import 'common/theme/app_colors.dart';
import 'common/theme/app_text_styles.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'Deadline Planner',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
        extensions: [AppColors.light, AppTextStyles.base],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.dark(primary: AppColors.dark.primary),
        useMaterial3: true,
        extensions: [AppColors.dark, AppTextStyles.base],
      ),
      debugShowCheckedModeBanner: false,
      locale: const Locale('ja', 'JP'),
      routerConfig: router,
    );
  }
}
