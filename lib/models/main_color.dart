import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
part 'main_color.g.dart';

@HiveType(typeId: 21)
class MainColor {
  @HiveField(0)
  final Color color;

  MainColor(this.color);
}
