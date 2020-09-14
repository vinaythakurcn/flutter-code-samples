import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/custom_switch_listile.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

// enum GameMode { Classic, Team }

class Settings extends StatefulWidget {
  static const PAGEID = 'settings';
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  List<Map<String, dynamic>> gameModeArr = [
    {'image': '', 'name': 'Classic', 'desc': 'Player vs Player\n1:1 Devices'},
    {'image': '', 'name': 'Team Mode', 'desc': 'Team vs Team\nShared Devices'},
  ];

  // GameMode selectedMode = GameMode.Classic;
  int selectedMode = 0;
  bool firstSwitch = true;
  bool secondSwitch = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(kPrimaryColor),
        appBar: AppBar(
          leading: Container(),
          backgroundColor: Color(kPrimaryColor),
          centerTitle: true,
          title: Text(
            'Newsquiz for kids: Sept. 30-Oct 6',
            maxLines: 2,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: mainContainer(ctx: context),
        ));
  }

  mainContainer({BuildContext ctx}) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            gameMode(0),
            gameMode(1),
          ],
        ),
        switchContainer(
            title: 'Enable Player Identifier', switchVal: firstSwitch, isDetails: true),
        switchContainer(
            title: 'Enable Personalized Learning', switchVal: secondSwitch, isDetails: true),
        Container(
          margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: ExpansionTile(
            initiallyExpanded: true,
            title: AppText(
              text: 'Game options',
              size: 18.0,
              fontWeight: FontWeight.bold,
              color: Color(kPrimaryTitleColor),
            ),
            children: <Widget>[
              switchContainer(title: 'Name Generator', switchVal: true, isDetails: true),
              switchContainer(
                  title: 'Randomize Order of Questions', switchVal: false, isDetails: false),
              switchContainer(
                  title: 'Randomize Order of Answers', switchVal: false, isDetails: false),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
    // return Text('Hello');
  }

  Widget switchContainer(
      {@required String title, bool switchVal, bool isDetails}) {
    return Container(
      margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          CustomSwitchListile(
            title: title,
            value: switchVal,
            color: Color(kPrimaryTitleColor),
            fontWeight: FontWeight.bold,
            onTapHandler: (_) {
              setState(() {
                switchVal = !switchVal;
              });
            },
          ),
          isDetails
              ? Container(
                  margin: EdgeInsets.only(left: 15, bottom: 10),
                  child: AppText(
                    text: 'View Details',
                    color: Color(kPrimaryColor),
                    size: 14.0,
                    fontWeight: FontWeight.w600,
                    textAlign: TextAlign.start,
                  ),
                )
              : Container()
        ],
      ),
    );
  }

  Widget gameMode(index) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            selectedMode = index;
          });
          Navigator.of(context).pushNamed('quiz-get-ready');
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 24,
          ),
          margin: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: selectedMode == index
                  ? Color(kAppBackgroundColor)
                  : Color(0x33ffffff)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: selectedMode == index
                        ? Color(0x3356CCF2)
                        : Color(0x80ffffff)),
              ),
              SizedBox(
                height: 10,
              ),
              AppTitle(
                textAlign: TextAlign.center,
                text: gameModeArr[index]['name'],
                size: 18,
                color: selectedMode == index
                    ? Color(kPrimaryColor)
                    : Color(kAppBackgroundColor),
              ),
              SizedBox(
                height: 5,
              ),
              AppText(
                textAlign: TextAlign.center,
                text: gameModeArr[index]['desc'],
                size: 14,
                color: selectedMode == index
                    ? Color(0xff777777)
                    : Color(0x80ffffff),
              )
            ],
          ),
        ),
      ),
    );
  }
}
