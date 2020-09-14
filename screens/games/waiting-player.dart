import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/games/main-screen.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

const List<String> playersName = ['Haylee', 'Bob', 'Lisa', 'Roman', 'Andrew'];

class WaitingPlayer extends StatelessWidget {
  static const PAGEID = "waiting-player";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      appBar: appBarContainer(),
      bottomNavigationBar: btn(
        text: 'Start Game',
        bgClr: Colors.white,
        txtClr: Theme.of(context).primaryColor,
        ontap: () {
          Navigator.of(context).pushNamed('connect-game');
        },
      ),
      body: ListView(
        children: <Widget>[
          gameDetails(),
          ...playersName.map((f) {
            return nameList(f);
          }).toList(),
        ],
      ),
    );
  }
}

Widget nameList(String name) {
  return Container(
    child: AppText(
      text: name,
      textAlign: TextAlign.center,
      size: 28.0,
      color: Colors.white,
    ),
  );
}

Widget gameDetails() {
  return Container(
    color: Color(0X23FFFFFF),
    margin: EdgeInsets.symmetric(vertical: 15),
    padding: EdgeInsets.symmetric(vertical: 10),
    child: ListTile(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          AppText(
            text: 'Join at www.site.com with',
            size: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: 'Game PIN: 178919',
            size: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          )
        ],
      ),
      trailing: IconButton(
        icon: Icon(Icons.screen_share),
        color: Colors.white,
        onPressed: () {
          Share.share('Game PIN: 178919');
        },
      ),
    ),
  );
}

Widget appBarContainer() {
  return AppBar(
    backgroundColor: Color(kPrimaryColor),
    centerTitle: true,
    leading: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppText(
            text: '6',
            size: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            size: 14,
            text: 'Players',
            color: Color(0X60FFFFFF),
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        color: Colors.white,
        onPressed: () {},
      )
    ],
    title: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AppText(
            text: 'Game Name',
            size: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            size: 14,
            text: 'Waiting for players ... ',
            color: Color(0X60FFFFFF),
            fontWeight: FontWeight.normal,
          )
        ],
      ),
    ),
  );
}
