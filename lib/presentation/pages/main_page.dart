import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_flutter/domain/enums/enums.dart';
import 'package:todo_flutter/presentation/pages/add_todo_page.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';

import 'todo_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  /// Active bottom bar item index
  int _selectedIndex = 0;

  /// Todo page list type
  static const List<TodoPageType> _pageTypes = [
    TodoPageType.all,
    TodoPageType.complete,
    TodoPageType.incomplete
  ];

  TodoViewModel get viewModel {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return TodoViewModel.mock();
    } else {
      return GetIt.instance.get<TodoViewModel>();
    }
  }

  /// Page list
  List<Widget> get _pageOptions =>
      _pageTypes.map((e) => TodoPage(pageType: e, viewModel: viewModel,)).toList();

  /// On tap bottom bar item
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  /// On add new todo, go to Add Todo page
  void _onAddItemTapped() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => AddTodoPage(viewModel: viewModel,), fullscreenDialog: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
      ),
      body: _pageOptions[_selectedIndex],
      floatingActionButton: FloatingActionButton(
        key: const ValueKey('button.add'),
        onPressed: () => _onAddItemTapped(),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomBarItems(),
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
      ),
    );
  }

  /// Get list bottom bar item
  List<BottomNavigationBarItem> _bottomBarItems() {
    return _pageTypes.map((e) {
      return BottomNavigationBarItem(icon: Icon(e.icon), label: e.stringValue);
    }).toList();
  }
}
