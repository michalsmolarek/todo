import 'package:hive/hive.dart';
part 'selected_category.g.dart';

@HiveType(typeId: 26)
class SelectedCategory {
  @HiveField(0)
  final String? selectedId;

  SelectedCategory(this.selectedId);
}
