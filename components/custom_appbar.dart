import 'package:flutter/material.dart';

class CustomAppBar extends AppBar {
  CustomAppBar({
    Key key,
    Widget appBarTitle,
    List<Widget> appBarActions,
    dynamic appBarBottom,
    Widget appBarLeading,
  }) : super(
          key: key,
          title: appBarTitle,
          centerTitle: true,
          leading: appBarLeading,
          bottom: appBarBottom,
          actions: appBarActions,
        );
}
