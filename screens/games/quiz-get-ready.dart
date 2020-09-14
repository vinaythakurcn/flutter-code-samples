import 'package:education_app/components/app_loader.dart';
import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class QuizGetReady extends StatelessWidget {
  static const PAGEID = 'quiz-get-ready';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      appBar: AppBar(
        backgroundColor: Color(kPrimaryColor),
        leading: Container(),
        title: AppText(
          text: 'PIN 50279',
          color: Colors.white,
          size: 16.0,
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            color: Colors.white,
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: InkWell(
            onTap: () {
              Navigator.of(context).pushNamed('multi-questions');
            },          
                  child: ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://pixinvent.com/materialize-material-design-admin-template/app-assets/images/user/12.jpg'),
            ),
            title: AppText(
              text: 'Haylee Powers',
              color: Color(kPrimaryTitleColor),
              fontWeight: FontWeight.bold,
            ),
            trailing: AppText(
              text: '0',
              color: Color(kPrimaryColor),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: bottomContainer(),
    );
  }
}

Widget bottomContainer() {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        AppText(
          text: 'Get Ready!',
          color: Colors.white,
          size: 40.0,
          fontWeight: FontWeight.bold,
        ),
        SizedBox(height: 15),
        SizedBox(
          width: 80,
          height: 80,
          child: AppLoader(
            inAsyncCall: true,
            child: Container(),

          )
        ),
        SizedBox(
          height: 15,
        ),
        AppText(
          text: 'Loading...',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )
      ],
    ),
  );
}
