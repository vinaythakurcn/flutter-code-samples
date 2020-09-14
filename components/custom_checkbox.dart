import 'package:flutter/material.dart';
import '../constants.dart';

enum CheckboxType { Primary, Secondary, Circular }

class CustomCheckbox extends StatelessWidget {
  final bool value;
  final Function onChanged;
  final CheckboxType type;

  CustomCheckbox({
    @required this.value,
    @required this.onChanged,
    @required this.type,
  });

  Widget getPrimaryCheckboxIcon() {
    if (value)
      return Icon(
        Icons.check,
        size: 16.0,
        color: Colors.white,
      );
    else
      return Container();
  }

  Widget getSecondaryCheckboxIcon(context) {
    if (value)
      return Icon(
        Icons.check,
        size: 16.0,
        color: Theme.of(context).primaryColor,
      );
    else
      return Container();
  }

  BoxDecoration getPrimaryBoxDecoration(context) {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
      color: value ? Theme.of(context).primaryColor : Colors.white,
    );
  }

  BoxDecoration getCircularBoxDecoration(context) {
    return BoxDecoration(
      shape: BoxShape.circle,
      // borderRadius: BorderRadius.circular(4.0),
      // border: Border.all(color: Theme.of(context).primaryColor, width: 2.0),
      color: value ? Theme.of(context).primaryColor : Colors.white,
    );
  }

  BoxDecoration getSecondaryBoxDecoration() {
    return BoxDecoration(
      shape: BoxShape.rectangle,
      borderRadius: BorderRadius.circular(4.0),
      border: Border.all(color: Color(kAppBorderColor), width: 2.0),
      color: Colors.white,
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onChanged,
      child: Container(
        width: 20.0,
        height: 20.0,
        decoration: type == CheckboxType.Primary
            ? getPrimaryBoxDecoration(context)
            : (type == CheckboxType.Circular
                ? getCircularBoxDecoration(context)
                : getSecondaryBoxDecoration()),
        child: type == CheckboxType.Primary || type == CheckboxType.Circular
            ? getPrimaryCheckboxIcon()
            : getSecondaryCheckboxIcon(context),
      ),
    );
  }
}
