import 'package:flutter/material.dart';

class CustomMenuDrawer extends StatelessWidget {
  List menuItem;
  double drawerWidth;

  CustomMenuDrawer({@required this.menuItem});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: <Widget>[
            DrawerHeader(
              child: Container(
                child: Center(
                  child: Text('Drawer Header'),
                ),
              ),
            ),
            ...menuItem.map((el) {
              return menuItemView(el);
            }).toList()
          ],
        ),
      ),
    );
  }

  Widget menuItemView(menu) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(width: 1.0, color: Colors.black12),
      )),
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Icon(
            menu['icon'],
            size: 30.0,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text(
            menu['label'],
            style: new TextStyle(fontSize: 30.0, fontWeight: FontWeight.w300),
          ),
        ],
      ),
    );
  }
}
