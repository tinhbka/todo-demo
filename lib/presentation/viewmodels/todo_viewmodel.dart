
import 'dart:async';

import 'package:todo_flutter/data/datasources/local_data_services.dart';
import 'package:todo_flutter/data/repositories/todo_repo_impl.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';
import 'package:todo_flutter/domain/usecases/add_todo_uc.dart';
import 'package:todo_flutter/domain/usecases/get_todo_list_uc.dart';
import 'package:todo_flutter/domain/usecases/update_todo_uc.dart';

class TodoViewModel {
  final AddTodoUseCase addTodoUseCase;
  final GetTodoListUseCase getTodoListUseCase;
  final UpdateTodoUseCase updateTodoUseCase;

  TodoViewModel(this.addTodoUseCase, this.getTodoListUseCase, this.updateTodoUseCase) {
    getTodos();
  }

  final StreamController _streamController = StreamController<List<TodoItem>>.broadcast();
  Stream get todoStream => _streamController.stream;

  void getTodos() {
    getTodoListUseCase.execute(TodoPageType.all).then((value) {
      _streamController.sink.add(value);
    });
  }

  void addTodo(TodoItem todoItem) {
    addTodoUseCase.execute(todoItem).then((_) => getTodos());
  }

  void updateTodo(int id, bool completed) {
    updateTodoUseCase.execute(id, completed).then((_) => getTodos());
  }

  void dispose() {
    _streamController.close();
  }

  static TodoViewModel mock() {
    final localDataService = LocalDataService();
    final todoRepoImpl = TodoRepositoryImpl(localDataService);

    final addTodoUC = AddTodoUseCase(todoRepoImpl);
    final getTodoUC = GetTodoListUseCase(todoRepoImpl);
    final updateTodoUC = UpdateTodoUseCase(todoRepoImpl);

    return TodoViewModel(addTodoUC, getTodoUC, updateTodoUC);
  }

  static TodoViewModel mockWithItems() {
    final localDataService = LocalDataService();
    final todoRepoImpl = TodoRepositoryImpl(localDataService);

    final addTodoUC = AddTodoUseCase(todoRepoImpl);
    final getTodoUC = GetTodoListUseCase(todoRepoImpl);
    final updateTodoUC = UpdateTodoUseCase(todoRepoImpl);

    final viewModel = TodoViewModel(addTodoUC, getTodoUC, updateTodoUC);
    viewModel.addTodo(TodoItem(id: 1, title: 'Let me test widgets'));

    return viewModel;
  }
}
