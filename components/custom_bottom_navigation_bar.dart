import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatefulWidget {
  final List bottomBarItem;
  int selectedTab;
  bool showSelectedLabels = false;
  bool showUnselectedLabels = false;
  IconThemeData selectedIconColor = IconThemeData(color: Color(0xFF2BB1F3));
  IconThemeData unSelectedIconColor;
  TextStyle selectedTextColor = TextStyle(color: Color(0xFF2BB1F3));
  TextStyle unSelectedTextColor;
  Function onSelectedTab;

  CustomBottomNavigation(
      {@required this.bottomBarItem,
      @required this.selectedTab,
      this.showSelectedLabels,
      this.showUnselectedLabels,
      this.selectedIconColor,
      this.unSelectedIconColor, @required this.onSelectedTab, this.selectedTextColor, this.unSelectedTextColor});

  @override
  _CustomBottomNavigationState createState() => _CustomBottomNavigationState();
}

class _CustomBottomNavigationState extends State<CustomBottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: widget.selectedTab,
      showSelectedLabels: widget.showSelectedLabels,
      showUnselectedLabels: widget.showUnselectedLabels,
      selectedIconTheme: widget.selectedIconColor,
      unselectedIconTheme: widget.unSelectedIconColor,
      selectedLabelStyle: widget.selectedTextColor,
      unselectedLabelStyle: widget.unSelectedTextColor,
      onTap: (int index) {
        setState(() {
          widget.selectedTab = index;
        });
        widget.onSelectedTab(index);
      },
      items: getBottomNavTabList(),
    );
  }

  List<BottomNavigationBarItem> getBottomNavTabList() {
    List<BottomNavigationBarItem> bottomNavigationBarItem = [];
    for (var i = 0; i < widget.bottomBarItem.length; i++) {
      bottomNavigationBarItem.add(BottomNavigationBarItem(
        icon: Icon(
          widget.bottomBarItem[i]['icon'],
          size: 30.0,
        ),
        title: Text(
          widget.bottomBarItem[i]['label'],
          // style: defaultLabelClr,
        ),
      ));
    }
    return bottomNavigationBarItem;
  }
}
