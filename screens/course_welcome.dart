import 'package:flutter/material.dart';

class CourseWelcomePage extends StatelessWidget {
  static const PAGEID = 'course-welcome-page';

  @override
  Widget build(BuildContext context) {
    // saveWelcomePage();

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/course_welcome.png'),
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
              Image.asset('assets/images/book.png', width: 40.0, height: 35.0),
              SizedBox(
                height: 24,
              ),
              Text(
                'Provides universal access to the world\'s best education',
                style: TextStyle(color: Colors.white, fontSize: 28.0),
              ),
              SizedBox(
                height: 24,
              ),
              Text(
                'Partnering with top universities and organizations to offer courses online.',
                style: TextStyle(color: Colors.white60, fontSize: 24.0),
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
            text: 'Get Started',
            bgClr: Theme.of(context).primaryColor,
            txtClr: Colors.white,
            ontap: () {
              Navigator.of(context).pop();
            },
          ),
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
