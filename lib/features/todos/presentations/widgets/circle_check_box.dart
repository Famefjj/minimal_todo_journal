import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircleCheckBox extends StatelessWidget {
  const CircleCheckBox({
    super.key,
    required this.onTap,
    required this.isChecked,
  });

  final bool isChecked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      child: isChecked
          ? Icon(
              CupertinoIcons.checkmark_circle_fill,
              size: 26,
              color: colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
            )
          : Icon(CupertinoIcons.circle, size: 26),
    );
  }
}
