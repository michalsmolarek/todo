import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoey/models/main_color.dart';

class MainColorData extends ChangeNotifier {
  MainColor color = MainColor(0xff03a9f4);

  MainColor get cogetColor => color;

  void delete() async {
    final box = await Hive.box('color');
    box.deleteFromDisk();
    notifyListeners();
    // Colors.lightBlue
  }

  void getColor() async {
    print("getcolor");
    final box = await Hive.box('color');

    color = box.get("color");

    notifyListeners();
  }

  void setColor(int color) async {
    final box = await Hive.box('color');

    box.put("color", MainColor(color));
    notifyListeners();
  }
}
