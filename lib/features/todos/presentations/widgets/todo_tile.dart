import 'package:flutter/material.dart';
import 'package:minimal_todo_journal/features/todos/presentations/widgets/circle_check_box.dart';

class TodoTile extends StatelessWidget {
  const TodoTile({
    super.key,
    required this.title,
    required this.isCompleted,
    required this.onChecked,
  });

  final String title;
  final bool isCompleted;
  final VoidCallback onChecked;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      height: 60,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          CircleCheckBox(onTap: () => onChecked(), isChecked: isCompleted),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: isCompleted
                  ? textTheme.titleLarge!.copyWith(
                      color: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.4,
                      ),
                      decoration: TextDecoration.lineThrough,
                      decorationColor: colorScheme.onSurfaceVariant.withValues(
                        alpha: 0.4,
                      ),
                    )
                  : textTheme.titleLarge,
            ),
          ),
        ],
      ),
    );
  }
}
