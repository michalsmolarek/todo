import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/models/task.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:todoey/providers/task_data.dart';

class SelectCategoryScreen extends StatelessWidget {
  final Task task;

  const SelectCategoryScreen({Key? key, required this.task}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Wybierz kategorię do której chcesz przenieść to zadanie",
              style: TextStyle(
                  fontWeight: FontWeight.bold, height: 1.5, fontSize: 16),
            ),
            const SizedBox(
              height: 20,
            ),
            const Divider(),
            Consumer<CategoryData>(builder: (context, categoryData, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Category cat = categoryData.categoryList[index];
                  return ListTile(
                    onTap: () {
                      Task newTask = task;
                      newTask.category = cat.id;
                      Provider.of<TaskData>(context, listen: false)
                          .update(task);
                      Provider.of<SelectedCategoryData>(context, listen: false)
                          .setSelectedCategory(cat.id!);
                      Navigator.of(context).pop();
                    },
                    contentPadding: EdgeInsets.zero,
                    title: Text(cat.name!),
                  );
                },
                itemCount: categoryData.categoriesCount,
              );
            }),
          ],
        ),
      ),
    );
  }
}
