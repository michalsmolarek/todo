import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/main_color_data.dart';
import 'package:todoey/screens/tasks_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // context.watch<MainColorData>().getColor();
    Provider.of<MainColorData>(context, listen: false).getColor();
    return Consumer<MainColorData>(
      builder: (context, mainColorData, child) {
        return MaterialApp(
          theme: ThemeData(
            brightness: Brightness.light,
            primaryColor: Color(mainColorData.color.color),
            backgroundColor: Colors.white,
            fontFamily: "Montserrat",
          ),
          darkTheme: ThemeData(
            fontFamily: "Montserrat",
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
            primaryColor: Color(mainColorData.color.color),
            backgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              bodyText1: TextStyle(color: Colors.white),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const TasksScreen(),
        );
      },
    );
  }
}
