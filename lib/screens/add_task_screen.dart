import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/models/task_data.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatelessWidget {
  final bool isAdding;
  final Task task;

  const AddTaskScreen({Key? key, required this.isAdding, required this.task})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    if (!isAdding) controller.text = task.name!;
    String? newTaskTitle;
    if (!isAdding) newTaskTitle = task.name!;
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Text(
            isAdding ? 'Dodaj' : 'Aktualizuj',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 30.0,
              color: Theme.of(context).primaryColor,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          TextField(
            controller: controller,
            onSubmitted: (v) {
              if (isAdding) {
                if (newTaskTitle!.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).addTask(Task(
                      id: const Uuid().v1(),
                      name: newTaskTitle,
                      isDone: false));
                }
              } else {
                if (newTaskTitle!.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).update(Task(
                      id: task.id, name: newTaskTitle, isDone: task.isDone));
                }
              }
              Navigator.pop(context);
            },
            textInputAction: TextInputAction.done,
            autofocus: true,
            textAlign: TextAlign.center,
            cursorColor: Theme.of(context).primaryColor,
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide:
                    BorderSide(width: 2, color: Theme.of(context).primaryColor),
              ),
            ),
            onChanged: (newText) {
              newTaskTitle = newText;
            },
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.0),
                ),
                primary: Theme.of(context).primaryColor),
            child: Text(
              isAdding ? 'Dodaj' : 'Aktualizuj',
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            onPressed: () {
              if (isAdding) {
                if (newTaskTitle!.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).addTask(Task(
                      id: const Uuid().v1(),
                      name: newTaskTitle,
                      isDone: false));
                }
              } else {
                if (newTaskTitle!.isNotEmpty) {
                  Provider.of<TaskData>(context, listen: false).update(Task(
                      id: task.id, name: newTaskTitle, isDone: task.isDone));
                }
              }
              Navigator.pop(context);
            },
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
