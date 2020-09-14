import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/games/main-screen.dart';
import 'package:flutter/material.dart';

class NickNamePage extends StatelessWidget {
  static const PAGEID = 'nick-name';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: SafeArea(
        child: bodyContainer(),
      ),
      bottomNavigationBar: Container(
        child: btn(
          text: 'OK, go!',
          bgClr: Colors.white,
          txtClr: Theme.of(context).primaryColor,
          ontap: () {
            Navigator.of(context).pushNamed('waiting-player');
          },
        ),
      ),
    );
  }
}

Widget bodyContainer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: 'Your Name',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 5),
          margin: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0), color: Colors.white),
          child: TextField(
            textAlign: TextAlign.center,
            keyboardType: TextInputType.text,
            style: TextStyle(
                color: Color(kPrimaryColor), fontWeight: FontWeight.normal),
            decoration: InputDecoration(
                border: InputBorder.none, hintText: 'Enter name'),
          ),
        ),
      ],
    ),
  );
}
