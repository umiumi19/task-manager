import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../common/constants/app_sizes.dart';
import '../common/constants/keys.dart';
import '../common/theme/app_colors.dart';

/// ホーム / タスク の 2 タブ用シェル。ScaffoldWithNestedNavigation に倣う。
class MainTabScaffold extends StatelessWidget {
  const MainTabScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return _ScaffoldWithNavigationBar(
      body: navigationShell,
      currentIndex: navigationShell.currentIndex,
      onDestinationSelected: _goBranch,
    );
  }
}

class _ScaffoldWithNavigationBar extends StatelessWidget {
  const _ScaffoldWithNavigationBar({
    required this.body,
    required this.currentIndex,
    required this.onDestinationSelected,
  });

  final Widget body;
  final int currentIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Keys.drawerScaffoldKey,
      body: body,
      // drawer: const _SideBar(), // TODO: サイドバー実装時に有効化
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: context.appColors.stroke,
              width: AppSizes.strokeW,
            ),
          ),
        ),
        child: CupertinoTabBar(
          currentIndex: currentIndex,
          backgroundColor: context.appColors.surface,
          activeColor: context.appColors.primaryText,
          inactiveColor: context.appColors.subtleText,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.event_note_outlined, size: 24),
              activeIcon: Icon(Icons.event_note_rounded, size: 24),
              label: 'ホーム',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.fact_check_outlined, size: 24),
              activeIcon: Icon(Icons.fact_check_rounded, size: 24),
              label: 'タスク',
            ),
          ],
          onTap: onDestinationSelected,
        ),
      ),
    );
  }
}

// --- サイドバー（将来用）。必要な Provider / ルートが揃ったら drawer のコメントを外し、このクラスを有効化する。
//
// class _SideBar extends ConsumerWidget {
//   const _SideBar();
//
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Drawer(
//       backgroundColor: context.appColors.surface,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.only(
//           topRight: Radius.circular(AppSizes.p24),
//           bottomRight: Radius.circular(AppSizes.p24),
//         ),
//       ),
//       child: SafeArea(
//         child: ListView(
//           padding: EdgeInsets.zero,
//           children: const [
//             // ロゴ・メニュー項目など
//           ],
//         ),
//       ),
//     );
//   }
// }
