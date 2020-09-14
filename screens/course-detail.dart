import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_progressbar.dart';

class CourseDetail extends StatefulWidget {
  static const PAGEID = 'course-detail';

  @override
  _CourseDetailState createState() => _CourseDetailState();
}

class _CourseDetailState extends State<CourseDetail>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  static const _expandedHeight = 400.0;

  final selectedTabBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 6.0, color: Color(kPrimaryColor)),
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
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              expandedHeight: _expandedHeight,
              floating: false,
              pinned: true,
              flexibleSpace: getFlexiArea(),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(CupertinoIcons.share_up),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(Icons.star_border),
                  onPressed: () {},
                ),
              ],
              leading: getBackButton(context),
              elevation: 0,
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                TabBar(
                  controller: _tabController,
                  indicator: selectedTabBorder,
                  tabs: [
                    getTab('About', 0),
                    getTab('Syllabus', 1),
                    getTab('Discussions', 2),
                  ],
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: Stack(children: <Widget>[
          Container(
            color: Color(kAppBorderColor),
            height: 1.0,
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
          ),
          TabBarView(
            controller: _tabController,
            children: <Widget>[
              getAboutContent(),
              getSyllabusContent(),
              getDiscussionsContent(),
            ],
          ),
        ]),
      ),
    );
  }

  getTab(String tabName, int index) {
    return Tab(
      child: Container(
        // width: double.infinity,
        // height: double.infinity,
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

  getFlexiArea() {
    return FlexibleSpaceBar(
      background: Container(
        padding: const EdgeInsets.only(
            left: 16.0, right: 16.0, bottom: 16.0, top: 64.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              ...topSection(),
              const SizedBox(height: 24.0),
              RawMaterialButton(
                onPressed: () {},
                child: AppTitle(
                  text: 'Enroll',
                  fontWeight: FontWeight.normal,
                  size: 18.0,
                ),
                fillColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32.0),
              ),
              ...progressSection()
            ],
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              "https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/course_bg.png?alt=media&",
            ),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  topSection() {
    return [
      Container(
        child: AppTitle(
          text: "Online Master's of Accounting (iMSA)",
          color: const Color(kSecondaryTextColor),
          size: 28.0,
        ),
      ),
      const SizedBox(height: 8.0),
      Container(
        child: AppTitle(
          text:
              "As automation and advancements in technology upend every sector of the economy, accounting students need to learn much more than a CPA’s traditional skill set.",
          color: Colors.white70,
          size: 18.0,
          fontWeight: FontWeight.normal,
        ),
      ),
    ];
  }

  progressSection() {
    return [
      const SizedBox(height: 24.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppText(
              text: 'Progress',
              color: Colors.white60,
              size: 16.0,
            ),
            AppText(
              text: '75.5%',
              color: Color(kAppBackgroundColor),
              size: 16.0,
            ),
          ],
        ),
      ),
      const SizedBox(height: 16.0),
      Container(
        width: double.infinity,
        child: CustomProgressbar(
          inCompleteBarHeight: 5,
          inCompleteValue: MediaQuery.of(context).size.width,
          completeValue: MediaQuery.of(context).size.width * 0.25,
          completeColor: Theme.of(context).primaryColor,
          inCompleteColor: Color(kSecondaryProgressColor),
          completeBarHeight: 10,
        ),
      )
    ];
  }

  /**
   * 
   * TAB BODY AREA
   */

  getAboutContent() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  AppTitle(
                    text:
                        'A cutting-edge accounting master’s from an industry powerhouse, completely online.',
                  ),
                  SizedBox(height: 16.0),
                  AppText(
                    text:
                        'The University of Illinois’ Gies College of Business, consistently ranked among the nation\'s top three accounting programs, now offers a fully online Master of Science in Accounting program with Coursera.',
                  ),
                  SizedBox(height: 16.0),
                  AppTitle(
                    text: 'Your account is now',
                    fontWeight: FontWeight.normal,
                    size: 24.0,
                  ),
                  SizedBox(height: 16.0),
                  AppText(
                    text:
                        'The University of Illinois’ Gies College of Business, consistently ranked among the nation\'s top three accounting programs, now offers a fully online Master of Science in Accounting program with Coursera.',
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getSyllabusContent() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AppText(
                          text: 'Week 1',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.done,
                          color: Color(kPrimaryColor),
                        ),
                      ),
                      AppText(
                        text: '98%',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  AppTitle(
                    text: 'Unit 1: Entering the Job Market',
                    color: Color(kPrimaryColor),
                  ),
                  SizedBox(height: 16.0),
                  AppText(
                    text:
                        'In this unit you will learn about the steps in the job search process.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(kHighlightColorOpac),
                    ),
                    child: AppText(
                      text: '12 videos (Total 49 min)',
                      color: Color(kHighlightColor),
                      size: 16.0,
                    ),
                  )
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 24.0),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: AppText(
                          text: 'Week 1',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Icon(
                          Icons.done,
                          color: Color(kPrimaryColor),
                        ),
                      ),
                      AppText(
                        text: '98%',
                        fontWeight: FontWeight.bold,
                      ),
                    ],
                  ),
                  SizedBox(height: 16.0),
                  AppTitle(
                    text: 'Unit 1: Entering the Job Market',
                    color: Color(kPrimaryColor),
                  ),
                  SizedBox(height: 16.0),
                  AppText(
                    text:
                        'In this unit you will learn about the steps in the job search process.',
                  ),
                  SizedBox(height: 16.0),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      color: Color(kHighlightColorOpac),
                    ),
                    child: AppText(
                      text: '12 videos (Total 49 min)',
                      color: Color(kHighlightColor),
                      size: 16.0,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  getDiscussionsContent() {
    return Container();
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: const Color(kAppBackgroundColor),
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
