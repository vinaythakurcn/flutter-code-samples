import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class CorrectAnswer extends StatelessWidget {
  static const PAGEID = 'correct-answer';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF7BB74D),
      appBar: appBarCorrect(),
      bottomNavigationBar: bottomBar(),
      body: correctBodyContainer(),
    );
  }
}

Widget centerContainer() {
  return Column(
    children: <Widget>[
      AppText(
        text: 'Correct',
        size: 45.0,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      Icon(
        Icons.check_circle,
        size: 150.0,
        color: Colors.white,
      ),
      AppText(
        text: 'Answer Streak 1',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        size: 18.0,
      ),
      AppText(
        text: '+718',
        color: Colors.white,
        fontWeight: FontWeight.bold,
        size: 48.0,
      )
    ],
  );
}

Widget correctBodyContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      Container(),
      centerContainer(),
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

Widget bottomBar() {
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

Widget appBarCorrect() {
  return AppBar(
    centerTitle: true,
    backgroundColor: Color(0XFF7BB74D),
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
          text: '1 of 11',
          fontWeight: FontWeight.normal,
          size: 14.0,
          color: Color(0X60FFFFFF),
        )
      ],
    ),
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        onPressed: () {},
        color: Colors.white,
      )
    ],
  );
}
