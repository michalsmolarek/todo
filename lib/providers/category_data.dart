import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/category.dart';

class CategoryData extends ChangeNotifier {
  List _categories = <Category>[];
  List get categoryList => _categories;

  getCategories() async {
    // ignore: await_only_futures
    final box = await Hive.box("categories");
    _categories = box.values.toList();
    notifyListeners();
  }

  int get categoriesCount {
    return _categories.length;
  }

  void addCategory(Category category) {
    final box = Hive.box("categories");
    box.put(category.id, category);
    getCategories();
  }

  void updateCategory(Category category) {
    final box = Hive.box("categories");
    box.put(category.id, category);
    getCategories();
  }

  void deleteTask(Category category) {
    // _tasks.remove(task);
    var box = Hive.box('categories');
    box.delete(category.id);
    getCategories();
  }

  void clear() async {
    var box = Hive.box('categories');
    await box.deleteFromDisk();
    await Hive.openBox("tasks");
    await getCategories();
  }
}
