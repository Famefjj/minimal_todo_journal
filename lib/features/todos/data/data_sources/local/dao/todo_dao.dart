import 'package:floor/floor.dart';
import 'package:minimal_todo_journal/features/todos/data/models/todo_model.dart';

@dao
abstract class TodoDao {
  @Insert()
  Future<void> insertTodo(TodoModel todo);

  @delete
  Future<void> deleteTodo(TodoModel todo);

  @Query('SELECT * FROM todo ORDER BY startDateTime ASC')
  Future<List<TodoModel>> getTodos();

  @Query(
    'SELECT * FROM todo '
    'WHERE startDateTime >= :dateStart '
    'AND startDateTime < :dateEnd '
    'ORDER BY startDateTime ASC',
  )
  Future<List<TodoModel>> getTodosForDate(DateTime dateStart, DateTime dateEnd);

  @Query(
    'SELECT * FROM todo '
    'WHERE startDateTime >= :dateStart '
    'AND startDateTime < :dateEnd '
    'AND isCompleted = :isCompleted '
    'ORDER BY startDateTime ASC',
  )
  Future<List<TodoModel>> getTodosByFilters(
    DateTime dateStart,
    DateTime dateEnd,
    bool isCompleted,
  );

  @Query(
    'SELECT * FROM todo '
    'WHERE isCompleted = 0 '
    'AND COALESCE(dueDateTime, startDateTime) < :today '
    'ORDER BY startDateTime ASC',
  )
  Future<List<TodoModel>> getOverdueIncompleteTodos(DateTime today);
}
