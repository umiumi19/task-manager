import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../constants/app_sizes.dart';
import '../theme/app_colors.dart';
import '../theme/app_text_styles.dart';

/// clalin-mobile の CustomAppBar に倣った共通 AppBar。
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    this.title,
    this.title2,
    this.actions,
    this.hasBackButton = true,
    this.leading,
    this.onBackButtonPressed,
    this.bottom,
    this.showUnderline = true,
    this.backgroundColor,
    this.isLoading = false,
  });

  final String? title;
  final String? title2;
  final List<Widget>? actions;
  final bool hasBackButton;
  final Widget? leading;
  final VoidCallback? onBackButtonPressed;
  final PreferredSizeWidget? bottom;
  final bool showUnderline;
  final Color? backgroundColor;
  final bool isLoading;

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight +
            (bottom?.preferredSize.height ?? 0) +
            (bottom != null ? AppSizes.p8 : 0),
      );

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: backgroundColor ?? context.appColors.surface,
      child: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.p16),
              height: kToolbarHeight,
              child: Row(
                children: [
                  if (leading != null) leading!,
                  if (hasBackButton)
                    IconButton(
                      icon: Icon(Icons.arrow_back, color: context.appColors.subtleText),
                      onPressed: isLoading
                          ? null
                          : onBackButtonPressed ?? () => context.pop(),
                    ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Text(
                            title!,
                            style: context.textStyles.headingMediumBold
                                .withPrimaryTextColor(context),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                        if (title2 != null)
                          Text(
                            title2!,
                            style: context.textStyles.headingMediumBold
                                .withPrimaryTextColor(context),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                      ],
                    ),
                  ),
                  if (actions != null) ...actions!,
                ],
              ),
            ),
            if (bottom != null) bottom!,
          ],
        ),
      ),
    );
  }
}
