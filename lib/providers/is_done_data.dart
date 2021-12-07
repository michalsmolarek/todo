import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/is_done_checker.dart';

class IsDoneCheckerData extends ChangeNotifier {
  IsDoneChecker isDoneChecker = IsDoneChecker(false);
  IsDoneChecker get getIsDone => isDoneChecker;

  void getIsDoneChecked() async {
    // ignore: await_only_futures
    final box = await Hive.box('isDone');
    isDoneChecker = box.get("isDone");
    notifyListeners();
  }

  void setIsDone(bool isDone) {
    final box = Hive.box('isDone');
    box.put("isDone", IsDoneChecker(isDone));
    getIsDoneChecked();
  }

  void clear() async {
    var box = Hive.box('isDone');
    await box.deleteFromDisk();
    await Hive.openBox("isDone");
    getIsDoneChecked();
  }
}
