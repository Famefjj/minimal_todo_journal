import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/app/widgets/app_bottom_navigation_item.dart';

class AppBottomNavigationBar extends StatelessWidget {
  const AppBottomNavigationBar({
    super.key,
    this.currentIndex = 0,
    required this.onTap,
    required this.items,
  });

  final int currentIndex;
  final ValueChanged<int> onTap;
  final List<AppBottomNavigationItem> items;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return SafeArea(
      minimum: EdgeInsets.fromLTRB(20, 0, 20, 16),
      child: Container(
        height: 68,
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(
          color: colorScheme.surface.withValues(alpha: 0.5),
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: colorScheme.onSurface.withValues(alpha: 0.2),
              blurRadius: 28,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: List.generate(
            items.length,
            (index) => items[index].copyWith(
              isSelected: currentIndex == index,
              onTap: () => onTap(index),
            ),
          ),
        ),
      ),
    );
  }
}
