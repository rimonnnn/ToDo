import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_to_do_app/cubit/task_cubit.dart';
import 'package:flutter_to_do_app/models/tasks_model.dart';

void main() {
  group('TaskCubit', () {
    test('initial state is TaskInitial with empty list', () {
      final cubit = TaskCubit();
      expect(cubit.state, isA<TaskInitial>());
      expect(cubit.state.tasksList, isEmpty);
    });

    test('addTask adds a task', () {
      final cubit = TaskCubit();
      final task = const TasksModel(id: 1, title: 'Test', isCompleted: false);
      cubit.addTask(task);
      expect(cubit.state, isA<UpdateTask>());
      expect(cubit.state.tasksList, [task]);
    });

    test('removeTask removes task by id', () {
      final cubit = TaskCubit();
      final a = const TasksModel(id: 1, title: 'A', isCompleted: false);
      final b = const TasksModel(id: 2, title: 'B', isCompleted: true);
      cubit.addTask(a);
      cubit.addTask(b);

      cubit.removeTask(1);
      expect(cubit.state.tasksList, [b]);
    });
  });
}
