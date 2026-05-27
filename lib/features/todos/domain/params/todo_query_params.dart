class TodoQueryParams {
  final DateTime? dateStart;
  final DateTime? dateEnd;
  final bool? isCompleted;

  const TodoQueryParams({this.dateStart, this.dateEnd, this.isCompleted});
}
