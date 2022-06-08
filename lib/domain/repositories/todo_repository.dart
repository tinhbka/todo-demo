
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';

abstract class TodoRepository {
  /// Add new todo
  Future<void> addTodo(TodoItem todo);

  /// Fetch todo list by type
  Future<List<TodoItem>> fetchTodos(TodoPageType pageType);

  /// Update todo complete status
  Future<void> markTodoComplete(int id, bool completed);

  /// Delete todo by id
  Future<void> deleteTodo(int id);
}