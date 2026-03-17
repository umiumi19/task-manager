import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import '../theme/app_text_styles.dart';

class FormTitle extends StatelessWidget {
  const FormTitle({
    required this.title,
    super.key,
    this.topRightWidget,
    this.titleRightWidget,
    this.isRequired = false,
  });

  final String title;
  final Widget? topRightWidget;
  final Widget? titleRightWidget;
  final bool isRequired;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: context.textStyles.headingMediumSemibold
                  .withSecondaryTextColor(context),
            ),
            if (isRequired) gapW8,
            if (isRequired)
              Text(
                '※必須',
                style: context.textStyles.labelSmallSemibold.withPrimaryColor(
                  context,
                ),
              ),
            if (titleRightWidget != null) gapW8,
            if (titleRightWidget != null) titleRightWidget!,
            if (topRightWidget != null) const Spacer(),
            if (topRightWidget != null) topRightWidget!,
          ],
        ),
      ],
    );
  }
}
