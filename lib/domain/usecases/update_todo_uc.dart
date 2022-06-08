
import 'package:todo_flutter/domain/repositories/todo_repository.dart';

class UpdateTodoUseCase {
  final TodoRepository todoRepository;

  UpdateTodoUseCase(this.todoRepository);

  Future<void> execute(int id, bool completed) {
    return todoRepository.markTodoComplete(id, completed);
  }
}