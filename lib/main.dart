import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_todo_journal/app/app.dart';
import 'package:minimal_todo_journal/features/todos/data/data_sources/local/app_database.dart';
import 'package:minimal_todo_journal/features/todos/presentations/providers/todos_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final localDatabase = await $FloorAppDatabase
      .databaseBuilder('app_database.db')
      .build();

  runApp(
    ProviderScope(
      overrides: [appDatabaseProvider.overrideWithValue(localDatabase)],
      child: const App(),
    ),
  );
}
