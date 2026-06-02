// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  TodoDao? _todoDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `todo` (`id` TEXT NOT NULL, `title` TEXT NOT NULL, `isCompleted` INTEGER NOT NULL, `startDateTime` INTEGER NOT NULL, `dueDateTime` INTEGER, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  TodoDao get todoDao {
    return _todoDaoInstance ??= _$TodoDao(database, changeListener);
  }
}

class _$TodoDao extends TodoDao {
  _$TodoDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _todoModelInsertionAdapter = InsertionAdapter(
            database,
            'todo',
            (TodoModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'startDateTime':
                      _dateTimeConverter.encode(item.startDateTime),
                  'dueDateTime':
                      _nullableDateTimeConverter.encode(item.dueDateTime)
                }),
        _todoModelUpdateAdapter = UpdateAdapter(
            database,
            'todo',
            ['id'],
            (TodoModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'startDateTime':
                      _dateTimeConverter.encode(item.startDateTime),
                  'dueDateTime':
                      _nullableDateTimeConverter.encode(item.dueDateTime)
                }),
        _todoModelDeletionAdapter = DeletionAdapter(
            database,
            'todo',
            ['id'],
            (TodoModel item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'isCompleted': item.isCompleted ? 1 : 0,
                  'startDateTime':
                      _dateTimeConverter.encode(item.startDateTime),
                  'dueDateTime':
                      _nullableDateTimeConverter.encode(item.dueDateTime)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<TodoModel> _todoModelInsertionAdapter;

  final UpdateAdapter<TodoModel> _todoModelUpdateAdapter;

  final DeletionAdapter<TodoModel> _todoModelDeletionAdapter;

  @override
  Future<void> deleteTodosWithNullId() async {
    await _queryAdapter.queryNoReturn('DELETE FROM todo WHERE id IS NULL');
  }

  @override
  Future<List<TodoModel>> getTodos() async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo ORDER BY startDateTime ASC',
        mapper: (Map<String, Object?> row) => TodoModel(
            id: row['id'] as String,
            title: row['title'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            startDateTime:
                _dateTimeConverter.decode(row['startDateTime'] as int),
            dueDateTime:
                _nullableDateTimeConverter.decode(row['dueDateTime'] as int?)));
  }

  @override
  Future<List<TodoModel>> getTodosForDate(
    DateTime dateStart,
    DateTime dateEnd,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo WHERE startDateTime >= ?1 AND startDateTime < ?2 ORDER BY startDateTime ASC',
        mapper: (Map<String, Object?> row) => TodoModel(id: row['id'] as String, title: row['title'] as String, isCompleted: (row['isCompleted'] as int) != 0, startDateTime: _dateTimeConverter.decode(row['startDateTime'] as int), dueDateTime: _nullableDateTimeConverter.decode(row['dueDateTime'] as int?)),
        arguments: [
          _dateTimeConverter.encode(dateStart),
          _dateTimeConverter.encode(dateEnd)
        ]);
  }

  @override
  Future<List<TodoModel>> getTodosByFilters(
    DateTime dateStart,
    DateTime dateEnd,
    bool isCompleted,
  ) async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo WHERE startDateTime >= ?1 AND startDateTime < ?2 AND isCompleted = ?3 ORDER BY startDateTime ASC',
        mapper: (Map<String, Object?> row) => TodoModel(
            id: row['id'] as String,
            title: row['title'] as String,
            isCompleted: (row['isCompleted'] as int) != 0,
            startDateTime:
                _dateTimeConverter.decode(row['startDateTime'] as int),
            dueDateTime:
                _nullableDateTimeConverter.decode(row['dueDateTime'] as int?)),
        arguments: [
          _dateTimeConverter.encode(dateStart),
          _dateTimeConverter.encode(dateEnd),
          isCompleted ? 1 : 0
        ]);
  }

  @override
  Future<List<TodoModel>> getOverdueIncompleteTodos(DateTime today) async {
    return _queryAdapter.queryList(
        'SELECT * FROM todo WHERE isCompleted = 0 AND COALESCE(dueDateTime, startDateTime) < ?1 ORDER BY startDateTime ASC',
        mapper: (Map<String, Object?> row) => TodoModel(id: row['id'] as String, title: row['title'] as String, isCompleted: (row['isCompleted'] as int) != 0, startDateTime: _dateTimeConverter.decode(row['startDateTime'] as int), dueDateTime: _nullableDateTimeConverter.decode(row['dueDateTime'] as int?)),
        arguments: [_dateTimeConverter.encode(today)]);
  }

  @override
  Future<void> createTodo(TodoModel todo) async {
    await _todoModelInsertionAdapter.insert(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateTodo(TodoModel todo) async {
    await _todoModelUpdateAdapter.update(todo, OnConflictStrategy.abort);
  }

  @override
  Future<void> deleteTodo(TodoModel todo) async {
    await _todoModelDeletionAdapter.delete(todo);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
final _nullableDateTimeConverter = NullableDateTimeConverter();
