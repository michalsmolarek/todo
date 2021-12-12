import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/is_done_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:todoey/screens/add_category_screen.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/widgets/color_picker.dart';
import 'package:todoey/widgets/tasks_list.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  State<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  @override
  void initState() {
    super.initState();
    AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Zezwól na dostęp do powiadomień'),
              content:
                  const Text('Aplikacja Tu-du prosi o dostęp do powiadomień.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Nie zezwalaj',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ),
                TextButton(
                  onPressed: () => AwesomeNotifications()
                      .requestPermissionToSendNotifications()
                      .then((_) => Navigator.pop(context)),
                  child: const Text(
                    'Pozwól',
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Future<void> createPlantFoodNotification() async {
    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        icon: null,
        id: 38,
        channelKey: 'basic_channel',
        title:
            '${Emojis.money_money_bag + Emojis.plant_cactus} Buy Plant Food!!!',
        body: 'Florist at 123 Main St. has 2 in stock.',
        notificationLayout: NotificationLayout.Default,
        payload: {'uuid': 'uuid-test'},
      ),
      schedule: NotificationCalendar.fromDate(
        date: DateTime.now().add(
          const Duration(seconds: 10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Provider.of<TaskData>(context, listen: false).clear();
    // Provider.of<MainColorData>(context, listen: false).delete();
    Provider.of<CategoryData>(context, listen: false).getCategories();
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();
    Provider.of<IsDoneCheckerData>(context, listen: false).getIsDoneChecked();
    return Consumer<CategoryData>(builder: (context, category, child) {
      bool isExistSelectedCategory =
          category.categoryList.isNotEmpty ? true : false;

      return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        floatingActionButton: isExistSelectedCategory
            ? FloatingActionButton(
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
                })
            : const SizedBox(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  top: 60.0, left: 00.0, right: 00.0, bottom: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
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
                            const SizedBox(
                              width: 10,
                            ),
                            GestureDetector(
                              onTap: () {
                                createPlantFoodNotification();
                              },
                              child: const Text(
                                "Tu-du",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: Consumer<IsDoneCheckerData>(
                                  builder: (context, isDoneData, child) {
                                bool isDone = isDoneData.getIsDone.isChecked;

                                return GestureDetector(
                                  onTap: () {
                                    Provider.of<IsDoneCheckerData>(context,
                                            listen: false)
                                        .setIsDone(!isDone);
                                  },
                                  child: CircleAvatar(
                                    child: Icon(
                                      isDone
                                          ? Icons.check_circle
                                          : Icons.check_circle_outlined,
                                      size: 30.0,
                                      color: Colors.white,
                                    ),
                                    backgroundColor: Colors.transparent,
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) => const PickColor());
                                },
                                child: const CircleAvatar(
                                  child: Icon(
                                    Icons.color_lens_rounded,
                                    size: 30.0,
                                    color: Colors.white,
                                  ),
                                  backgroundColor: Colors.transparent,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 4),
                              child: GestureDetector(
                                onTap: () {
                                  Provider.of<SelectedCategoryData>(context,
                                          listen: false)
                                      .setSelectedCategory("trash");
                                },
                                child: Consumer<SelectedCategoryData>(
                                    builder: (context, selected, child) {
                                  return CircleAvatar(
                                    child: Icon(
                                      selected.selectedCategory.selectedId ==
                                              "trash"
                                          ? Icons.delete
                                          : Icons.delete,
                                      size: selected.selectedCategory
                                                  .selectedId ==
                                              "trash"
                                          ? 20.0
                                          : 30.0,
                                      color: selected.selectedCategory
                                                  .selectedId ==
                                              "trash"
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                    ),
                                    backgroundColor:
                                        selected.selectedCategory.selectedId ==
                                                "trash"
                                            ? Colors.white
                                            : Colors.transparent,
                                  );
                                }),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: TextButton.icon(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.all(0),
                          onPrimary: Colors.white,
                        ),
                        onPressed: () {
                          showModalBottomSheet(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0)),
                            context: context,
                            isScrollControlled: true,
                            builder: (context) => SingleChildScrollView(
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
                        icon: const Icon(Icons.add),
                        label: const Text(
                          "Dodaj kategorię",
                        )),
                  ),
                  Consumer<SelectedCategoryData>(
                      builder: (context, selectedCategory, child) {
                    return Consumer<CategoryData>(
                        builder: (context, categoryData, child) {
                      return SizedBox(
                        height: categoryData.categoriesCount > 0 ? 30 : 0,
                        // color: Colors.red,
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            Category cat = categoryData.categoryList[index];
                            String selected =
                                selectedCategory.selectedCategory.selectedId!;
                            return GestureDetector(
                              onTap: () {
                                Provider.of<SelectedCategoryData>(context,
                                        listen: false)
                                    .setSelectedCategory(cat.id!);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(40),
                                  color: selected == cat.id
                                      ? Colors.white
                                      : Colors.transparent,
                                ),
                                child: Row(
                                  children: [
                                    Text(
                                      cat.name!,
                                      style: TextStyle(
                                          color: selected == cat.id
                                              ? Theme.of(context).primaryColor
                                              : Colors.white,
                                          fontWeight: selected == cat.id
                                              ? FontWeight.bold
                                              : FontWeight.w400),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    selected == cat.id
                                        ? IconButton(
                                            padding: const EdgeInsets.all(2),
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              showModalBottomSheet(
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0)),
                                                context: context,
                                                isScrollControlled: true,
                                                builder: (context) =>
                                                    SingleChildScrollView(
                                                  child: Container(
                                                    padding: EdgeInsets.only(
                                                        bottom: MediaQuery.of(
                                                                context)
                                                            .viewInsets
                                                            .bottom),
                                                    child: AddCategoryScreen(
                                                      isAdding: false,
                                                      category: cat,
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            icon: Icon(
                                              Icons.edit,
                                              size: 18,
                                              color: selected == cat.id
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.white,
                                            ),
                                          )
                                        : const SizedBox(),
                                    selected == cat.id
                                        ? IconButton(
                                            padding: const EdgeInsets.all(2),
                                            constraints: const BoxConstraints(),
                                            onPressed: () {
                                              Provider.of<TaskData>(context,
                                                      listen: false)
                                                  .deleteInCategory(cat.id!);
                                              Provider.of<CategoryData>(context,
                                                      listen: false)
                                                  .deleteCategory(cat);

                                              int index =
                                                  Provider.of<CategoryData>(
                                                              context,
                                                              listen: false)
                                                          .categoryList
                                                          .indexOf(cat) -
                                                      1;

                                              if (index >= 0) {
                                                Provider.of<SelectedCategoryData>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedCategory(Provider
                                                            .of<CategoryData>(
                                                                context,
                                                                listen: false)
                                                        .categoryList
                                                        .elementAt(index)
                                                        .id);
                                              } else {
                                                Provider.of<SelectedCategoryData>(
                                                        context,
                                                        listen: false)
                                                    .setSelectedCategory(Provider
                                                            .of<CategoryData>(
                                                                context,
                                                                listen: false)
                                                        .categoryList
                                                        .elementAt(index + 2)
                                                        .id);
                                              }
                                            },
                                            icon: Icon(
                                              Icons.clear,
                                              size: 20,
                                              color: selected == cat.id
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.white,
                                            ))
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                            );
                          },
                          itemCount: categoryData.categoriesCount,
                        ),
                      );
                    });
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: const TasksList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
