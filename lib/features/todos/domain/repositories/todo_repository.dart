import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';

abstract class TodoRepository {
  Future<List<TodoEntity>> getTodos();
  Future<List<TodoEntity>> getTodosForDate(
    DateTime dateStart,
    DateTime dateEnd,
  );
  Future<List<TodoEntity>> getTodosByFilters(
    DateTime dateStart,
    DateTime dateEnd,
    bool isCompleted,
  );

  Future<List<TodoEntity>> getOverdueIncompleteTodos(DateTime today);

  Future<void> addTodo(TodoEntity todo);
  Future<void> updateTodo(TodoEntity todo);
  Future<void> deleteTodo(TodoEntity todo);

  Future<void> deleteTodosWithNullId();
}
