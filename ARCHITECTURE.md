# Architecture

This project follows a feature-first Clean Architecture style for a minimal
todo journal Flutter app. The goal is to keep UI, app/domain rules, and data
access separate so the app stays small now and easy to extend later.

The app uses Riverpod for presentation state and dependency wiring at the UI
boundary.

## Project Goals

- Keep `main.dart` small. It should only start the app.
- Keep app setup in `lib/app/`.
- Keep reusable, app-wide non-UI utilities in `lib/core/`.
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

- `runApp(...)`
- wrapping the app with `ProviderScope`
- one-time Flutter initialization when needed

Do not put screens, themes, routes, storage, or business logic here.

### `app/`

App-level composition and Flutter shell configuration.

`app/` sits above the feature folders. It is allowed to import feature
presentation screens so it can assemble the app, configure `MaterialApp`, apply
themes, and set up routes.

Use it for:

- `app.dart`: root `MaterialApp.router`
- `app_shell.dart`: app-wide shell layout, such as tab navigation
- `router/`: route names and `GoRouter` setup
- `themes/`: app theme, colors, text theme, and component themes
- `widgets/`: app-shell widgets, such as the bottom navigation bar

Do not import `app/` files from inside feature code. Features should stay below
the app shell and should not depend on the root composition layer.

Keep app theme and router setup inside `app/` unless there is a specific need to
extract neutral constants or reusable UI into `core/` or `shared/`.

### `core/`

App-wide non-UI logic that is not owned by one feature.

Use it for:

- `constants/`: app-wide constants that are not owned by one feature
- `resources/`: shared result/resource wrappers, such as `data_state.dart`
- `usecase/`: shared use case base types
- `utils/`: reusable date, formatting, parsing, and utility helpers

Do not put feature-specific todo, journal, progress, or settings logic in
`core/`.

Do not use `core/` as a dumping ground for convenience imports. If code belongs
to one product area, keep it inside that feature.

Keep `core/resources/` independent from transport-specific packages when
possible. For example, `DataState` may carry an `Object` error, while Dio,
Retrofit, Floor, or Sqflite-specific error handling should stay in
`data_sources/` or repository implementations.

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
- `progress`: minimal progress/history view
- `settings`: user preferences

### `assets/`

Static app assets live outside `lib/`.

Current asset folders:

- `fonts/Lora/`: bundled Lora font files
- `fonts/Poppins/`: bundled Poppins font files
- `images/`: app image assets
- `logos/`: app logo assets

Register fonts and asset folders in `pubspec.yaml` before using them from the
app. Theme setup that uses bundled fonts belongs in `app/themes/`.

## Feature Structure

Each feature may use this structure:

```text
features/
  feature_name/
    data/
      data_sources/
      models/
      repositories/
    domain/
      entities/
      repositories/
      usecases/
    presentations/
      providers/
      screens/
      widgets/
```

Note: this repo currently uses `presentations/` plural. Continue using
`presentations/` for consistency unless a dedicated cleanup renames every
feature to `presentation/` singular.

Only create folders when they are useful. For example, a simple placeholder
screen does not need empty `data/`, `domain/`, or `providers/` folders yet.

## Layer Responsibilities

### `domain/`

Pure app rules. This layer should be independent from Flutter UI and storage
details.

Use it for:

- `entities/`: clean business objects, such as `todo_entity.dart`
- `repositories/`: abstract contracts, such as `todo_repository.dart`
- `usecases/`: app actions, such as `get_todos_by_date_usecase.dart`

Rules:

- Do not import Flutter widgets.
- Do not import Riverpod.
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
- `providers/`: Riverpod providers, notifiers, and UI state for the feature

Rules:

- Screens compose widgets and watch providers.
- Providers/notifiers should call use cases.
- Direct repository contract access is allowed only for simple pass-through
  state where no use case exists yet.
- Widgets should stay as simple as possible.
- UI should not know how local storage works.

## Riverpod Placement

Put providers where the state is owned.

Use feature providers for feature-owned state:

```text
features/todos/presentations/providers/todos_provider.dart
features/today/presentations/providers/today_provider.dart
features/progress/presentations/providers/progress_provider.dart
features/settings/presentations/providers/settings_provider.dart
```

Use app providers only for app-shell state or app-wide dependencies:

```text
app/providers/router_provider.dart
app/providers/theme_mode_provider.dart
```

Do not put todo providers in `today/` just because `TodayScreen` displays
todos. Todo state belongs to `todos`; Today may watch todo providers and compose
the result with journal state.

## App Shell, Routes, and Theme

The root dependency direction is:

```text
main.dart -> app -> features
```

That means `app/app.dart` and `app/router/app_router.dart` may import feature
screens for routing or navigation setup. Feature files should not import
`app/app.dart`, `app/app_shell.dart`, `app/router/app_router.dart`, or
`app/themes/app_theme.dart`.

Theme setup should work like this:

```text
app/themes/app_theme.dart -> defines ThemeData
app/app.dart -> applies ThemeData to MaterialApp
features/widgets -> read Theme.of(context)
```

Feature widgets should use Flutter's inherited theme from the build context:

```dart
final colorScheme = Theme.of(context).colorScheme;
final textTheme = Theme.of(context).textTheme;
```

Do not import `app/themes/app_theme.dart` from a feature just to access colors,
text styles, or spacing. If a feature needs reusable design tokens, prefer a
neutral location such as `core/constants/` for constants or a future
`shared/theme/` folder for reusable UI theme extensions.

Routes follow the same rule. Keep route setup in `app/router/`. If features
need to trigger navigation, prefer callbacks from the app/screen boundary or
use route-name constants without depending on app composition classes.

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
- `domain` importing Riverpod
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
- todo providers for todo list state and mutations
- todo widgets reused by todo-related screens

Example files:

```text
features/todos/domain/entities/todo_entity.dart
features/todos/domain/repositories/todo_repository.dart
features/todos/domain/usecases/get_todos_by_date_usecase.dart
features/todos/domain/usecases/insert_todo_usecase.dart
features/todos/domain/usecases/delete_todo_usecase.dart
features/todos/data/models/todo_model.dart
features/todos/data/data_sources/local/dao/todo_dao.dart
features/todos/data/repositories/todo_repository_impl.dart
features/todos/presentations/providers/todos_provider.dart
features/todos/presentations/widgets/todo_tile.dart
```

### `journal`

`journal` owns daily writing.

Use it for:

- journal entry entity
- journal model
- journal repository contract and implementation
- use cases for getting and saving entries by date
- journal providers for journal state and mutations
- journal editor widgets

Example files:

```text
features/journal/domain/entities/journal_entry_entity.dart
features/journal/domain/repositories/journal_repository.dart
features/journal/domain/usecases/get_journal_entry_for_date_usecase.dart
features/journal/domain/usecases/save_journal_entry_usecase.dart
features/journal/data/models/journal_entry_model.dart
features/journal/data/data_sources/local/journal_local_data_source.dart
features/journal/data/repositories/journal_repository_impl.dart
features/journal/presentations/providers/journal_provider.dart
features/journal/presentations/widgets/journal_editor.dart
```

### `progress`

`progress` owns the minimal history/progress view.

Progress may compose data from todos and journal. It only needs its own domain
entity when it introduces its own meaning, such as a `DailyProgressEntity` with
completion percent, planned status, journal status, or day status.

Use it for:

- progress screen and widgets
- progress providers that compose todo/journal data
- progress-specific entities and use cases only when the rules become real app
  concepts

### `settings`

`settings` owns preferences.

Use it for:

- theme mode preference if added later
- notification/reminder preference if added later
- settings screen and widgets
- settings providers for preference state

## Naming Rules

- Use `snake_case` for folders and Dart files.
- Use singular entity names: `todo_entity.dart`, `journal_entry_entity.dart`.
- Use `_model` for data models: `todo_model.dart`.
- Use `_repository` for contracts: `todo_repository.dart`.
- Use `_repository_impl` for implementations: `todo_repository_impl.dart`.
- Use action-style use case names: `insert_todo_usecase.dart`,
  `get_todos_by_date_usecase.dart`.
- Use screen names ending in `_screen.dart`.
- Use provider files ending in `_provider.dart`.
- Use notifier classes ending in `Notifier`, such as `TodosNotifier`.
- Use immutable state classes ending in `State`, such as `TodosState`.

## State Management

This project uses `flutter_riverpod`, `flutter_hooks`, `equatable`, and
`get_it`.

Use Riverpod as the primary state management and dependency wiring approach:

- Wrap the app with `ProviderScope` in `main.dart`.
- Use `ConsumerWidget` or `ConsumerStatefulWidget` for widgets that need
  provider access.
- Use `ref.watch` to rebuild UI from provider state.
- Use `ref.read` for one-time actions, such as button taps.
- Use `ref.listen` for one-off effects, such as snack bars or navigation
  reactions.
- Use `Provider` for stable dependencies and simple computed values.
- Use `FutureProvider` or `StreamProvider` for read-only async data.
- Use `NotifierProvider` or `AsyncNotifierProvider` for feature state that has
  mutations, such as add todo, toggle todo, save journal, or change settings.
- Keep feature providers in the feature's `presentations/providers/` folder.
- Providers and notifiers should call use cases, not data sources or local
  storage.

Use `equatable` for state/value classes that need stable equality. Riverpod
does not require Equatable, but immutable value equality is still useful.

Use `flutter_hooks` only for widget-local lifecycle state, such as text editing
controllers, focus nodes, animation controllers, or small local UI toggles. Do
not use hooks as a replacement for feature state that belongs in Riverpod.

Use `get_it` only for existing app-level service registration when needed.
Prefer Riverpod providers for new dependency wiring so widgets can override
dependencies cleanly in tests.

Do not add another state management package, such as Bloc, Provider, GetX, or
MobX, unless the task explicitly requires changing the architecture.

## Storage

Local persistence should be reached through data sources and repositories.

This project currently includes `floor` for local SQLite persistence and
`retrofit` for remote API adapters. Prefer local-first persistence for todos and
journal entries unless a feature explicitly needs sync or remote data.

Allowed flow:

```text
screen/widget -> provider/notifier -> use case -> repository contract -> repository impl -> data source -> Floor database
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
- provider/notifier tests for UI state logic
- widget tests with `ProviderScope` overrides for screens and reusable widgets

## Codex Working Rules

When editing this project:

1. Read `PROJECT_STRUCTURE.md`, `ARCHITECTURE.md`, `PACKAGES.md`, and
   `pubspec.yaml` before writing code.
2. Follow the existing folder style unless the task is a structure cleanup.
3. Keep code inside the smallest feature that owns the behavior.
4. Do not move logic into `core/` just because it is convenient.
5. Do not duplicate todo or journal business logic inside `today/`.
6. Put Riverpod providers in the feature that owns the state.
7. Update `PROJECT_STRUCTURE.md` whenever files or folders are added, deleted,
   moved, or renamed.
