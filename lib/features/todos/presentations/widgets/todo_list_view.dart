import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';
import 'package:minimal_todo_journal/features/todos/presentations/widgets/todo_tile.dart';

class TodoListView extends StatelessWidget {
  const TodoListView({
    super.key,
    required this.todos,
    required this.onChecked,
    required this.onDeleted,
    required this.onEdited,
  });

  final List<TodoEntity> todos;
  final ValueChanged<int> onChecked;
  final ValueChanged<int> onDeleted;
  final ValueChanged<int> onEdited;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) => const SizedBox(height: 0),
      itemBuilder: (context, index) => Slidable(
        key: ValueKey(todos[index].id),
        endActionPane: ActionPane(
          motion: DrawerMotion(),
          extentRatio: 0.3,
          children: [
            CustomSlidableAction(
              onPressed: (_) => onEdited(index),
              backgroundColor: colorScheme.primary,
              foregroundColor: colorScheme.onPrimary,
              child: Icon(CupertinoIcons.pencil, size: 24),
            ),
            CustomSlidableAction(
              onPressed: (_) => onDeleted(index),
              backgroundColor: colorScheme.error,
              foregroundColor: colorScheme.onError,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
              child: Icon(CupertinoIcons.delete_solid, size: 24),
            ),
          ],
        ),
        child: TodoTile(
          title: todos[index].title,
          isCompleted: todos[index].isCompleted,
          onChecked: () => onChecked(index),
        ),
      ),
    );
  }
}
