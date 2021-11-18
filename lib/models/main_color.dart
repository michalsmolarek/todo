import 'package:hive/hive.dart';
part 'main_color.g.dart';

@HiveType(typeId: 21)
class MainColor {
  @HiveField(0)
  final int color;

  MainColor(this.color);
}
