import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/games/main-screen.dart';
import 'package:flutter/material.dart';

List playName = [
  {"index": '1', 'name': 'Haylee', 'score': '5,345'},
  {"index": '2', 'name': 'Bob', 'score': '2,945'},
  {"index": '3', 'name': 'Lisa', 'score': '2,423'},
  {"index": '4', 'name': 'Roman', 'score': '1,153'},
  {"index": '5', 'name': 'Andrew', 'score': '738'},
];

class GameOver extends StatelessWidget {
  static const PAGEID = 'game-over';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(kPrimaryColor),
        centerTitle: true,
        title: AppText(
          text: 'Game Over',
          color: Colors.white,
          size: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      bottomNavigationBar: bottomBar(context),
      body: ListView(
        children: <Widget>[
          ...playName.map((f) {
            return gameOverBody(f['index'], f['name'], f['score']);
          }).toList(),
        ],
      ),
    );
  }

  Widget bottomBar(BuildContext context) {
    return Container(
      child: btn(
        text: 'New Game',
        bgClr: Colors.white,
        txtClr: Theme.of(context).primaryColor,
        ontap: () {
          // Navigator.of(context).pushNamed(EmailPinVerification.PAGEID);
        },
      ),
    );
  }

  Widget gameOverBody(String index, String name, String score) {
    return Container(
      decoration: BoxDecoration(
          border: Border(
        bottom: BorderSide(
          width: 1.0,
          color: Color(0x20FFFFFF),
        ),
      )),
      child: ListTile(
        leading: AppText(
          text: index,
          color: Color(0X50FFFFFF),
          size: 25.0,
          fontWeight: FontWeight.bold,
        ),
        title: AppText(
          text: name,
          fontWeight: FontWeight.bold,
          size: 28.0,
          color: Colors.white,
        ),
        trailing: AppText(
          text: score,
          fontWeight: FontWeight.bold,
          size: 28.0,
          color: Colors.white,
        ),
      ),
    );
  }
}
