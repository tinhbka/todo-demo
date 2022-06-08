
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class GetTodoListUseCase {
  final TodoRepository todoRepository;

  GetTodoListUseCase(this.todoRepository);

  Future<List<TodoItem>> execute(TodoPageType pageType) {
    return todoRepository.fetchTodos(pageType);
  }
}