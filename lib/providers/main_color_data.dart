import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todoey/models/main_color.dart';

class MainColorData extends ChangeNotifier {
  MainColor color = MainColor(0xff03a9f4);

  MainColor get cogetColor => color;

  void getColor() async {
    // ignore: await_only_futures
    final box = await Hive.box('color');

    color = box.get("color");

    notifyListeners();
  }

  void setColor(int color) {
    print(color);
    final box = Hive.box('color');

    box.put("color", MainColor(color));
    getColor();
    // getColor();
  }
}
