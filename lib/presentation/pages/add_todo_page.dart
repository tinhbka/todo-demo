import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/domain/entities/todo_entity.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';

class AddTodoPage extends StatefulWidget {

  final TodoViewModel viewModel;

  const AddTodoPage({Key? key, required this.viewModel}) : super(key: key);

  @override
  State<AddTodoPage> createState() => _AddTodoPageState();
}

class _AddTodoPageState extends State<AddTodoPage> {

  final TextEditingController _controller = TextEditingController();

  void _doneTapped() {
    if (_controller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("Please enter todo title"),
      ));
      return;
    }

    final todo = TodoItem(id: DateTime.now().millisecondsSinceEpoch, title: _controller.text);
    widget.viewModel.addTodo(todo);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Todo'),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.close),
        ),
        actions: [
          TextButton(
            key: const ValueKey('button.save'),
            child: const Text(
              'Save',
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
            onPressed: () => _doneTapped(),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: TextFormField(
            key: const ValueKey('input.title'),
            controller: _controller,
            decoration: const InputDecoration(hintText: 'Enter todo title'),
            textInputAction: TextInputAction.newline,
            maxLines: 5,
            minLines: 1,
            keyboardType: TextInputType.multiline,
          ),
        ),
      ),
    );
  }
}
