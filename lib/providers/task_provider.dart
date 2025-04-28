import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import '../models/task_model.dart';

class TaskProvider with ChangeNotifier {
  // In-memory storage of tasks
  List<Task> _tasks = [];

  // Getter to provide an unmodifiable view of the tasks
  List<Task> get tasks => List.unmodifiable(_tasks);

  // Getter for incomplete tasks
  List<Task> get incompleteTasks => _tasks.where((task) => !task.isCompleted).toList();

  // Getter for completed tasks
  List<Task> get completedTasks => _tasks.where((task) => task.isCompleted).toList();

  // Add a new task
  void addTask(String title, String description, DateTime dueDate) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      dueDate: dueDate,
    );

    _tasks.add(newTask);
    notifyListeners();
  }

  // Update an existing task
  void updateTask(Task updatedTask) {
    final index = _tasks.indexWhere((task) => task.id == updatedTask.id);
    if (index != -1) {
      _tasks[index] = updatedTask;
      notifyListeners();
    }
  }

  // Toggle task completion status
  void toggleTaskCompletion(String taskId) {
    final index = _tasks.indexWhere((task) => task.id == taskId);
    if (index != -1) {
      _tasks[index] = _tasks[index].copyWith(
        isCompleted: !_tasks[index].isCompleted,
      );
      notifyListeners();
    }
  }

  // Delete a task
  void deleteTask(String taskId) {
    _tasks.removeWhere((task) => task.id == taskId);
    notifyListeners();
  }

  // Get a specific task by ID
  Task? getTaskById(String taskId) {
    try {
      return _tasks.firstWhere((task) => task.id == taskId);
    } catch (e) {
      return null;
    }
  }
}