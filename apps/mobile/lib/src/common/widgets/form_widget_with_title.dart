import 'package:flutter/material.dart';

import '../constants/app_sizes.dart';
import 'form_title.dart';

class FormWidgetWithTitle extends StatelessWidget {
  const FormWidgetWithTitle({
    required this.title,
    required this.isRequired,
    required this.child,
    super.key,
    this.topRightWidget,
    this.titleRightWidget,
    this.titleAndChildGap = AppSizes.p8,
  });

  final String title;
  final bool isRequired;
  final Widget? topRightWidget;
  final Widget? titleRightWidget;
  final Widget child;
  final double titleAndChildGap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FormTitle(
          title: title,
          isRequired: isRequired,
          topRightWidget: topRightWidget,
          titleRightWidget: titleRightWidget,
        ),
        SizedBox(height: titleAndChildGap),
        child,
      ],
    );
  }
}
