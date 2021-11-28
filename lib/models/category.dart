import 'package:hive/hive.dart';
part 'category.g.dart';

@HiveType(typeId: 23)
class Category {
  @HiveField(0)
  final String? id;

  @HiveField(1)
  final String? name;

  Category({this.id, this.name});
}
