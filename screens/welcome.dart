import 'package:education_app/screens/phone-authentication.dart';
import 'package:education_app/testing/cache-testing.dart';
import 'package:education_app/testing/demo-sqlite.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import '../screens/login.dart';
import '../screens/signup.dart';

class WelcomePage extends StatefulWidget {
  static const PAGEID = 'welcome-page';

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final String bodyText =
      'Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown. ';

  @override
  Widget build(BuildContext context) {
    // saveWelcomePage();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/welcome-bg.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[topSection(context), bottomSection(context)],
          ),
        ),
      ),
    );
  }

  Widget topSection(context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(16.0),
          margin: EdgeInsets.only(top: 50.0),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Welcome',
                style: TextStyle(color: Colors.white, fontSize: 28.0),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                bodyText,
                style: TextStyle(color: Colors.white, fontSize: 24.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSection(context) {
    return Container(
      child: Column(
        children: <Widget>[
          btn(
            text: 'Log In',
            bgClr: Theme.of(context).primaryColor,
            txtClr: Colors.white,
            ontap: () {
              // Navigator.of(context).pushNamed(PhoneAuthentication.PAGEID);
              Navigator.of(context).pushNamed(DemoSqlite.PAGEID);
            },
          ),
          // btn(
          //   text: 'Sign Up',
          //   bgClr: Colors.white,
          //   txtClr: Theme.of(context).primaryColor,
          //   ontap: () {
          //     Navigator.of(context).pushNamed(SignupPage.PAGEID);
          //   },
          // ),
        ],
      ),
    );
  }

  Widget btn({text, bgClr, txtClr, ontap}) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 56,
        width: double.infinity,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                color: txtClr, fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
        color: bgClr,
      ),
    );
  }
}
