import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double minVal;
  final double maxVal;
  final Function onChangeEvent;

  CustomSlider(
      {@required this.value,
      @required this.minVal,
      @required this.maxVal,
      @required this.onChangeEvent});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Slider(
        activeColor: Theme.of(context).primaryColor,
        inactiveColor: Color(kSecondaryBackgroundColor),
        onChanged: onChangeEvent,
        value: value,
        max: maxVal,
        min: minVal,
      ),
    );
  }
}
