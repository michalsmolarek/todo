import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoey/material_app.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/main_color.dart';
import 'package:todoey/models/selected_category.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/main_color_data.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(MainColorAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(SelectedCategoryAdapter());
  await Hive.openBox("tasks");
  await Hive.openBox("color");
  await Hive.openBox("categories");
  await Hive.openBox("selectedCategory");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MainColorData(),
        ),
        ChangeNotifierProvider(
          create: (_) => CategoryData(),
        ),
        ChangeNotifierProvider(
          create: (_) => SelectedCtegoryData(),
        ),
      ],
      child: const Home(),
    );
  }
}
