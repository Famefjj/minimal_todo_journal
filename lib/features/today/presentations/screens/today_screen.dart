import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/presentations/providers/todos_provider.dart';
import 'package:minimal_todo_journal/features/todos/presentations/widgets/add_todo_button.dart';
import 'package:minimal_todo_journal/features/todos/presentations/widgets/todo_list_view.dart';
import 'package:uuid/uuid.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final todosAsync = ref.watch(getTodosByDateProvider(today));

    return SafeArea(
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Today', style: Theme.of(context).textTheme.headlineLarge),
                SizedBox(height: 34),
                Expanded(
                  child: todosAsync.when(
                    data: (todos) => TodoListView(
                      todos: todos,
                      onChecked: (index) async {
                        final todo = todos[index];
                        await ref
                            .read(updateTodoProvider)
                            .call(
                              params: todo.copyWith(
                                isCompleted: !todo.isCompleted,
                              ),
                            );
                        TodosProviderUtils.invalidateAllGetTodosProvider(ref);
                      },
                      onEdited: (index) => {},
                      onDeleted: (index) async {
                        await ref
                            .read(deleteTodoProvider)
                            .call(params: todos[index]);
                        TodosProviderUtils.invalidateAllGetTodosProvider(ref);
                      },
                    ),
                    loading: () => Center(child: CircularProgressIndicator()),
                    error: (error, stackTrace) =>
                        Center(child: Text('Could not load todos')),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 24,
            bottom: 24,
            child: AddTodoButton(
              onTap: () async {
                final todo = TodoEntity(
                  id: Uuid().v4(),
                  title: 'Take a Shower',
                  startDateTime: DateTime.now(),
                );
                await ref.read(addTodoProvider).call(params: todo);
                TodosProviderUtils.invalidateAllGetTodosProvider(ref);
              },
            ),
          ),
        ],
      ),
    );
  }
}
