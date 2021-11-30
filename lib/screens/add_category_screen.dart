import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/category.dart';
import 'package:todoey/providers/category_data.dart';
import 'package:todoey/providers/selected_category_data.dart';
import 'package:uuid/uuid.dart';

class AddCategoryScreen extends StatelessWidget {
  final bool isAdding;
  final Category category;

  const AddCategoryScreen(
      {Key? key, required this.isAdding, required this.category})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    Provider.of<SelectedCategoryData>(context, listen: false).getSelected();
    TextEditingController controller = TextEditingController();
    if (!isAdding) controller.text = category.name!;
    controller.selection = TextSelection.fromPosition(
        TextPosition(offset: controller.text.length));
    String? newCategoryTitle;
    if (!isAdding) newCategoryTitle = category.name;
    return Consumer<SelectedCategoryData>(
        builder: (context, selectedCategory, child) {
      return Container(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: controller,
              onSubmitted: (v) {
                Navigator.pop(context);
              },
              textInputAction: TextInputAction.done,
              autofocus: true,
              textAlign: TextAlign.center,
              cursorColor: Theme.of(context).primaryColor,
              decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                      width: 2, color: Theme.of(context).primaryColor),
                ),
              ),
              onChanged: (newText) {
                newCategoryTitle = newText;
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
                isAdding ? 'Dodaj kategorię' : 'Aktualizuj kategorię',
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
              onPressed: () {
                if (newCategoryTitle != null) {
                  if (newCategoryTitle!.trim().isNotEmpty) {
                    String newId = const Uuid().v1();
                    Provider.of<CategoryData>(context, listen: false)
                        .addCategory(
                            Category(id: newId, name: newCategoryTitle));
                    Provider.of<SelectedCategoryData>(context, listen: false)
                        .setSelectedCategory(newId);
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
    });
  }
}
