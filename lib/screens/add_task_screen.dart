import 'dart:math';

import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/my_notification.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/notification_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:uuid/uuid.dart';

class AddTaskScreen extends StatefulWidget {
  final bool isAdding;
  final Task task;

  const AddTaskScreen({Key? key, required this.isAdding, required this.task}) : super(key: key);

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  String newId = const Uuid().v1();
  late DateTime selectedDate;
  bool isNotification = false;
  String? newTaskTitle;
  TextEditingController controller = TextEditingController();
  int id = Random().nextInt(99999999);

  Future<void> createNotification(int id, String title, DateTime dateTime) async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        icon: null,
        id: id,
        channelKey: 'tudu',
        title: title,
        body: id.toString(),
        notificationLayout: NotificationLayout.Default,
      ),
      schedule: NotificationCalendar.fromDate(
        date: dateTime,
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (!widget.isAdding) {
      if (Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).id != 0) {
        isNotification = true;
        selectedDate = Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).dateEnd!;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();

    if (!widget.isAdding) controller.text = widget.task.name!;
    controller.selection = TextSelection.fromPosition(TextPosition(offset: controller.text.length));

    if (!widget.isAdding) newTaskTitle = widget.task.name!;
    return Consumer<SelectedCategoryData>(builder: (context, selectedCategory, child) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              onSubmitted: (v) {
                if (newTaskTitle != null) {
                  if (widget.isAdding) {
                    if (newTaskTitle!.trim().isNotEmpty && newTaskTitle! != " ") {
                      String newId = const Uuid().v1();
                      Provider.of<TaskData>(context, listen: false).addTask(Task(
                        id: newId,
                        name: newTaskTitle,
                        isDone: false,
                        category: selectedCategory.getSelectedCategory.selectedId,
                      ));
                    }
                  } else {
                    if (newTaskTitle!.trim().isNotEmpty) {
                      Provider.of<TaskData>(context, listen: false).update(Task(
                        id: widget.task.id,
                        name: newTaskTitle,
                        isDone: widget.task.isDone,
                        category: selectedCategory.getSelectedCategory.selectedId,
                      ));
                    }
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
                  borderSide: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (newText) {
                newTaskTitle = newText;
              },
            ),
            const SizedBox(
              height: 15,
            ),
            isNotification
                ? GestureDetector(
                    onTap: () {
                      print(
                          "Kasuje - ${Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).id!}");

                      Provider.of<NotificationData>(context, listen: false).deleteNotification(
                          Provider.of<NotificationData>(context, listen: false)
                              .getNotification(widget.task.id!)
                              .taskId!);

                      AwesomeNotifications().cancel(
                          Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).id!);
                      AwesomeNotifications().cancelSchedule(
                          Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).id!);
                    },
                    child: Text(
                      "$selectedDate / ${Provider.of<NotificationData>(context, listen: false).getNotification(widget.task.id!).id}",
                    ),
                  )
                : const SizedBox(),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(15),
                        backgroundColor: Theme.of(context).primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40.0),
                        )),
                    child: Text(
                      widget.isAdding ? 'Dodaj' : 'Aktualizuj',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (newTaskTitle != null) {
                        if (widget.isAdding) {
                          if (newTaskTitle!.trim().isNotEmpty) {
                            Provider.of<TaskData>(context, listen: false).addTask(Task(
                              id: newId,
                              name: newTaskTitle,
                              isDone: false,
                              category: selectedCategory.getSelectedCategory.selectedId,
                            ));
                            if (isNotification) {
                              createNotification(id, newTaskTitle!, selectedDate);
                              print("ustawiam powiadomienie przy tworzeniu");
                              Provider.of<NotificationData>(context, listen: false)
                                  .setNotification(MyNotification(id, DateTime.now(), selectedDate, newId));
                            }
                          }
                        } else {
                          if (newTaskTitle!.trim().isNotEmpty) {
                            Provider.of<TaskData>(context, listen: false).update(Task(
                              id: widget.task.id,
                              name: newTaskTitle,
                              isDone: widget.task.isDone,
                              category: selectedCategory.getSelectedCategory.selectedId,
                            ));

                            if (isNotification) {
                              createNotification(id, newTaskTitle!, selectedDate);
                              print("ustawiam powiadomienie przy edycji");
                              Provider.of<NotificationData>(context, listen: false)
                                  .setNotification(MyNotification(id, DateTime.now(), selectedDate, widget.task.id));
                            }
                          }
                        }
                      }

                      Navigator.pop(context);
                    },
                  ),
                ),
                IconButton(
                  onPressed: () {
                    DatePicker.showDateTimePicker(
                      context,
                      showTitleActions: true,
                      onCancel: () {
                        print("canceled");
                      },
                      minTime: DateTime.now(),
                      maxTime: DateTime(2030),
                      onChanged: (date) {
                        print('change $date');
                      },
                      onConfirm: (date) {
                        setState(() {
                          selectedDate = date;
                          isNotification = true;
                        });
                        print(selectedDate);
                      },
                      currentTime: DateTime.now(),
                      locale: LocaleType.pl,
                    );
                  },
                  icon: const Icon(Icons.schedule),
                  color: Theme.of(context).primaryColor,
                  iconSize: 30,
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
          ],
        ),
      );
    });
  }
}
