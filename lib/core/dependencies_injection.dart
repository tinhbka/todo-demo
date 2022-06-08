import 'package:get_it/get_it.dart';
import 'package:todo_flutter/data/datasources/local_data_services.dart';
import 'package:todo_flutter/data/datasources/local_data_source.dart';
import 'package:todo_flutter/data/repositories/todo_repo_impl.dart';
import 'package:todo_flutter/domain/repositories/todo_repository.dart';
import 'package:todo_flutter/domain/usecases/add_todo_uc.dart';
import 'package:todo_flutter/domain/usecases/get_todo_list_uc.dart';
import 'package:todo_flutter/domain/usecases/update_todo_uc.dart';
import 'package:todo_flutter/presentation/viewmodels/todo_viewmodel.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  getIt.registerSingleton<LocalDataSource>(LocalDataService());

  getIt.registerSingleton<TodoRepository>(
      TodoRepositoryImpl(getIt.get<LocalDataSource>()));

  getIt.registerSingleton<AddTodoUseCase>(
      AddTodoUseCase(getIt.get<TodoRepository>()));
  getIt.registerSingleton<GetTodoListUseCase>(
      GetTodoListUseCase(getIt.get<TodoRepository>()));
  getIt.registerSingleton<UpdateTodoUseCase>(
      UpdateTodoUseCase(getIt.get<TodoRepository>()));

  getIt.registerSingleton<TodoViewModel>(TodoViewModel(
      getIt.get<AddTodoUseCase>(),
      getIt.get<GetTodoListUseCase>(),
      getIt.get<UpdateTodoUseCase>()));
}
