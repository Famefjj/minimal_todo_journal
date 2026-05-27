import 'package:floor/floor.dart';
import 'package:minimal_todo_journal/features/todos/data/data_sources/local/converters/date_time_converter.dart';
import 'package:minimal_todo_journal/features/todos/data/data_sources/local/dao/todo_dao.dart';
import 'package:minimal_todo_journal/features/todos/data/models/todo_model.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart' as sqflite;
part 'app_database.g.dart';

@Database(version: 1, entities: [TodoModel])
@TypeConverters([DateTimeConverter, NullableDateTimeConverter])
abstract class AppDatabase extends FloorDatabase {
  TodoDao get todoDao;
}
