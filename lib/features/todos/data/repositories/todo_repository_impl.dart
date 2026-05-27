import 'package:minimal_todo_journal/features/todos/data/data_sources/local/app_database.dart';
import 'package:minimal_todo_journal/features/todos/data/models/todo_model.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final AppDatabase _appDatabase;

  TodoRepositoryImpl(this._appDatabase);

  @override
  Future<void> deleteTodo(TodoEntity todo) {
    return _appDatabase.todoDao.deleteTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<void> insertTodo(TodoEntity todo) {
    return _appDatabase.todoDao.insertTodo(TodoModel.fromEntity(todo));
  }

  @override
  Future<List<TodoModel>> getTodos() {
    return _appDatabase.todoDao.getTodos();
  }

  @override
  Future<List<TodoModel>> getTodosForDate(
    DateTime dateStart,
    DateTime dateEnd,
  ) {
    return _appDatabase.todoDao.getTodosForDate(dateStart, dateEnd);
  }

  @override
  Future<List<TodoModel>> getTodosByFilters(
    DateTime dateStart,
    DateTime dateEnd,
    bool isCompleted,
  ) {
    return _appDatabase.todoDao.getTodosByFilters(
      dateStart,
      dateEnd,
      isCompleted,
    );
  }

  @override
  Future<List<TodoModel>> getOverdueIncompleteTodos(DateTime today) {
    return _appDatabase.todoDao.getOverdueIncompleteTodos(today);
  }
}
