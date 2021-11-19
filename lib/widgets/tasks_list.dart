import 'package:flutter/material.dart';
import 'package:todoey/models/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';

import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).getTasks();
    return Consumer<TaskData>(
      builder: (context, taskData, child) {
        return taskData.taskCount > 0
            ? ListView.builder(
                padding: const EdgeInsets.only(top: 20),
                itemBuilder: (context, index) {
                  final task = taskData.taskList[index];
                  return TaskTile(
                    taskId: task.id!,
                    taskTitle: task.name!,
                    isChecked: task.isDone,
                    checkboxCallback: () {
                      taskData.toggleDone(task);
                    },
                    deleteCallback: () {
                      taskData.deleteTask(task);
                    },
                  );
                },
                itemCount: taskData.taskCount,
              )
            : const Center(
                child: Text(
                  "Twoja lista jest pusta",
                  style: TextStyle(color: Colors.grey),
                ),
              );
      },
    );
  }
}
