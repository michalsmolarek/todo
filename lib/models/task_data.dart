import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/task.dart';

class TaskData extends ChangeNotifier {
  List _tasks = <Task>[];
  List get taskList => _tasks;

  getTasks() async {
    final box = await Hive.box("tasks");
    _tasks = box.values.toList();
    // print("gettasks");
    notifyListeners();
  }

  int get taskCount {
    return _tasks.length;
  }

  Future<void> addTask(Task task) async {
    // _tasks.add(task);
    var box = await Hive.box('tasks');
    box.put(task.id!, task);
    print("dodano");
    // notifyListeners();
  }

  void toggleDone(Task task) {
    task.toggleDone();
    update(task);
    notifyListeners();
  }

  void update(Task task) async {
    var box = await Hive.box('tasks');
    box.put(task.id, task);
    notifyListeners();
  }

  void deleteTask(int index) async {
    print("delete");
    // _tasks.remove(task);
    var box = await Hive.box('tasks');
    box.deleteAt(index);

    notifyListeners();
  }

  void clear() async {
    var box = await Hive.box('tasks');
    box.deleteFromDisk();
  }
}
