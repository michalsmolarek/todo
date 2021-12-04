import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:todoey/screens/add_task_screen.dart';

class TaskTile extends StatelessWidget {
  final String taskId;
  final bool isChecked;
  final String taskTitle;
  final String category;
  final VoidCallback checkboxCallback;
  final VoidCallback deleteCallback;

  const TaskTile(
      {Key? key,
      required this.isChecked,
      required this.category,
      required this.taskId,
      required this.taskTitle,
      required this.checkboxCallback,
      required this.deleteCallback})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SelectedCategoryData>(builder: (context, selected, child) {
      return Slidable(
        actionExtentRatio: 1 / 3,
        key: Key(taskId),
        actionPane: const SlidableDrawerActionPane(),
        secondaryActions: [
          IconSlideAction(
            caption: 'Skasuj',
            color: Colors.red,
            icon: Icons.delete_forever,
            onTap: deleteCallback,
          ),
          selected.selectedCategory.selectedId != "trash"
              ? IconSlideAction(
                  caption: 'Przenieś do kosza',
                  color: Colors.orange,
                  icon: Icons.delete,
                  foregroundColor: Colors.white,
                  onTap: () {
                    Provider.of<TaskData>(context, listen: false).update(
                      Task(
                          id: taskId,
                          isDone: isChecked,
                          name: taskTitle,
                          category: "trash"),
                    );
                  },
                )
              : IconSlideAction(
                  caption: 'Przywróć',
                  color: Theme.of(context).primaryColor,
                  icon: Icons.restore_from_trash,
                  onTap: () {},
                ),
        ],
        actions: [
          IconSlideAction(
            caption: 'Edytuj',
            color: Theme.of(context).primaryColor,
            icon: Icons.edit,
            foregroundColor: Colors.white,
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                builder: (context) => SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: AddTaskScreen(
                      isAdding: false,
                      task:
                          Task(id: taskId, name: taskTitle, isDone: isChecked),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
        child: ListTile(
          horizontalTitleGap: 0,
          title: Opacity(
            opacity: isChecked ? .3 : 1,
            child: Text(
              taskTitle,
              style: TextStyle(
                  decoration: isChecked ? TextDecoration.lineThrough : null),
            ),
          ),
          trailing: Checkbox(
            activeColor: Theme.of(context).primaryColor,
            value: isChecked,
            onChanged: (bool? v) {
              checkboxCallback();
            },
          ),
        ),
      );
    });
  }
}
