import 'package:equatable/equatable.dart';

 class TasksModel extends Equatable {
  const TasksModel({
    required this.id,
    required this.title,
    required this.isCompleted,
  });
  final int id;
  final String title;
  final bool isCompleted;
  TasksModel copyWith({int? id, String? title, bool? isCompleted}) {
    return TasksModel(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  List<Object?> get props => [id, title, isCompleted];
}
