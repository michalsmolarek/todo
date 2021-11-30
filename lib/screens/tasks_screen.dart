import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';
import 'package:todoey/screens/add_category_screen.dart';
import 'package:todoey/screens/add_task_screen.dart';
import 'package:todoey/widgets/color_picker.dart';
import 'package:todoey/widgets/tasks_list.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<TaskData>(context, listen: false).clear();
    // Provider.of<MainColorData>(context, listen: false).delete();
    Provider.of<CategoryData>(context, listen: false).getCategories();
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();
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
                            const Text(
                              "Tu-du",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                        GestureDetector(
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
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: GestureDetector(
                      onLongPress: () {
                        Provider.of<CategoryData>(context, listen: false)
                            .clear();
                      },
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

                                              Category firstCat =
                                                  Provider.of<CategoryData>(
                                                          context,
                                                          listen: false)
                                                      .categoryList
                                                      .last;
                                              Provider.of<SelectedCategoryData>(
                                                      context,
                                                      listen: false)
                                                  .setSelectedCategory(
                                                      firstCat.id!);
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
