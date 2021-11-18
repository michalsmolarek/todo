import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List _tasks = <Task>[];
  List get taskList => _tasks;

  getTasks() async {
    final box = Hive.box("tasks");
    _tasks = box.values.toList();

    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> addTask(Task task) async {
    // _tasks.add(task);
    var box = Hive.box('tasks');
    box.put(task.id!, task);

    getTasks();
    notifyListeners();
  }

  void toggleDone(Task task) {
    task.toggleDone();
    update(task);
  }

  void update(Task task) async {
    var box = Hive.box('tasks');
    box.put(task.id, task);
    getTasks();
  }

  void deleteTask(int index) async {
    // _tasks.remove(task);
    var box = Hive.box('tasks');
    box.deleteAt(index);
    getTasks();
  }

  void clear() async {
    var box = Hive.box('tasks');
    box.deleteFromDisk();
  }
}
