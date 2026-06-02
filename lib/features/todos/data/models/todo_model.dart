import 'package:floor/floor.dart';
import 'package:minimal_todo_journal/features/todos/domain/entities/todo_entity.dart';

@Entity(tableName: 'todo', primaryKeys: ['id'])
class TodoModel extends TodoEntity {
  const TodoModel({
    required super.id,
    required super.title,
    super.isCompleted,
    required super.startDateTime,
    super.dueDateTime,
  });

  factory TodoModel.fromJson(Map<String, dynamic> map) {
    final String? startDateTimeValue = map["start_datetime"] as String?;

    if (startDateTimeValue == null) {
      throw FormatException("Todo start_datetime is missing or invalid");
    }

    return TodoModel(
      id: map["id"].toString(),
      title: map["title"] ?? "",
      isCompleted: map["is_completed"] as bool? ?? false,
      startDateTime: DateTime.parse(startDateTimeValue),
      dueDateTime: map["due_datetime"] == null
          ? null
          : DateTime.tryParse(map["due_datetime"] as String),
    );
  }

  factory TodoModel.fromEntity(TodoEntity entity) {
    return TodoModel(
      id: entity.id,
      title: entity.title,
      startDateTime: entity.startDateTime,
      dueDateTime: entity.dueDateTime,
      isCompleted: entity.isCompleted,
    );
  }
}
