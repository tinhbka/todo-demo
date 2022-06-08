
import 'package:todo_flutter/domain/entities/todo_entity.dart';

abstract class LocalDataSource {

  /// Save todo list to SharePreferences
  Future<void> saveTodos(List<TodoItem> todos);

  /// Get todo from SharePreferences
  Future<List<TodoItem>> getTodos();
}