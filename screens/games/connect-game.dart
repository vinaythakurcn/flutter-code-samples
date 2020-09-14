import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class ConnectGame extends StatelessWidget {
  static const PAGEID = "connect-game";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFF7BB74D),
      appBar: appContainer(context),
      bottomNavigationBar: footerContainer(),
      body: connectGame(),
    );
  }
}

Widget connectGame() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: 'You\'re in!',
          color: Colors.white,
          fontWeight: FontWeight.bold,
          size: 45,
        ),
        Container(
          child: AppText(
            text: 'See your nickname on screen?',
            color: Color(0X70FFFFFF),
            fontWeight: FontWeight.w500,
            size: 24,
            textAlign: TextAlign.center,
          ),
        )
      ],
    ),
  );
}

Widget footerContainer() {
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
    ),
  );
}

Widget appContainer(BuildContext context) {
  return AppBar(
    backgroundColor: Color(0XFF7BB74D),
    leading: Container(),
    centerTitle: true,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.close),
        color: Colors.white,
        onPressed: () {
          Navigator.of(context).pushNamed('count-down');
        },
      )
    ],
    title: AppText(
      text: 'PIN 178919',
      color: Colors.white,
      fontWeight: FontWeight.bold,
    ),
  );
}
