# Project Structure

This file documents the current folder layout for Codex and contributors.
Update it whenever files or folders are added, deleted, moved, or renamed.

```text
minimal_todo_journal/
  .flutter-plugins-dependencies
  .gitignore
  .metadata
  ARCHITECTURE.md
  PACKAGES.md
  PROJECT_STRUCTURE.md
  README.md
  analysis_options.yaml
  dependencies.dot
  minimal_todo_journal.iml
  pubspec.lock
  pubspec.yaml
  assets/
    fonts/
      Lora/
        Lora-Bold.ttf
        Lora-BoldItalic.ttf
        Lora-Italic.ttf
        Lora-Medium.ttf
        Lora-MediumItalic.ttf
        Lora-Regular.ttf
        Lora-SemiBold.ttf
        Lora-SemiBoldItalic.ttf
      Poppins/
        Poppins-Black.ttf
        Poppins-BlackItalic.ttf
        Poppins-Bold.ttf
        Poppins-BoldItalic.ttf
        Poppins-ExtraBold.ttf
        Poppins-ExtraBoldItalic.ttf
        Poppins-ExtraLight.ttf
        Poppins-ExtraLightItalic.ttf
        Poppins-Italic.ttf
        Poppins-Light.ttf
        Poppins-LightItalic.ttf
        Poppins-Medium.ttf
        Poppins-MediumItalic.ttf
        Poppins-Regular.ttf
        Poppins-SemiBold.ttf
        Poppins-SemiBoldItalic.ttf
        Poppins-Thin.ttf
        Poppins-ThinItalic.ttf
    images/
    logos/
  test/
    widget_test.dart
  lib/
    main.dart
    app/
      app.dart
      app_shell.dart
      router/
        app_router.dart
        app_routes.dart
      themes/
        app_button_theme.dart
        app_colors.dart
        app_text_theme.dart
        app_theme.dart
      widgets/
        app_bottom_navigation_bar.dart
        app_bottom_navigation_item.dart
    core/
      constants/
      resources/
        data_state.dart
      usecase/
        usecase.dart
      utils/
    shared/
      extensions/
      widgets/
    features/
      today/
        presentations/
          controllers/
          screens/
            today_screen.dart
          widgets/
            today_journal_section.dart
            today_todos_section.dart
      todos/
        data/
          data_sources/
            local/
              app_database.dart
              app_database.g.dart
              converters/
                date_time_converter.dart
              dao/
                todo_dao.dart
            remote/
          models/
            todo_model.dart
          repositories/
            todo_repository_impl.dart
        domain/
          entities/
            todo_entity.dart
          repositories/
            todo_repository.dart
          usecases/
            delete_todo_usecase.dart
            get_overdue_incompleted_todos_usecase.dart
            get_todos_by_date_usecase.dart
            get_todos_usecase.dart
            insert_todo_usecase.dart
        presentations/
          controllers/
          screens/
            todos_screen.dart
          widgets/
            circle_check_box.dart
            todo_list_view.dart
            todo_tile.dart
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
      progress/
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
            progress_screen.dart
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
            settings_screen.dart
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

Generated/tooling folders such as `.dart_tool/`, `.git/`, `build/`, and IDE
metadata folders are not expanded here.

Riverpod provider folders should be added under the feature that owns the state,
for example:

```text
features/todos/presentations/providers/
features/today/presentations/providers/
```

The existing `presentations/controllers/` folders are legacy placeholders from
the previous controller-based structure. Prefer `presentations/providers/` for
new Riverpod state. Rename or remove the old folders only during a dedicated
structure cleanup.

When those folders or provider files are actually created, update this structure
again.
