import 'package:flutter/material.dart';

class AppBottomNavigationItem extends StatelessWidget {
  const AppBottomNavigationItem({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.icon,
    required this.selectedIcon,
    this.label = "",
  });

  final VoidCallback? onTap;
  final bool isSelected;
  final IconData icon;
  final IconData selectedIcon;
  final String label;

  AppBottomNavigationItem copyWith({
    VoidCallback? onTap,
    bool? isSelected,
    IconData? icon,
    IconData? selectedIcon,
    String? label,
  }) {
    return AppBottomNavigationItem(
      onTap: onTap ?? this.onTap,
      isSelected: isSelected ?? this.isSelected,
      icon: icon ?? this.icon,
      selectedIcon: selectedIcon ?? this.selectedIcon,
      label: label ?? this.label,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(microseconds: 180),
          curve: Curves.easeOut,
          decoration: BoxDecoration(
            color: isSelected
                ? colorScheme.onSurface.withValues(alpha: 0.07)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                isSelected ? selectedIcon : icon,
                size: 28,
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(height: 3),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.labelSmall?.copyWith(
                  color: isSelected
                      ? colorScheme.onSurfaceVariant
                      : colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
