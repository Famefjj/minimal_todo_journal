# Architecture

This project follows a feature-first Clean Architecture style for a minimal
todo journal Flutter app. It is based on the ideas from the video
"Clean Architecture in Flutter - All You Need to Know!" by Flutter Guys, and
aligned with Flutter's official app architecture guidance: separate UI,
application/domain logic, and data access so the app stays easy to change.

## Project Goals

- Keep `main.dart` small. It should only start the app.
- Keep app setup in `lib/app/`.
- Keep reusable, app-wide utilities in `lib/core/`.
- Keep reusable UI helpers in `lib/shared/`.
- Keep user-facing product areas in `lib/features/`.
- Keep feature code grouped by feature first, then by layer.

## Top-Level Folders

```text
lib/
  main.dart
  app/
  core/
  shared/
  features/
```

### `main.dart`

The Flutter entry point.

Use it for:

- `runApp(const App())`

Do not put screens, themes, routes, storage, or business logic here.

### `app/`

App-level configuration.

Use it for:

- `app.dart`: root `MaterialApp`
- `routes.dart`: route names and route setup
- `theme.dart`: app theme and visual system

### `core/`

App-wide non-UI logic that is not owned by one feature.

Use it for:

- storage adapters
- date helpers
- constants
- utility functions
- dependency setup if added later

Do not put feature-specific todo or journal logic in `core/`.

### `shared/`

Reusable UI or small helpers used by multiple features.

Use it for:

- shared widgets
- shared extensions
- reusable UI helpers

Do not put business logic here.

### `features/`

The main app behavior, grouped by product feature.

Current features:

- `today`: combined daily screen for today's todos and journal
- `todos`: todo planning and task behavior
- `journal`: daily journal entries
- `settings`: user preferences

## Feature Structure

Each feature may use this structure:

```text
features/
  feature_name/
    data/
      models/
      data_sources/
      repositories/
    domain/
      entities/
      repositories/
      use_cases/
    presentations/
      screens/
      widgets/
      controllers/
```

Note: this repo currently uses `presentations/` plural. Continue using
`presentations/` for consistency unless a dedicated cleanup renames every
feature to `presentation/` singular.

## Layer Responsibilities

### `domain/`

Pure app rules. This layer should be independent from Flutter UI and storage
details.

Use it for:

- `entities/`: clean business objects, such as `todo.dart`
- `repositories/`: abstract contracts, such as `todo_repository.dart`
- `use_cases/`: app actions, such as `get_todos_for_date.dart`

Rules:

- Do not import Flutter widgets.
- Do not call local storage directly.
- Do not depend on `data/` or `presentations/`.

### `data/`

Implementation details for saving, loading, and mapping data.

Use it for:

- `models/`: persistence/API models, such as `todo_model.dart`
- `data_sources/`: local database, files, shared preferences, or API access
- `repositories/`: implementations of domain repository contracts

Rules:

- Data sources talk to storage/API/platform code.
- Repository implementations convert data models into domain entities.
- UI should not import data sources directly.

### `presentations/`

Flutter UI and screen state.

Use it for:

- `screens/`: full pages, such as `today_screen.dart`
- `widgets/`: smaller UI components, such as `todo_tile.dart`
- `controllers/`: screen or feature state, such as `todos_controller.dart`

Rules:

- Screens compose widgets and listen to controllers.
- Controllers call use cases or repositories.
- Widgets should stay as simple as possible.
- UI should not know how local storage works.

## Dependency Direction

Prefer this dependency flow:

```text
presentations -> domain <- data
```

Allowed:

- `presentations` imports `domain`
- `data` imports `domain`
- `data` imports `core` storage/utilities
- `app` imports feature screens for routing

Avoid:

- `domain` importing `data`
- `domain` importing `presentations`
- widgets importing local storage directly
- one feature reaching into another feature's data sources

## Feature Rules For This App

### `today`

`today` is a composition feature. It shows today's todos and today's journal
entry together.

Use it for:

- `today_screen.dart`
- sections such as `today_todos_section.dart`
- sections such as `today_journal_section.dart`
- orchestration state for the Today page

Do not duplicate todo or journal entities here. Todo data belongs in `todos`.
Journal data belongs in `journal`.

### `todos`

`todos` owns task planning.

Use it for:

- todo entity
- todo model
- todo repository contract and implementation
- use cases for adding, completing, deleting, and moving todos by date
- todo widgets reused by todo-related screens

Example files:

```text
features/todos/domain/entities/todo.dart
features/todos/domain/repositories/todo_repository.dart
features/todos/domain/use_cases/get_todos_for_date.dart
features/todos/domain/use_cases/add_todo.dart
features/todos/domain/use_cases/complete_todo.dart
features/todos/data/models/todo_model.dart
features/todos/data/data_sources/todo_local_data_source.dart
features/todos/data/repositories/todo_repository_impl.dart
features/todos/presentations/controllers/todos_controller.dart
features/todos/presentations/widgets/todo_tile.dart
```

### `journal`

`journal` owns daily writing.

Use it for:

- journal entry entity
- journal model
- journal repository contract and implementation
- use cases for getting and saving entries by date
- journal editor widgets

Example files:

```text
features/journal/domain/entities/journal_entry.dart
features/journal/domain/repositories/journal_repository.dart
features/journal/domain/use_cases/get_journal_entry_for_date.dart
features/journal/domain/use_cases/save_journal_entry.dart
features/journal/data/models/journal_entry_model.dart
features/journal/data/data_sources/journal_local_data_source.dart
features/journal/data/repositories/journal_repository_impl.dart
features/journal/presentations/widgets/journal_editor.dart
```

### `settings`

`settings` owns preferences.

Use it for:

- theme mode preference if added later
- notification/reminder preference if added later
- settings screen and widgets

## Naming Rules

- Use `snake_case` for folders and Dart files.
- Use singular entity names: `todo.dart`, `journal_entry.dart`.
- Use `_model` for data models: `todo_model.dart`.
- Use `_repository` for contracts: `todo_repository.dart`.
- Use `_repository_impl` for implementations: `todo_repository_impl.dart`.
- Use action-style use case names: `add_todo.dart`, `get_todos_for_date.dart`.
- Use screen names ending in `_screen.dart`.
- Use controller names ending in `_controller.dart`.

## State Management

Until a package is intentionally added, keep state simple:

- Use `StatefulWidget` for small, local-only UI state.
- Use controllers for screen or feature state.
- Do not add Riverpod, BLoC, Provider, GetX, or another state package unless the
  task explicitly requires it.

## Storage

Local persistence should be reached through data sources and repositories.

Allowed flow:

```text
screen/controller -> use case -> repository contract -> repository impl -> data source -> core storage
```

Avoid:

```text
screen -> local storage
widget -> data source
domain -> local storage
```

## Testing Guidance

Add tests near the behavior being changed.

Prefer:

- unit tests for use cases
- unit tests for repository implementations with fake data sources
- controller tests for UI state logic
- widget tests for screens and reusable widgets

## Codex Working Rules

When editing this project:

1. Read `PROJECT_STRUCTURE.md` before creating or moving files.
2. Follow the existing folder style unless the task is a structure cleanup.
3. Keep code inside the smallest feature that owns the behavior.
4. Do not move logic into `core/` just because it is convenient.
5. Do not duplicate todo or journal business logic inside `today/`.
6. Update `PROJECT_STRUCTURE.md` whenever files or folders are added, deleted,
   moved, or renamed.
