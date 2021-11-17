import 'package:hive/hive.dart';
part 'task.g.dart';

@HiveType(typeId: 20)
class Task {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  bool isDone;

  Task({this.name, this.isDone = false, this.id});

  void toggleDone() {
    isDone = !isDone;
  }
}
