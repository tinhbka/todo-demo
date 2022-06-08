
import 'dart:convert';

class TodoItem {
  final int id;
  final String title;
  bool completed = false;

  TodoItem({
    required this.id,
    required this.title, this.completed = false});

  factory TodoItem.fromJson(Map<String, dynamic> jsonData) {
    return TodoItem(
      id: jsonData['id'],
      title: jsonData['title'],
      completed: jsonData['completed']
    );
  }

  static Map<String, dynamic> toMap(TodoItem item) => {
    'id': item.id,
    'title': item.title,
    'completed': item.completed,
  };

  static String encode(List<TodoItem> todos) => json.encode(
    todos
        .map<Map<String, dynamic>>((todo) => TodoItem.toMap(todo))
        .toList(),
  );

  static List<TodoItem> decode(String todos) =>
      (json.decode(todos) as List<dynamic>)
          .map<TodoItem>((item) => TodoItem.fromJson(item))
          .toList();
}