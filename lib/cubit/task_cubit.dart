import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
// ignore: depend_on_referenced_packages
import 'package:meta/meta.dart';

import 'package:flutter_to_do_app/models/tasks_model.dart';

part 'task_state.dart';

class TaskCubit extends Cubit<TaskState> {
  TaskCubit() : super(const TaskInitial());

  void addTask(TasksModel model) {
    emit(UpdateTask([...state.tasksList, model]));
  }

  void removeTask(int id) {
    final List<TasksModel> newList = state.tasksList
        .where((task) => task.id != id)
        .toList();
    emit(UpdateTask(newList));
  }

  toggleTask(int id) {
    final List<TasksModel> newList = state.tasksList.map((task) {
      return task.id == id
          ? task.copyWith(isCompleted: !task.isCompleted)
          : task;
    }).toList();

    emit(UpdateTask(newList));
  }
}
