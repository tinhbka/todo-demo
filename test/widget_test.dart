// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/core/dependencies_injection.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';

import 'package:todo_flutter/main.dart';
import 'package:todo_flutter/presentation/pages/todo_page.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';

void main() {
  testWidgets('should display todo in the list', (WidgetTester tester) async {

    final titleFinder = find.text('New Item');
    final typeFinder = find.byType(Row);

    final viewModel = TodoViewModel.mock();

    await tester.pumpWidget( MaterialApp(
      home: Scaffold(
        body: TodoPage(
          pageType: TodoPageType.all,
          viewModel: viewModel,
        ),
      ),
    ));

    viewModel.addTodo(TodoItem(id: 2, title: 'New Item'));

    await tester.pump();

    expect(titleFinder, findsNWidgets(1));
    expect(typeFinder, findsNWidgets(1));
  });
}
