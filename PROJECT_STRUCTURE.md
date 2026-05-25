# Project Structure

This file documents the current folder layout for Codex and contributors.
Update it whenever files or folders are added, deleted, moved, or renamed.

```text
minimal_todo_journal/
  ARCHITECTURE.md
  PROJECT_STRUCTURE.md
  README.md
  analysis_options.yaml
  pubspec.yaml
  pubspec.lock
  test/
    widget_test.dart
  lib/
    main.dart
    app/
      app.dart
      routes.dart
      theme.dart
    core/
      constraints/
      storage/
        local_storage.dart
      utils/
    shared/
      extensions/
      widgets/
    features/
      today/
        data/
          data_sources/
          models/
          repositories/
        domain/
          entities/
          repositories/
          use_cases/
        presentations/
          controllers/
          screens/
            today_screen.dart
          widgets/
      todos/
        data/
          data_sources/
          models/
          repositories/
        domain/
          entities/
          repositories/
          use_cases/
        presentations/
          controllers/
          screens/
          widgets/
      journal/
        data/
          data_sources/
          models/
          repositories/
        domain/
          entities/
          repositories/
          use_cases/
        presentations/
          controllers/
          screens/
          widgets/
      settings/
        data/
          data_sources/
          models/
          repositories/
        domain/
          entities/
          repositories/
          use_cases/
        presentations/
          controllers/
          screens/
          widgets/
  android/
  ios/
  linux/
  macos/
  web/
  windows/
```

Flutter platform folders (`android/`, `ios/`, `linux/`, `macos/`, `web/`,
`windows/`) mostly contain generated or platform-specific runner files.
Application logic should usually stay inside `lib/`.
