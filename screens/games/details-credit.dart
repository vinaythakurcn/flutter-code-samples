import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/appbar_iconbtn.dart';
import 'package:education_app/components/custom_flat_button.dart';
import 'package:education_app/components/custom_increment_decrement.dart';
import 'package:education_app/components/custom_progressbar.dart';
import 'package:education_app/components/primary_button.dart';
import 'package:education_app/components/secondary_button.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/games/main-screen.dart';
import 'package:education_app/screens/games/settings.dart';
import 'package:education_app/screens/user-profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:share/share.dart';
import 'package:toast/toast.dart';

final lists = [
  {
    'quiz': 'Cover',
    'name': 'What’s the difference between a feature phone and a smartphone?',
    'link': 'https',
    'lock': false
  },
  {
    'quiz': 'Quiz 1',
    'name': 'What’s the difference between a feature phone and a smartphone?',
    'link': 'https//',
    'lock': false
  },
  {
    'quiz': 'Quiz 2',
    'name': 'What’s the difference between a feature phone and a smartphone?',
    'link': 'https/',
    'lock': true
  },
  {
    'quiz': 'Quiz 3',
    'name': 'What’s the difference between a feature phone and a smartphone?',
    'link': 'https/',
    'lock': true
  },
  {
    'quiz': 'Quiz 4',
    'name': 'What’s the difference between a feature phone and a smartphone?',
    'link': 'https/',
    'lock': true
  },
];

class DetailsCredit extends StatefulWidget {
  static const PAGEID = 'details-credit';
  @override
  _DetailsCreditState createState() => _DetailsCreditState();
}

class _DetailsCreditState extends State<DetailsCredit>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  double linkedInTop;
  double linkedInOpacity = 1.0;
  TabController _tabController;
  var marks = 2;
  static const channel = const MethodChannel('CHANNEL');

  final selectedTabBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 6.0, color: Color(kPrimaryColor)),
    ),
  );

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {});
    });

    linkedInTop = kExpandedHeight - 32;

    _scrollController = ScrollController()
      ..addListener(() {
        double top = kExpandedHeight - _scrollController.offset - 32;

        double newOpacity = ((top * 100) / (kExpandedHeight - 32)) / 100;

        linkedInOpacity =
            newOpacity > 1 ? 1 : (newOpacity < 0 ? 0 : newOpacity);

        if (top > 64) {
          linkedInTop = top;
        } else {
          linkedInTop = 0;
          linkedInOpacity = 0.0;
        }

        // _showLargeTitle = top > 80;

        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  bool get _showTitle {
    return _scrollController.hasClients &&
        _scrollController.offset > kExpandedHeight - 80;
  }

  Widget getPlaysFavourite(String value, String title) {
    return Expanded(
      flex: 1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppTitle(
            text: value,
            color: const Color(kSecondaryBackgroundColor),
            size: 20.0,
            fontWeight: FontWeight.w500,
          ),
          AppText(
            text: title,
            color: const Color(kSecondaryBackgroundColor),
            fontWeight: FontWeight.normal,
            size: 13.0,
          ),
        ],
      ),
    );
  }

  Widget getFullTitle() {
    return Row(
      // mainAxisSize: MainAxisSize.min,
      // mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        getPlaysFavourite('141362', 'Plays'),
        getPlaysFavourite('1435', 'Favorites'),
        getPlaysFavourite('11', 'Questions'),
      ],
    );
  }

  Widget getShortTitle() {
    return AppText(
      text: '',
      fontWeight: FontWeight.bold,
    );
  }

  Widget getSliverAppBar() {
    return SliverAppBar(
      // backgroundColor: Colors.transparent,
      expandedHeight: kExpandedHeight,
      pinned: false,
      floating: false,
      flexibleSpace: FlexibleSpaceBar(
        // centerTitle: _showTitle ? true : false,
        // titlePadding:
        //     _showTitle ? null : EdgeInsets.only(left: 24.0, bottom: 24.0),
        // title: _showTitle ? getShortTitle() : getFullTitle(),
        title: getFullTitle(),
        background: Image.network(
          "https://www.geneve.com/-/media/geneva/assets/restimporter/attractions/61236_web_1280x960.jpg",
          fit: BoxFit.cover,
        ),
      ),
      // actions: <Widget>[],
      leading: AppBarIconButton(
        icon: Icons.keyboard_arrow_down,
        color: Colors.white,
        iconSize: 30,
        onPressed: () {
          // Navigator.of(context).pushNamed(EditProfile.PAGEID);
        },
      ),
      actions: <Widget>[
        AppBarIconButton(
          icon: CupertinoIcons.share_up,
          color: Colors.white,
          iconSize: 30,
          onPressed: () {
            // Share.share('Demo text for social sharing...');
            showShareBottomSheet();
          },
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      body: SafeArea(
        child: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              getSliverAppBar(),
              SliverList(
                delegate: SliverChildListDelegate([
                  Container(
                    margin: EdgeInsets.all(30),
                    child: Center(
                      child: AppText(
                        text: 'The frightening History of Halloween in America',
                        color: Color(kPrimaryTitleColor),
                        fontWeight: FontWeight.bold,
                        size: 28.0,
                      ),
                    ),
                  ),
                ]),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    indicator: selectedTabBorder,
                    tabs: [
                      getTab('Description', 0),
                      getTab('Game', 1),
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
                getDescriptionContent(),
                getGameContent(),
              ],
            ),
          ]),
          // slivers: <Widget>[
          //   getSliverAppBar(),
          //   getSliverList(),
          //   // titleText('The frightening History of Halloween in America'),
          // ],
        ),
      ),
    );
  }

  getDescriptionContent() {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: AppText(
                text:
                    'There should should also a edit button somewhere for users to edit profile if they are viewing there own profile',
                color: Color(kAccentColor),
                fontWeight: FontWeight.normal,
                size: 14.0,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: PrimaryButton(
                text: 'Play',
                handler: actionSheet,
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: AppText(
                text: 'Sample Questions',
                fontWeight: FontWeight.w500,
                size: 24.0,
                color: Color(kPrimaryTitleColor),
              ),
            ),
            getSampleQuestions(
                'Halloween was more common in the southern colonies'),
            getSampleQuestions(
                'Why was the celebration of Halloween incredibly limited in New England?'),
            getSampleQuestions(
                'What was different about the developing American colonial'),
            getExpantion(),
          ],
        ),
      ),
    );
  }

  void actionSheet() {
    const sheetShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    );

    showModalBottomSheet(
        shape: sheetShape,
        backgroundColor: Color(kPrimaryColor),
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (BuildContext context,
              StateSetter
                  setModalState /* Rename it to setState will sets parent widget state */) {
            return Container(
              height: 350,
              child: Container(
                padding: EdgeInsets.only(top: 10),
                // margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    AppText(
                      text: 'Play',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      size: 28,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          getPlayOptions(Colors.white, 'Host Live Game',
                              Color(kPrimaryColor), Color(0XFFDDF5Fc)),
                          getPlayOptions(Colors.transparent, 'Play Live Group',
                              Colors.white, Color(0XFF55C1Fc)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: BorderSide(
                              width: 1.0, color: Color(0xFFFFFFFFFF)),
                        ),
                      ),
                      // margin: EdgeInsets.symmetric(vertical: 15),
                      child: CustomIncrementDecrement(
                        title: 'Player limit per game',
                        value: marks.toString(),
                        onIncrease: () {
                          setModalState(() {
                            marks++;
                          });
                        },
                        onDecrease: () {
                          setModalState(() {
                            marks--;
                          });
                        },
                      ),
                    ),
                    btn(
                      text: 'Pratice',
                      bgClr: Colors.white,
                      txtClr: Theme.of(context).primaryColor,
                      ontap: () {
                        Navigator.pop(context);
                        Navigator.of(context).pushNamed('settings');
                        // Navigator.of(context).pushNamed('nick-name');
                      },
                    ),
                  ],
                ),
              ),
            );
          });
        });
  }

  Widget getPlayOptions(
      Color container, String text, Color textColor, Color circleColor) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pop();
        Navigator.pushNamed(context, 'subscription-plan');
      },
      child: Container(
        height: 130,
        width: MediaQuery.of(context).size.width * 0.35,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.0),
          color: container,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20), color: circleColor),
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              text: text,
              textAlign: TextAlign.center,
              color: textColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget getList() {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.call),
          title: Text('Call'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(Icons.message),
          title: Text('Message'),
          onTap: () => Navigator.pop(context),
        ),
        ListTile(
          leading: Icon(Icons.close),
          title: Text('Cancel'),
          onTap: () => Navigator.pop(context),
        )
      ],
    );
  }

  Widget getExpantion() {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: ExpansionTile(
        initiallyExpanded: true,
        title: AppText(
          text: 'Credits',
          size: 24.0,
          fontWeight: FontWeight.w500,
          color: Color(kPrimaryTitleColor),
        ),
        children: <Widget>[
          // for(var i = 0; i < lists.length; i++) {
          //   expantionChildren(lists[i]['quiz'], lists[i]['name'], lists[i]['link'])
          // },
          expantionChildren('Cover', 'Giammarco Boscaro',
              'https://unsplash.com/photos/I_LgQ'),
          expantionChildren('Cover', 'Giammarco Boscaro',
              'https://unsplash.com/photos/I_LgQ'),
        ],
      ),
    );
  }

  Widget expantionChildren(String quiz, String name, String link) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1.0, color: Color(0xFFF0F0F0)),
        ),
      ),
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            AppText(
              text: quiz,
              color: Color(kPrimaryTitleColor),
              size: 18.0,
              fontWeight: FontWeight.bold,
            ),
            SizedBox(
              height: 10,
            ),
            AppText(
              text: name,
              color: Color(kPrimaryTextColor),
              size: 14.0,
              fontWeight: FontWeight.normal,
            ),
            AppText(
              text: link,
              color: Color(kPrimaryTextColor),
              size: 14.0,
              fontWeight: FontWeight.normal,
            )
          ],
        ),
      ),
    );
  }

  Widget getSampleQuestions(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            width: 100,
            height: 90,
            child: GestureDetector(
              onTap: () {},
              child: ClipRRect(
                borderRadius: new BorderRadius.circular(8.0),
                child: Image.network(
                  'https://www.viewbug.com/media/mediafiles/2016/05/02/65792595_medium.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: AppText(
              text: text,
              fontWeight: FontWeight.bold,
              size: 18.0,
              color: Color(kPrimaryColor),
            ),
          ),
        ],
      ),
    );
  }

  getGameContent() {
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        GridView.builder(
            shrinkWrap: true,
            primary: false,
            padding: const EdgeInsets.all(20),
            itemCount: lists.length,
            gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3),
            itemBuilder: (BuildContext context, int index) {
              return new Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: lists[index]['lock']
                      ? Color(kHighlightColor)
                      : Color(kPrimaryColor),
                ),
                margin: EdgeInsets.all(5),
                alignment: Alignment.center,
                child: lists[index]['lock']
                    ? Icon(Icons.lock)
                    : AppText(
                        text: (index + 1).toString(),
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
              );
            }),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 25.0),
          child: AppText(
            text: 'Leaderboard',
            size: 18.0,
            fontWeight: FontWeight.bold,
            color: Color(kPrimaryTitleColor),
          ),
        ),
        ...progressSection('1. Robyn', '1836', 0.60),
        ...progressSection('2. Nancy', '1216', 0.40),
        ...progressSection('2. Test', '955', 0.20),
      ],
    );
  }

  progressSection(String name, String value, double percentage) {
    return [
      const SizedBox(height: 24.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            AppText(
              text: name,
              color: Color(kAccentColor),
              size: 16.0,
            ),
            AppText(
              text: value,
              color: Color(kPrimaryColor),
              size: 16.0,
            ),
          ],
        ),
      ),
      const SizedBox(height: 16.0),
      Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        width: double.infinity,
        child: CustomProgressbar(
          inCompleteBarHeight: 5,
          inCompleteValue: MediaQuery.of(context).size.width,
          completeValue: MediaQuery.of(context).size.width * percentage,
          completeColor: Theme.of(context).primaryColor,
          inCompleteColor: Color(kAccentColor),
          completeBarHeight: 8,
        ),
      )
    ];
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
              size: 24.0,
              color: _tabController.index == index
                  ? const Color(kPrimaryColor)
                  : Color(kPrimaryTitleColor),
              fontWeight: _tabController.index == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }

  Widget getTabController() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        TabBar(
          controller: _tabController,
          indicator: selectedTabBorder,
          // isScrollable: true,
          tabs: [
            getTab('Description', 0),
            getTab('Game', 1),
          ],
        ),
        // getTabView(),
      ],
    );
  }

  Widget getSliverList() {
    return SliverList(
      delegate: SliverChildListDelegate([
        Container(
          margin: EdgeInsets.all(30),
          child: Center(
            child: AppText(
              text: 'The frightening History of Halloween in America',
              color: Color(kPrimaryTitleColor),
              fontWeight: FontWeight.bold,
              size: 28.0,
            ),
          ),
        ),
        getTabController(),
      ]),
    );
  }

  Widget listArr() {
    return SliverFixedExtentList(
      itemExtent: 50.0,
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return Container(
            alignment: Alignment.center,
            color: Colors.lightBlue[100 * (index % 9)],
            child: Text('List Item $index'),
          );
        },
      ),
    );
  }

  showShareBottomSheet() {
    const sheetShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    );
    showModalBottomSheet(
        shape: sheetShape,
        context: context,
        backgroundColor: Colors.white,
        builder: (context) {
          return SingleChildScrollView(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 15.0, right: 15.0, top: 5.0),
                    child: Column(
                      children: <Widget>[
                        AppText(
                          text: 'Share Game',
                          color: Color(kPrimaryTitleColor),
                          size: 28.0,
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                        ),
                        AppText(
                          text:
                              'Make sure to invite other players to your challenge!',
                          color: Color(0X404C4C4C),
                          fontWeight: FontWeight.bold,
                          textAlign: TextAlign.center,
                          size: 18.0,
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.75,
                    margin: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/images/WhatsApp.png'),
                              onPressed: () {
                                shareContent("com.whatsapp");
                              },
                              tooltip: 'Share to WhatsApp',
                              iconSize: 50.0,
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'assets/images/facebook_icon.png'),
                              onPressed: () {
                                shareContent("com.facebook.katana");
                              },
                              tooltip: 'Share to Facebook',
                              iconSize: 50.0,
                            ),
                            IconButton(
                              icon: Image.asset(
                                  'assets/images/facebook_messenger.png'),
                              onPressed: () {
                                shareContent("com.facebook.orca");
                              },
                              tooltip: 'Share to Messenger',
                              iconSize: 50.0,
                            )
                          ],
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: <Widget>[
                            IconButton(
                              icon: Image.asset('assets/images/mail.png'),
                              onPressed: () {
                                shareContent('com.google.android.gm');
                              },
                              tooltip: 'Share via mail',
                              iconSize: 50.0,
                            ),
                            IconButton(
                              icon:
                                  Image.asset('assets/images/twitter_icon.png'),
                              onPressed: () {
                                shareContent('com.twitter.android');
                              },
                              tooltip: 'Share to twitter',
                              iconSize: 50.0,
                            ),
                            IconButton(
                              icon: Image.asset('assets/images/link_icon.png'),
                              onPressed: () {
                                Navigator.pop(context);
                                Share.share('Demo text for social sharing...');
                              },
                              tooltip: 'Share to other platform',
                              iconSize: 50.0,
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        border: Border(
                      top: BorderSide(
                        width: 1.0,
                        color: Color(0xFFF0F0F0),
                      ),
                    )),
                    child: btn(
                        bgClr: Colors.transparent,
                        text: 'Done',
                        txtClr: Color(kPrimaryColor),
                        ontap: () {
                          Navigator.of(context).pop();
                        }),
                  )
                ],
              ),
            ),
          );
        });
  }

  Future<void> shareContent(String package) async {
    Navigator.pop(context);
    String response;
    try {
      var result = await channel
          .invokeMethod('shareContentData', {"packageName": package});
      response = result;
      print('share data =>>>>>>>>> $result');
      if (result == "0") {
        Toast.show("App not installed.", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } on PlatformException catch (e) {
      response = 'An error occuried: ${e.message}';
    }
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
