
import 'package:todo_flutter/data/datasources/local_data_source.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:collection/collection.dart';

class TodoRepositoryImpl extends TodoRepository {

  final LocalDataSource localDataSource;

  TodoRepositoryImpl(this.localDataSource);

  @override
  Future<void> addTodo(TodoItem todo) async {
    final todoList = await localDataSource.getTodos();
    todoList.add(todo);
    await localDataSource.saveTodos(todoList);
  }

  @override
  Future<void> deleteTodo(int id) async {
    final todoList = await localDataSource.getTodos();
    todoList.removeWhere((element) => element.id == id);
    await localDataSource.saveTodos(todoList);
  }

  @override
  Future<List<TodoItem>> fetchTodos(TodoPageType pageType) async {
    final todoList = await localDataSource.getTodos();
    todoList.sort((a, b) => a.id < b.id ? 1 : 0);

    switch (pageType) {
      case TodoPageType.all:
        return todoList;
      case TodoPageType.complete:
        return todoList.where((element) => element.completed).toList();
      case TodoPageType.incomplete:
        return todoList.where((element) => !element.completed).toList();
    }
  }

  @override
  Future<void> markTodoComplete(int id, bool completed) async {
    final todoList = await localDataSource.getTodos();
    final todo = todoList.firstWhereOrNull((element) => element.id == id);
    if (todo == null) return;
    todo.completed = completed;
    await localDataSource.saveTodos(todoList);
  }

}