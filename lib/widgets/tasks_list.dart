import 'package:flutter/material.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:todoey/widgets/task_tile.dart';

import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).getTasks();
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();
    // Provider.of<SelectedCategoryData>(context, listen: false).clear();

    return Consumer<SelectedCategoryData>(
        builder: (context, selectedCategory, child) {
      return Consumer<TaskData>(
        builder: (context, taskData, child) {
          var filtered = taskData.taskList
              .where((element) =>
                  element.category ==
                  selectedCategory.getSelectedCategory.selectedId)
              .toList();
          return taskData.taskCount > 0
              ? ListView.builder(
                  padding: const EdgeInsets.only(top: 20),
                  itemBuilder: (context, index) {
                    final task = filtered[index];
                    return TaskTile(
                      category: task.category,
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
                  itemCount: filtered.length,
                )
              : const Center(
                  child: Text(
                    "Twoja lista jest pusta",
                    style: TextStyle(color: Colors.grey),
                  ),
                );
        },
      );
    });
  }
}
