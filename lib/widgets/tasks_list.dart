import 'package:flutter/material.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:todoey/screens/add_category_screen.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/widgets/task_tile.dart';

import 'package:provider/provider.dart';

class TasksList extends StatelessWidget {
  const TasksList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Provider.of<TaskData>(context, listen: false).getTasks();
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();
    // Provider.of<SelectedCategoryData>(context, listen: false).clear();
    return Consumer<CategoryData>(builder: (context, categoryData, child) {
      return Consumer<SelectedCategoryData>(
          builder: (context, selectedCategory, child) {
        return Consumer<TaskData>(
          builder: (context, taskData, child) {
            var filtered = taskData.taskList
                .where((element) =>
                    element.category ==
                    selectedCategory.getSelectedCategory.selectedId)
                .toList();
            return filtered.isNotEmpty
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
                : filtered.isEmpty && taskData.taskCount > 0
                    ? const Center(
                        child: Text(
                          "Brak elementów w tej kategorii",
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : categoryData.categoriesCount > 0
                        ? Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Nie dodano jeszcze żadnych zadań.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: AddTaskScreen(
                                            isAdding: true,
                                            task: Task(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Aby rozpocząć, dodaj pierwszą kategorię",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.grey),
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20.0)),
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (context) =>
                                          SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: AddCategoryScreen(
                                            isAdding: true,
                                            category: Category(),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.add_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 30,
                                  ),
                                ),
                              ],
                            ),
                          );
          },
        );
      });
    });
  }
}
