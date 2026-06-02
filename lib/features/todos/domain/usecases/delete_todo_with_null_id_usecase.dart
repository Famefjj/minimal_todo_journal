import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class DeleteTodoWithNullIdUsecase {
  final TodoRepository _todoRepository;

  DeleteTodoWithNullIdUsecase(this._todoRepository);

  Future<void> call() {
    return _todoRepository.deleteTodosWithNullId();
  }
}
