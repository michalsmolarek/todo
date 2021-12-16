import 'package:hive/hive.dart';
part 'my_notification.g.dart';

@HiveType(typeId: 88)
class MyNotification {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final DateTime? dateStart;
  @HiveField(2)
  final DateTime? dateEnd;
  @HiveField(3)
  final String? taskId;

  MyNotification(this.id, this.dateStart, this.dateEnd, this.taskId);
}
