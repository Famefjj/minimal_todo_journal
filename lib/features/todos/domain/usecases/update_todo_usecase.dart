import 'package:minimal_todo_journal/core/usecase/usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class UpdateTodoUsecase implements UseCase<void, TodoEntity> {
  final TodoRepository _todoRepository;

  UpdateTodoUsecase(this._todoRepository);

  @override
  Future<void> call({required TodoEntity params}) {
    return _todoRepository.updateTodo(params);
  }
}
