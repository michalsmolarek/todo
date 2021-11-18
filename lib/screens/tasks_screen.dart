import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/main_color.dart';
import 'package:todoey/models/main_color_data.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/widgets/color_picker.dart';
import 'package:todoey/widgets/tasks_list.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<TaskData>(context, listen: false).clear();
    // Provider.of<MainColorData>(context, listen: false).delete();
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      floatingActionButton: GestureDetector(
        onLongPress: () {
          Provider.of<TaskData>(context, listen: false).clear();
          // Provider.of<MainColorData>(context, listen: false).delete();
          Fluttertoast.showToast(
              msg: "Skasowano całą listę",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.CENTER);
        },
        child: FloatingActionButton(
            backgroundColor: Theme.of(context).primaryColor,
            child: const Icon(Icons.add),
            onPressed: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(
                      isAdding: true,
                      task: Task(),
                    ),
                  ),
                ),
              );
            }),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
                top: 60.0, left: 30.0, right: 30.0, bottom: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Icon(
                            Icons.done_all,
                            size: 20.0,
                            color: Theme.of(context).primaryColor,
                          ),
                          backgroundColor: Colors.white,
                          radius: 20.0,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Tu-du",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (context) => PickColor());
                      },
                      child: CircleAvatar(
                        child: Icon(
                          Icons.color_lens_rounded,
                          size: 30.0,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Container(
                  width: double.infinity,
                  child: Text(
                    '${Provider.of<TaskData>(context).taskCount} w liście',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Theme.of(context).backgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: const TasksList(),
            ),
          ),
        ],
      ),
    );
  }
}
