part of 'task_cubit.dart';

@immutable
sealed class TaskState extends Equatable {
  final List<TasksModel> tasksList;

  const TaskState({this.tasksList = const []});

  @override
  List<Object> get props => [tasksList];
}

final class TaskInitial extends TaskState {
  const TaskInitial() : super(tasksList: const []);
}

final class UpdateTask extends TaskState {
  const UpdateTask(List<TasksModel> list) : super(tasksList: list);
}
