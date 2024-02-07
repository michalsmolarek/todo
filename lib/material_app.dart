import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/providers/main_color_data.dart';
import 'package:todoey/screens/tasks_screen.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // AwesomeNotifications()
    //     .actionStream
    //     .listen((ReceivedNotification receivedNotification) {
    //   print(receivedNotification.payload);
    // });
    // context.watch<MainColorData>().getColor();
    Provider.of<MainColorData>(context, listen: false).getColor();
    return Consumer<MainColorData>(
      builder: (context, mainColorData, child) {
        print(mainColorData.color.color);
        return MaterialApp(
          theme: ThemeData(
            useMaterial3: false,
            brightness: Brightness.light,
            primaryColor: Color(mainColorData.color.color).withAlpha(255),
            // ignore: deprecated_member_use
            backgroundColor: Colors.white,
            fontFamily: "Montserrat",
          ),
          darkTheme: ThemeData(
            useMaterial3: false,
            fontFamily: "Montserrat",
            primarySwatch: Colors.grey,
            brightness: Brightness.dark,
            primaryColor: Color(mainColorData.color.color),
            // ignore: deprecated_member_use
            backgroundColor: Colors.grey[900],
            textTheme: const TextTheme(
              // ignore: deprecated_member_use
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
