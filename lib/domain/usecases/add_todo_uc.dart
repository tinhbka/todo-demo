
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class AddTodoUseCase {
  final TodoRepository todoRepository;

  AddTodoUseCase(this.todoRepository);

  Future<void> execute(TodoItem todo) {
    return todoRepository.addTodo(todo);
  }
}