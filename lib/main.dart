import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:todoey/material_app.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/is_done_checker.dart';
import 'package:todoey/models/main_color.dart';
import 'package:todoey/models/my_notification.dart';
import 'package:todoey/models/selected_category.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/is_done_data.dart';
import 'package:todoey/providers/main_color_data.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/notification_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Directory appDocDirectory = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(appDocDirectory.path);
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(MainColorAdapter());
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(SelectedCategoryAdapter());
  Hive.registerAdapter(IsDoneCheckerAdapter());
  Hive.registerAdapter(MyNotificationAdapter());
  await Hive.openBox("tasks");
  await Hive.openBox("color");
  await Hive.openBox("categories");
  await Hive.openBox("selectedCategory");
  await Hive.openBox("isDone");
  await Hive.openBox("notifications");

  AwesomeNotifications().initialize(

      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            icon: null,
            channelGroupKey: 'tudu_group',
            channelKey: 'tudu',
            channelName: 'Powiadomienia Tu-du',
            channelDescription: 'Tu-du kanał notifukacji',
            defaultColor: const Color(0xFF9D50DD),
            ledColor: Colors.white),
      ]);

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
          create: (_) => SelectedCategoryData(),
        ),
        ChangeNotifierProvider(
          create: (_) => IsDoneCheckerData(),
        ),
        ChangeNotifierProvider(
          create: (_) => NotificationData(),
        ),
      ],
      child: const Home(),
    );
  }
}
