import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoey/material_app.dart';
import 'package:todoey/models/main_color.dart';
import 'package:todoey/models/main_color_data.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  Hive.init(appDocDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(MainColorAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => TaskData(),
        ),
        ChangeNotifierProvider(
          create: (_) => MainColorData(),
        )
      ],
      child: Home(),
    );
  }
}
