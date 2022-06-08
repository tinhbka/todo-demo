
import 'dart:io';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_flutter/data/constants.dart';
import 'package:todo_flutter/data/datasources/local_data_source.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';

class LocalDataService extends LocalDataSource {

  bool get isTesting => Platform.environment.containsKey('FLUTTER_TEST');
  List<TodoItem> items = [];

  @override
  Future<List<TodoItem>> getTodos() async {
    if (isTesting) {
      return items;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final todosString = prefs.getString(Constants.todoList);
    if (todosString == null || todosString.isEmpty) {
      return [];
    }
    return TodoItem.decode(todosString);
  }

  @override
  Future<void> saveTodos(List<TodoItem> todos) async {
    if (isTesting) {
      items = todos;
      return;
    }
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String encodedData = TodoItem.encode(todos);
    await prefs.setString(Constants.todoList, encodedData);
  }
  
}