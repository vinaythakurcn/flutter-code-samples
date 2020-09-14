import 'package:education_app/components/custom_bottom_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/custom_appbar.dart';

const List bottomNavTab = [
  {'icon': Icons.book, 'label': 'Book'},
  {'icon': Icons.school, 'label': 'Courses'},
  {'icon': Icons.account_box, 'label': 'Account'},
  {'icon': Icons.settings, 'label': 'Settings'},
];

class FeedList extends StatefulWidget {
  static const PAGEID = 'feed-list';

  static RoundedRectangleBorder cardBorderRadius =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

  static const cardPadd =
      const EdgeInsets.only(top: 48.0, right: 40.0, left: 40.0, bottom: 24.0);
  static const cardControlPadd =
      const EdgeInsets.only(top: 0, right: 24.0, left: 40.0, bottom: 24.0);

  static const selectedTabBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 6.0, color: Color(kPrimaryColor)),
    ),
  );

  @override
  _FeedListState createState() => _FeedListState();
}

class _FeedListState extends State<FeedList>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
    int _selectedIndex = 0;
  final _tabDefaultBorder = Positioned(
    bottom: 1.5,
    left: 0,
    right: 0,
    child: Container(
      color: Color(kAppBorderColor),
      height: 2.0,
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      bottomNavigationBar: CustomBottomNavigation(
        onSelectedTab: (index) {
          // print("in tab: $index");
        },
        bottomBarItem: bottomNavTab,
        selectedTab: _selectedIndex,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        selectedIconColor: IconThemeData(color: Color(kPrimaryColor)),
        unSelectedIconColor: IconThemeData(color: Color(kPrimaryTitleColor)),
        selectedTextColor: TextStyle(color: Colors.yellow),
      ),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: const Text('Feed'),
        appBarBottom: PreferredSize(
          child: Stack(
            children: <Widget>[
              _tabDefaultBorder,
              TabBar(
                controller: _tabController,
                indicator: FeedList.selectedTabBorder,
                tabs: [
                  getTab('Favorites', 0),
                  getTab('Lastes', 1),
                  getTab('Trending', 2),
                ],
              ),
            ],
          ),
          preferredSize: Size.fromHeight(48.0),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          getFavTab(),
          Icon(Icons.directions_car),
          Icon(Icons.directions_transit),
        ],
      ),
    );
  }

  getTab(String tabName, int index) {
    return Tab(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: AppText(
            text: tabName,
            color: _tabController.index == index
                ? Color(kPrimaryTitleColor)
                : null,
            fontWeight: _tabController.index == index
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  getFavTab() {
    return RefreshIndicator(
      onRefresh: () {
        return null;
      }, //onRefresh(context),
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 24.0),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  getCard(),
                  getAvatarPanel(
                      'https://images.pexels.com/photos/159866/books-book-pages-read-literature-159866.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500')
                ],
              ),
              Stack(
                children: <Widget>[
                  getCard(),
                  getAvatarPanel(
                      'https://blog.studocu.com/wp-content/uploads/2017/08/best-books-book-youll-ever-read.jpg')
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  getCard() {
    return Card(
      shape: FeedList.cardBorderRadius,
      elevation: 0,
      color: const Color(kPrimaryColor),
      margin: const EdgeInsets.only(
          top: 32.0, bottom: 16.0, right: 16.0, left: 16.0),
      child: Column(
        children: <Widget>[
          Padding(
            padding: FeedList.cardPadd,
            child: AppText(
              text:
                  'Every age and social strata has its bad eggs, rule-breakers, and nose-thumbers.',
              size: 24.0,
              color: const Color(kSecondaryTextColor),
            ),
          ),
          Padding(padding: FeedList.cardControlPadd, child: getBottomControls())
        ],
      ),
    );
  }

  getBottomControls() {
    return Row(
      children: <Widget>[
        Expanded(
          child: FlatButton(
            padding: const EdgeInsets.all(0),
            onPressed: () {},
            child: Row(
              children: <Widget>[
                getIcon(Icons.school),
                const SizedBox(width: 16.0),
                AppText(
                  text: 'Course',
                  fontWeight: FontWeight.bold,
                  color: const Color(kSecondaryTextColor),
                  size: 18.0,
                )
              ],
            ),
          ),
        ),
        getIconBtn(
          name: CupertinoIcons.share_up,
          handler: () {},
        ),
        getIconBtn(
          name: Icons.star_border,
          handler: () {},
        ),
      ],
    );
  }

  getIconBtn({dynamic name, Function handler}) {
    return IconButton(
      padding: const EdgeInsets.all(0),
      icon: getIcon(name),
      onPressed: handler,
    );
  }

  getIcon(dynamic name) {
    return Icon(name, color: const Color(kSecondaryTextColor));
  }

  getAvatarPanel(String url) {
    return Positioned(
      top: 0,
      left: 56.0,
      child: Container(
        width: 64,
        height: 64,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(url),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
