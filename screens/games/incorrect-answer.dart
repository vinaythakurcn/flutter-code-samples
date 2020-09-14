import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class IncorrectAnswer extends StatelessWidget {
  static const PAGEID = "incorrect-answer";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE53B3B),
      appBar: appBarInCorrect(),
      bottomNavigationBar: bottomIncorrectBar(),
      body: inCorrectBodyContainer(),
    );
  }
}

Widget inCorrectBodyContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(),
      inCenterContainer(),
      Container(
        margin: EdgeInsets.only(bottom: 15.0),
        child: AppText(
          text: "You're in 1st place",
          color: Colors.white,
          size: 18.0,
          fontWeight: FontWeight.bold,
          textAlign: TextAlign.center,
        ),
      )
    ],
  );
}

Widget inCenterContainer() {
  return Column(
    children: <Widget>[
      AppText(
        text: 'Incorrect',
        size: 45.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      Icon(
        Icons.cancel,
        size: 150.0,
        color: Colors.white,
      ),
      AppText(
        text: 'Answer Streak Lost',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        size: 18.0,
      ),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 30, vertical: 5),
        child: AppText(
          text: 'Dust yourself off. Greatness awaits!',
          color: Color(0X70FFFFFF),
          textAlign: TextAlign.center,
          fontWeight: FontWeight.normal,
          size: 18.0,
        ),
      )
    ],
  );
}

Widget bottomIncorrectBar() {
  return Container(
    color: Colors.white,
    child: ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
            'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg'),
      ),
      title: AppText(
        text: 'Haylee Powers',
        color: Color(kPrimaryTitleColor),
        size: 18.0,
        fontWeight: FontWeight.bold,
      ),
      trailing: AppText(
        text: '746',
        color: Color(kPrimaryColor),
        fontWeight: FontWeight.bold,
        size: 18.0,
      ),
    ),
  );
}

Widget appBarInCorrect() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Color(0XFFE53B3B),
    leading: Container(),
    title: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: 'PIN 50279',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 18.0,
        ),
        AppText(
          text: '2 of 11',
          fontWeight: FontWeight.normal,
          size: 14.0,
          color: Color(0X60FFFFFF),
        )
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          // Navigator.pop(context);
        },
        color: Colors.white,
      )
    ],
  );
}
