import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:minimal_todo_journal/app/widgets/app_bottom_navigation_bar.dart';
import 'package:minimal_todo_journal/app/widgets/app_bottom_navigation_item.dart';

class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AppBottomNavigationBar(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
        items: [
          AppBottomNavigationItem(
            icon: CupertinoIcons.house,
            selectedIcon: CupertinoIcons.house_fill,
            label: 'Today',
          ),
          AppBottomNavigationItem(
            icon: CupertinoIcons.checkmark_circle,
            selectedIcon: CupertinoIcons.checkmark_circle_fill,
            label: 'Todo',
          ),
          AppBottomNavigationItem(
            icon: CupertinoIcons.graph_square,
            selectedIcon: CupertinoIcons.graph_square_fill,
            label: 'Progress',
          ),
          AppBottomNavigationItem(
            icon: CupertinoIcons.gear,
            selectedIcon: CupertinoIcons.gear_solid,
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
