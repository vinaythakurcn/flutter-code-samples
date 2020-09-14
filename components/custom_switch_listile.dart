import 'package:education_app/components/app_text.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

import './custom_switch.dart';

class CustomSwitchListile extends StatelessWidget {
  final bool value;
  final String title;
  final Function onTapHandler;
  final Color color;
  final FontWeight fontWeight;

  CustomSwitchListile(
      {this.title, this.value, this.onTapHandler, this.color, this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: AppText(
        text: title,
        fontWeight: fontWeight,
        color: color,
      ),
      onTap: () {
        onTapHandler(null);
      },
      trailing: CustomSwitch(
        activeColor: Theme.of(context).primaryColor,
        activeTrackColor: Color(kAppBorderColor),
        inactiveTrackColor: Color(kAppBorderColor),
        onChanged: onTapHandler,
        value: value,
      ),
    );
  }
}
