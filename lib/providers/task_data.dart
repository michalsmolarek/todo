import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List _tasks = <Task>[];
  List get taskList => _tasks;

  getTasks() async {
    // ignore: await_only_futures
    final box = await Hive.box("tasks");
    _tasks = box.values.toList();
    // taskList.sort((a, b) => a.id.compareTo(b.id));
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> addTask(Task task) async {
    var box = Hive.box('tasks');
    box.put(task.id!, task);

    getTasks();
  }

  void toggleDone(Task task) {
    task.toggleDone();
    update(task);
  }

  void update(Task task) {
    var box = Hive.box('tasks');
    box.put(task.id, task);
    getTasks();
  }

  void deleteTask(Task task) {
    // _tasks.remove(task);
    var box = Hive.box('tasks');
    box.delete(task.id);
    getTasks();
  }

  deleteInCategory(String category) {
    var box = Hive.box('tasks');
    for (var task in taskList) {
      if (task.category == category) {
        box.delete(task.id);
      }
    }
    getTasks();
  }

  reorder(Task oldTask, Task newTask) {
    var box = Hive.box('tasks');

    box.put(
        oldTask.id,
        Task(
            id: oldTask.id,
            name: newTask.name,
            category: newTask.category,
            isDone: newTask.isDone));

    box.put(
        newTask.id,
        Task(
            id: newTask.id,
            name: oldTask.name,
            category: oldTask.category,
            isDone: oldTask.isDone));
    getTasks();
  }

  void clear() async {
    var box = Hive.box('tasks');
    await box.deleteFromDisk();
    await Hive.openBox("tasks");
    await getTasks();
  }
}
