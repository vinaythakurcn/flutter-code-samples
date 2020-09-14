import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import 'package:flutter_colorpicker/utils.dart';

const List<Color> colorsPicker = [
  Color(0xff4c4c4c),
  Color(0xff777777),
  Color(0xff2bb1f3),
  Color(0xff869da7),
  Color(0xfffec22d),
  Color(0xff949494),
  Color(0xffadadad),
  Color(0xff80d0f8),
  Color(0xffb6c4ca),
  Color(0xfffeda81),
  Color(0xffc9c9c9),
  Color(0xffd6d6d6),
  Color(0xffbfe8fb),
  Color(0xffdbe2e5),
  Color(0xffffedc0),
];

class CustomBlockColorPicker extends StatelessWidget {
  final Color selectedColor;
  final Function onColorChanged;

  CustomBlockColorPicker(
      {@required this.selectedColor, @required this.onColorChanged});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SingleChildScrollView(
        child: BlockPicker(
          availableColors: colorsPicker,
          pickerColor: selectedColor,
          layoutBuilder:
              (BuildContext context, List<Color> colors, PickerItem child) {
            return Container(
              width: 320.0,
              height: 136.0,
              child: GridView.count(
                crossAxisCount: 5,
                crossAxisSpacing: 10.0,
                mainAxisSpacing: 10.0,
                children: colors.map((Color color) => child(color)).toList(),
              ),
            );
          },
          itemBuilder:
              (Color color, bool isCurrentColor, Function changeColor) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50.0),
                color: color,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: changeColor,
                  borderRadius: BorderRadius.circular(50.0),
                  child: AnimatedOpacity(
                    duration: const Duration(milliseconds: 210),
                    opacity: isCurrentColor ? 1.0 : 0.0,
                    child: Icon(
                      Icons.done,
                      color: useWhiteForeground(color)
                          ? Colors.white
                          : Colors.black,
                    ),
                  ),
                ),
              ),
            );
          },
          onColorChanged: (Color color) {
            onColorChanged(color);
            Navigator.of(context).pop();
          },
        ),
      ),
    );
  }
}
