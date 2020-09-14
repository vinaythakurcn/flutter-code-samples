import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/custom_appbar.dart';
import '../components/app_bg_image.dart';
import '../components/app_title.dart';

import '../screens/course-detail.dart';

class CourseBrowse extends StatefulWidget {
  static const PAGEID = 'course-browse';

  static RoundedRectangleBorder cardBorderRadius =
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0));

  static const cardPadd =
      const EdgeInsets.only(top: 48.0, right: 40.0, left: 40.0, bottom: 24.0);
  static const cardControlPadd =
      const EdgeInsets.only(top: 0, right: 24.0, left: 40.0, bottom: 24.0);

  @override
  _CourseBrowseState createState() => _CourseBrowseState();
}

class _CourseBrowseState extends State<CourseBrowse>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  final String image =
      'https://rukminim1.flixcart.com/image/832/832/poster/f/k/g/doraemon-cartoon-hd-poster-art-bshi293-bshil293-large-original-imaeg56yzpmgjacg.jpeg?q=70';

  final selectedTabBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 6.0, color: Color(kPrimaryColor)),
    ),
  );

  final _defaultTabBorder = Positioned(
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
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: const Text('Courses'),
        appBarBottom: PreferredSize(
          child: Stack(
            children: <Widget>[
              _defaultTabBorder,
              TabBar(
                controller: _tabController,
                indicator: selectedTabBorder,
                tabs: [
                  getTab('All', 0),
                  getTab('Enrolled', 1),
                  getTab('Completed', 2),
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
          child: FittedBox(
            child: AppText(
              text: tabName,
              color: _tabController.index == index
                  ? const Color(kPrimaryTitleColor)
                  : null,
              fontWeight: _tabController.index == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  getFavTab() {
    return RefreshIndicator(
      onRefresh: () {
        return null;
      },
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[getCourseCard(), getCourseCard()],
          ),
        ),
      ),
    );
  }

  getCourseCard() {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(CourseDetail.PAGEID);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 24.0),
        child: Column(
          children: <Widget>[
            AppBgImage(url: image),
            Padding(
              padding: const EdgeInsets.only(top: 16.0, left: 8.0, right: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppTitle(text: 'Online Master\'s of Accounting (iMSA)'),
                  AppText(
                    noOpacity: true,
                    text: 'from the University of Illinois',
                    size: 24.0,
                  ),
                  const SizedBox(height: 8.0),
                  AppText(
                      noOpacity: true,
                      text:
                          'As automation and advancements in technology upend every sector of the economy, accounting students need to learn much more than a CPA’s traditional skill set.')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
