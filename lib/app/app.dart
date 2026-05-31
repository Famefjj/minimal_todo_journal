import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/app/router/app_router.dart';
import 'package:minimal_todo_journal/app/themes/app_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Minimal Todo Journal',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
