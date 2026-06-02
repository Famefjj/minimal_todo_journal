import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_todo_journal/core/usecase/usecase.dart';
import 'package:minimal_todo_journal/features/todos/data/data_sources/local/app_database.dart';
import 'package:minimal_todo_journal/features/todos/data/repositories/todo_repository_impl.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/delete_todo_usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/delete_todo_with_null_id_usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/get_todos_by_date_usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/get_todos_usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/add_todo_usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/usecases/update_todo_usecase.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  throw UnimplementedError(
    'appDatabaseProvider must be overriden in main.dart',
  );
});

final todoRepositoryProvider = Provider<TodoRepository>((ref) {
  final localAppDatabase = ref.watch(appDatabaseProvider);

  return TodoRepositoryImpl(localAppDatabase);
});

final addTodoProvider = Provider<AddTodoUsecase>((ref) {
  final repository = ref.read(todoRepositoryProvider);

  return AddTodoUsecase(repository);
});

final updateTodoProvider = Provider<UpdateTodoUsecase>((ref) {
  final repository = ref.read(todoRepositoryProvider);

  return UpdateTodoUsecase(repository);
});

final deleteTodoProvider = Provider<DeleteTodoUsecase>((ref) {
  final repository = ref.read(todoRepositoryProvider);

  return DeleteTodoUsecase(repository);
});

final getTodosByDateProvider =
    FutureProvider.family<List<TodoEntity>, DateTime>((ref, dateTime) {
      final repository = ref.read(todoRepositoryProvider);
      return GetTodosByDateUsecase(repository).call(params: dateTime);
    });

final getTodosProvider = FutureProvider<List<TodoEntity>>((ref) {
  final repository = ref.read(todoRepositoryProvider);
  return GetTodosUsecase(repository).call(params: NoParams());
});

final deleteTodoWithNullIdProvider = Provider((ref) {
  final repository = ref.read(todoRepositoryProvider);

  return DeleteTodoWithNullIdUsecase(repository);
});

class TodosProviderUtils {
  TodosProviderUtils._();

  static void invalidateAllGetTodosProvider(WidgetRef ref) {
    ref.invalidate(getTodosProvider);
    ref.invalidate(getTodosByDateProvider);
  }
}
