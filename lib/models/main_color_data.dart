import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoey/models/main_color.dart';

class MainColorData extends ChangeNotifier {
  Color color = Colors.white;

  // void delete() async {
  //   final box = await Hive.openBox<MainColor>('color');
  //   box.deleteFromDisk();
  //   notifyListeners();
  // }

  // void getColor() async {
  //   final box = await Hive.openBox<MainColor>('color');

  //   color = box.get("color") as Color;

  //   notifyListeners();
  // }

  // void setColor(Color color) async {
  //   final box = await Hive.openBox<MainColor>('color');
  //   // box.put("color", color);
  //   notifyListeners();
  // }
}
