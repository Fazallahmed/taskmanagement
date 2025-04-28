import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../widgets/task_form.dart';

class AddTaskScreen extends StatelessWidget {
  const AddTaskScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Task'),
      ),
      body: TaskForm(
        onSubmit: (title, description, dueDate) {
          if (title.isNotEmpty) {
            Provider.of<TaskProvider>(context, listen: false)
                .addTask(title, description, dueDate);
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}