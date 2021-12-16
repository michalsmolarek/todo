import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/my_notification.dart';

class NotificationData extends ChangeNotifier {
  MyNotification getNotification(String taskId) {
    final box = Hive.box("notifications");
    return box.get(taskId,
        defaultValue:
            MyNotification(0, DateTime.now(), DateTime.now(), taskId));
  }

  void setNotification(MyNotification myNotification) {
    final box = Hive.box("notifications");
    box.put(myNotification.taskId, myNotification);
    notifyListeners();
  }

  void deleteNotification(String taskId) {
    final box = Hive.box("notifications");
    box.delete(taskId);
    notifyListeners();
  }

  void clear() async {
    final box = Hive.box("notifications");
    box.deleteFromDisk();
    notifyListeners();
    await Hive.openBox("notifications");
  }
}
