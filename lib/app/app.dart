import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/app/theme.dart';
import 'package:minimal_todo_journal/features/today/presentations/screens/today_screen.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Minimal Todo Journal',
      themeMode: ThemeMode.system,
      home: const TodayScreen(),
    );
  }
}
