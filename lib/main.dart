import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_to_do_app/cubit/task_cubit.dart';
import 'package:flutter_to_do_app/models/tasks_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TaskCubit(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDo App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const TaskHomePage(),
      ),
    );
  }
}

class TaskHomePage extends StatelessWidget {
  const TaskHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TaskCubit>();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '📝 My Tasks',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.deepPurple[400],
      ),
      body: BlocBuilder<TaskCubit, TaskState>(
        builder: (context, state) {
          if (state.tasksList.isEmpty) {
            return const Center(child: Text('No tasks yet!'));
          }

          return ListView.builder(
            itemCount: state.tasksList.length,
            itemBuilder: (context, index) {
              final task = state.tasksList[index];
              return ListTile(
                leading: Checkbox(
                  value: task.isCompleted,
                  onChanged: (value) {
                    cubit.toggleTask(task.id);
                  },
                ),
                title: Text(
                  task.title,
                  style: TextStyle(
                    decoration: task.isCompleted
                        ? TextDecoration.lineThrough
                        : null,
                    color: task.isCompleted ? Colors.grey : Colors.black,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.redAccent),
                  onPressed: () => cubit.removeTask(task.id),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (dialogContext) {
              final TextEditingController controller = TextEditingController();

              return AlertDialog(
                title: const Text('Add a new task'),
                content: TextField(
                  controller: controller,
                  decoration: const InputDecoration(
                    hintText: 'Enter task title...',
                    border: OutlineInputBorder(),
                  ),
                ),

                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(dialogContext),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      final title = controller.text.trim();
                      if (title.isNotEmpty) {
                        final newTask = TasksModel(
                          id: DateTime.now().millisecondsSinceEpoch,
                          title: title,
                          isCompleted: false,
                        );
                        cubit.addTask(newTask);
                        Navigator.pop(dialogContext);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              );
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
