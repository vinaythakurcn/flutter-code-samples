import 'package:flutter/material.dart';

import '../constants.dart';

class CustomIncrementDecrement extends StatelessWidget {
  final String title;
  final String value;
  final Function onIncrease;
  final Function onDecrease;
  final Color textColor;

  CustomIncrementDecrement({
    @required this.title,
    @required this.value,
    @required this.onIncrease,
    @required this.onDecrease,
    this.textColor
  });

  static const fontStyle = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Text(
              title,
              style: fontStyle,
            ),
          ),
          Container(
            width: 104.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                InkWell(
                  onTap: onDecrease,
                  child: ClipOval(
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Icon(
                          Icons.remove_circle,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Center(
                    child: FittedBox(
                      child: Text(
                        value,
                        style: fontStyle,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: onIncrease,
                  child: ClipOval(
                    child: Container(
                      width: 32.0,
                      height: 32.0,
                      decoration:
                          BoxDecoration(color: Theme.of(context).primaryColor),
                      child: Center(
                        child: Icon(
                          Icons.add_circle,
                          size: 24.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
