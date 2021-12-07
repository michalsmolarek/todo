import 'package:hive/hive.dart';
part 'is_done_checker.g.dart';

@HiveType(typeId: 27)
class IsDoneChecker {
  @HiveField(0)
  final bool isChecked;

  IsDoneChecker(this.isChecked);
}
