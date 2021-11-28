import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todoey/models/selected_category.dart';

class SelectedCategoryData extends ChangeNotifier {
  SelectedCategory selectedCategory = SelectedCategory("");
  SelectedCategory get getSelectedCategory => selectedCategory;

  void getSelected() async {
    // ignore: await_only_futures
    final box = await Hive.box('selectedCategory');
    selectedCategory = box.get("selectedCategory");
    notifyListeners();
  }

  void setSelectedCategory(String categoryName) {
    final box = Hive.box('selectedCategory');
    box.put("selectedCategory", SelectedCategory(categoryName));
    getSelected();
  }

  void clear() async {
    var box = Hive.box('selectedCategory');
    await box.deleteFromDisk();
    await Hive.openBox("selectedCategory");
    getSelected();
  }
}
