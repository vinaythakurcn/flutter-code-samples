import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class CustomRadioListTile extends StatelessWidget {
  final title;
  final String value;
  final Function onChangeHandler;
  final String groupValue;
  final bool isLeading;

  CustomRadioListTile({
    @required this.title,
    @required this.value,
    @required this.onChangeHandler,
    @required this.groupValue,
    this.isLeading,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(accentColor: Color(kAppBorderColor)),
      child: InkWell(
        onTap: () {
          onChangeHandler(value);
        },
        child: Row(
          children: <Widget>[
            isLeading == true
                ? Radio(
                    activeColor: Theme.of(context).primaryColor,
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChangeHandler,
                  )
                : Container(),
            Expanded(child: title),
            isLeading == null || isLeading == false
                ? Radio(
                    activeColor: Theme.of(context).primaryColor,
                    value: value,
                    groupValue: groupValue,
                    onChanged: onChangeHandler,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
