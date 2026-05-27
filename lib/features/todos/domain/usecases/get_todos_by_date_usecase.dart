import 'package:minimal_todo_journal/core/usecase/usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class GetTodosByDateUsecase implements UseCase<List<TodoEntity>, DateTime> {
  final TodoRepository _todoRepository;

  GetTodosByDateUsecase(this._todoRepository);

  @override
  Future<List<TodoEntity>> call({required DateTime params}) {
    final start = DateTime(params.year, params.month, params.day);
    final end = start.add(Duration(days: 1));

    return _todoRepository.getTodosForDate(start, end);
  }
}
