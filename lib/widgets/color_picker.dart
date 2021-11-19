import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:provider/provider.dart';
import 'package:todoey/models/main_color_data.dart';

class PickColor extends StatelessWidget {
  const PickColor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.all(10),
      elevation: 50,
      insetAnimationCurve: Curves.easeIn,
      insetAnimationDuration: const Duration(seconds: 1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Consumer<MainColorData>(
        builder: (context, mainColorData, child) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 250,
                padding: const EdgeInsets.all(10),
                child: BlockPicker(
                  itemBuilder: (color, isCurrentColor, changeColor) =>
                      GestureDetector(
                    onTap: () {
                      changeColor();
                      Navigator.of(context).pop();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color,
                      ),
                      width: 100,
                      height: 100,
                      child: isCurrentColor
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : const SizedBox(),
                    ),
                  ),
                  availableColors: [
                    Colors.blue,
                    Colors.brown,
                    Colors.deepOrange[400]!,
                    Colors.redAccent,
                    Colors.purple[900]!,
                    Colors.lightGreen,
                    Colors.grey[600]!,
                    Colors.deepPurple[200]!,
                    Colors.blue[100]!,
                    Colors.teal,
                    Colors.indigoAccent,
                    Colors.yellow[700]!,
                  ],
                  onColorChanged: (Color value) {
                    Provider.of<MainColorData>(context, listen: false)
                        .setColor(value.withAlpha(255).hashCode);
                  },
                  pickerColor: Color(mainColorData.color.color),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
