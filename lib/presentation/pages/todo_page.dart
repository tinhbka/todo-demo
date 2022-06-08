import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/domain/enums/enums.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';

class TodoPage extends StatelessWidget {
  final TodoPageType pageType;
  final TodoViewModel viewModel;

  const TodoPage({Key? key, required this.pageType, required this.viewModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: viewModel.todoStream,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Text('Todo list is empty'),
            );
          }

          List<TodoItem> data = snapshot.data as List<TodoItem>;
          if (pageType == TodoPageType.complete) {
            data = data.where((element) => element.completed).toList();
          } else if (pageType == TodoPageType.incomplete) {
            data = data.where((element) => !element.completed).toList();
          }

          return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: data.length,
              itemBuilder: (context, index) {
                return _todoItemView(data[index]);
              });
        });
  }

  Widget _todoItemView(TodoItem todoItem) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                viewModel.updateTodo(todoItem.id, !todoItem.completed);
              },
              icon: todoItem.completed
                  ? const Icon(Icons.check_box)
                  : const Icon(Icons.check_box_outline_blank)),
          const SizedBox(
            width: 4,
          ),
          Expanded(
              child: Text(
            todoItem.title,
            style: TextStyle(
                decoration:
                    todoItem.completed ? TextDecoration.lineThrough : null),
          ))
        ],
      ),
    );
  }
}
