import 'package:equatable/equatable.dart';

class TodoEntity extends Equatable {
  final String? id;
  final String title;
  final bool isCompleted;
  final DateTime startDateTime;
  final DateTime? dueDateTime;

  const TodoEntity({
    this.id,
    required this.title,
    this.isCompleted = false,
    required this.startDateTime,
    this.dueDateTime,
  });

  @override
  List<Object?> get props => [
    id,
    title,
    isCompleted,
    startDateTime,
    dueDateTime,
  ];
}
