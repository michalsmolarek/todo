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
    return Container(
      child: Container(
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
            TextFormField(
              controller: controller,
              onSaved: (v) {
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
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).primaryColor),
              child: Text(
                isAdding ? 'Dodaj' : 'Aktualizuj',
                style: const TextStyle(
                  color: Colors.white,
                ),
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
          ],
        ),
      ),
    );
  }
}
