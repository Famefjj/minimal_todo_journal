import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String id;
  final String title;
  final bool isCompleted;
  final DateTime startDateTime;
  final DateTime? dueDateTime;

  const TodoEntity({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.startDateTime,
    this.dueDateTime,
  });

  TodoEntity copyWith({
    String? id,
    String? title,
    bool? isCompleted,
    DateTime? startDateTime,
    DateTime? dueDateTime,
  }) {
    return TodoEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      startDateTime: startDateTime ?? this.startDateTime,
      dueDateTime: dueDateTime ?? this.dueDateTime,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    isCompleted,
    startDateTime,
    dueDateTime,
  ];
}
