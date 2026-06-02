import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/core/usecase/usecase.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/domain/repositories/todo_repository.dart';

class GetOverdueIncompletedTodosUsecase
    implements UseCase<List<TodoEntity>, NoParams> {
  final TodoRepository _todoRepository;

  GetOverdueIncompletedTodosUsecase(this._todoRepository);

  @override
  Future<List<TodoEntity>> call({required NoParams params}) {
    final DateTime now = DateTime.now();
    final DateTime today = DateUtils.dateOnly(now);

    return _todoRepository.getOverdueIncompleteTodos(today);
  }
}
