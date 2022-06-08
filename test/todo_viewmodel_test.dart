
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';
import 'package:collection/collection.dart';

void main() {
  group('todo view model', () {

    test('should add new todo', () {
      TodoViewModel viewModel = TodoViewModel.mock();
      final id = DateTime.now().millisecondsSinceEpoch;
      final newTodo = TodoItem(id: id, title: 'Do homework');
      viewModel.addTodo(newTodo);

      viewModel.todoStream.take(1).listen(expectAsync1((event) {
        final data = event as List<TodoItem>;
        final addedTodo = data.firstWhereOrNull((element) => element.id == id);
        expect(addedTodo?.title, 'Do homework');
      }));
    });

    test('should mark todo complete', () {
      TodoViewModel viewModel = TodoViewModel.mock();
      final id = DateTime.now().millisecondsSinceEpoch;
      final newTodo = TodoItem(id: id, title: 'Call for team leader');
      viewModel.addTodo(newTodo);
      viewModel.updateTodo(id, true);

      /// Test mark done. skip first todo list when add new action fire.
      viewModel.todoStream.take(1).listen(expectAsync1((event) {
        final data = event as List<TodoItem>;
        final addedTodo = data.firstWhereOrNull((element) => element.id == id);
        expect(addedTodo?.completed, true);
      }));
    });
  });
}