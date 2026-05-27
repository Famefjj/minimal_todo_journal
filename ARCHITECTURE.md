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
- Keep static app assets in top-level `assets/`.
- Keep feature code grouped by feature first, then by layer.

## Top-Level Folders

```text
lib/
  main.dart
  app/
  core/
  shared/
  features/
assets/
  fonts/
  images/
  logos/
```

### `main.dart`

The Flutter entry point.

Use it for:

- `runApp(const App())`

Do not put screens, themes, routes, storage, or business logic here.

### `app/`

App-level composition and Flutter shell configuration.

`app/` sits above the feature folders. It is allowed to import feature
presentation screens so it can assemble the app, configure `MaterialApp`, apply
themes, and set up routes.

Use it for:

- `app.dart`: root `MaterialApp`
- `routes.dart`: route names and route setup
- `theme.dart`: app theme and visual system

Do not import `app/` files from inside feature code. Features should stay below
the app shell and should not depend on the root composition layer.

Keep `routes.dart` and `theme.dart` in `app/` unless there is a specific need to
extract shared constants or theme tokens into a neutral folder.

### `core/`

App-wide non-UI logic that is not owned by one feature.

Use it for:

- `constant/`: app-wide constants that are not owned by one feature
- `resources/`: shared result/resource wrappers, such as `data_state.dart`
- `utils/`: reusable date, formatting, parsing, and utility helpers

Do not put feature-specific todo or journal logic in `core/`.

Do not use `core/` as a dumping ground for convenience imports. If code belongs
to one product area, keep it inside that feature.

Keep `core/resources/` independent from transport-specific packages when
possible. For example, `DataState` may carry an `Object` error, while Dio or
Retrofit-specific error handling should stay in `data_sources/` or repository
implementations.

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

### `assets/`

Static app assets live outside `lib/`.

Current asset folders:

- `fonts/`: bundled Lora font files
- `images/`: app image assets
- `logos/`: app logo assets

Register fonts and asset folders in `pubspec.yaml` before using them from the
app. Theme setup that uses bundled fonts still belongs in `app/theme.dart`.

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
- `data_sources/`: Floor database access, files, shared preferences, or
  Retrofit API access
- `repositories/`: implementations of domain repository contracts

Rules:

- Data sources talk to database/API/platform code.
- Repository implementations convert data models into domain entities.
- UI should not import data sources directly.

### `presentations/`

Flutter UI and screen state.

Use it for:

- `screens/`: full pages, such as `today_screen.dart`
- `widgets/`: smaller UI components, such as `todo_tile.dart`
- `controllers/`: Cubits, Blocs, or simple controllers for screen/feature
  state, such as `todos_cubit.dart`

Rules:

- Screens compose widgets and listen to Cubits, Blocs, or controllers.
- Cubits, Blocs, and controllers should call use cases. Direct repository
  contract access is allowed only for simple pass-through state where no use
  case exists yet.
- Widgets should stay as simple as possible.
- UI should not know how local storage works.

## App Shell, Routes, and Theme

The root dependency direction is:

```text
main.dart -> app -> features
```

That means `app/app.dart` may import feature screens for `home`, routes, or
navigation setup. Feature files should not import `app/app.dart`,
`app/routes.dart`, or `app/theme.dart`.

Theme setup should work like this:

```text
app/theme.dart -> defines ThemeData
app/app.dart -> applies ThemeData to MaterialApp
features/widgets -> read Theme.of(context)
```

Feature widgets should use Flutter's inherited theme from the build context:

```dart
final colorScheme = Theme.of(context).colorScheme;
final textTheme = Theme.of(context).textTheme;
```

Do not import `app/theme.dart` from a feature just to access colors, text styles,
or spacing. If a feature needs reusable design tokens, prefer a neutral location
such as `core/constant/` for constants or a future `shared/theme/` folder for UI
theme extensions.

Routes follow the same rule. Keep route setup in `app/routes.dart`. If features
need to trigger navigation, prefer callbacks from the app/screen boundary or use
neutral route-name constants outside `app/` rather than importing
`app/routes.dart`.

## Dependency Direction

Prefer this dependency flow:

```text
presentations -> domain <- data
```

At the app root, prefer:

```text
main.dart -> app -> features
```

Allowed:

- `presentations` imports `domain`
- `data` imports `domain`
- `data` imports `core` constants/utilities
- `data_sources` use Floor, Retrofit, or platform packages behind repository
  implementations
- `app` imports feature screens for routing
- feature UI imports shared widgets/extensions or pure core utilities when they
  are not app-shell concerns

Avoid:

- features importing `app/`
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
features/todos/presentations/controllers/todos_cubit.dart
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
- Use Cubit names ending in `_cubit.dart`.
- Use Bloc names ending in `_bloc.dart`, event files ending in `_event.dart`,
  and state files ending in `_state.dart`.
- Use simple controller names ending in `_controller.dart` only when Cubit or
  Bloc would be unnecessary.

## State Management

This project uses `flutter_bloc`, `flutter_hooks`, `equatable`, and `get_it`.

Use `flutter_bloc` as the primary state management approach:

- Prefer `Cubit` for simple screen or feature state.
- Use `Bloc` when the feature benefits from explicit events.
- Keep Cubit/Bloc classes in the feature's `presentations/controllers/`
  folder unless a dedicated structure cleanup renames the folder.
- Cubits and Blocs should call use cases, not data sources or local storage.
- UI should use `BlocProvider`, `BlocBuilder`, `BlocListener`, and
  `BlocConsumer` from `flutter_bloc`.

Use `equatable` for Bloc events, Bloc states, Cubit states, and value objects
that need stable equality.

Use `flutter_hooks` only for widget-local lifecycle state, such as text editing
controllers, focus nodes, animation controllers, or small local UI toggles. Do
not use hooks as a replacement for feature state that belongs in Cubit or Bloc.

Use `get_it` for dependency registration and lookup at the app composition
boundary. Prefer providing Cubits/Blocs with `BlocProvider` from dependencies
registered in `get_it`. Avoid calling `get_it` directly from widgets when a
dependency can be passed in or provided above the widget.

Do not add another state management package, such as Riverpod, Provider, GetX,
or MobX, unless the task explicitly requires changing the architecture.

## Storage

Local persistence should be reached through data sources and repositories.

This project currently includes `floor` for local SQLite persistence and
`retrofit` for remote API adapters. Prefer local-first persistence for todos and
journal entries unless a feature explicitly needs sync or remote data.

Allowed flow:

```text
screen/controller -> use case -> repository contract -> repository impl -> data source -> Floor database
```

Avoid:

```text
screen -> local storage
widget -> data source
widget -> Retrofit service
domain -> Floor database
domain -> local storage
```

## Testing Guidance

Add tests near the behavior being changed.

Prefer:

- unit tests for use cases
- unit tests for repository implementations with fake data sources
- Cubit, Bloc, or controller tests for UI state logic
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
