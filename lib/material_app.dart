import 'package:flutter/material.dart';
import 'package:todoey/screens/tasks_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlue,
        backgroundColor: Colors.white,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.grey,
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
        backgroundColor: Colors.grey[900],
        textTheme: const TextTheme(
          bodyText1: TextStyle(color: Colors.white),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: TasksScreen(),
    );
  }
}
