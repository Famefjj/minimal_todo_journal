import 'package:minimal_todo_journal/core/usecase/usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class GetTodosUsecase implements UseCase<List<TodoEntity>, NoParams> {
  final TodoRepository _todoRepository;

  GetTodosUsecase(this._todoRepository);

  @override
  Future<List<TodoEntity>> call({required NoParams params}) {
    return _todoRepository.getTodos();
  }
}
