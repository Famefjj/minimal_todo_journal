# Project Structure

This file documents the current folder layout for Codex and contributors.
Update it whenever files or folders are added, deleted, moved, or renamed.

```text
minimal_todo_journal/
  .flutter-plugins-dependencies
  .gitignore
  .metadata
  ARCHITECTURE.md
  PROJECT_STRUCTURE.md
  README.md
  analysis_options.yaml
  minimal_todo_journal.iml
  pubspec.yaml
  pubspec.lock
  assets/
    fonts/
      Lora-Bold.ttf
      Lora-BoldItalic.ttf
      Lora-Italic.ttf
      Lora-Medium.ttf
      Lora-MediumItalic.ttf
      Lora-Regular.ttf
      Lora-SemiBold.ttf
      Lora-SemiBoldItalic.ttf
    images/
    logos/
  test/
    widget_test.dart
  lib/
    main.dart
    app/
      app.dart
      app_theme.dart
      routes.dart
    core/
      constant/
      resources/
        data_state.dart
      utils/
    shared/
      extensions/
      widgets/
    features/
      today/
        data/
          data_sources/
            local/
              app_database.dart
              converters/
                date_time_converter.dart
              dao/
                todo_dao.dart
          models/
            todo_model.dart
          repositories/
            todo_repository_impl.dart
        domain/
          entities/
            todo_entity.dart
          repositories/
            todo_repository.dart
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

Generated/tooling folders such as `.dart_tool/`, `.git/`, and IDE metadata
folders are not expanded here.
