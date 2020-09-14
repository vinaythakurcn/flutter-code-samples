import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class RatingPage extends StatefulWidget {
  static const PAGEID = 'rating-page';
  @override
  _RatingPageState createState() => _RatingPageState();
}

class _RatingPageState extends State<RatingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      appBar: AppBar(
        backgroundColor: Color(kPrimaryColor),
        leading: Container(),
        centerTitle: true,
        title: AppText(
          size: 18.0,
          text: 'Podium',
          color: Colors.white,
        ),
      ),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              barContainer(),
              SizedBox(
                height: 10,
              ),
              pointContainer(),
              SizedBox(
                height: 10,
              ),
              totalPointContainer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget barContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        getbar(name: 'Bob', value: 100),
        getbar(name: 'Haylee ', value: 250),
        getbar(name: 'Lisa', value: 175),
      ],
    );
  }

  Widget getbar({String name, double value}) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('summary-quiz');
      },
          child: Column(
        children: <Widget>[
          AppText(
            text: name,
            color: Colors.white,
            fontWeight: FontWeight.bold,
            size: 18.0,
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            height: value,
            width: 80,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
          )
        ],
      ),
    );
  }

  Widget totalPointContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        ...[0, 1, 2].map((f) {
          return AppText(
            text: '3 out of 10',
            fontWeight: FontWeight.normal,
            color: Color(0X80FFFFFF),
            size: 14.0,
          );
        }).toList(),
      ],
    );
  }

  Widget pointContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        getPoints(point: '2,954'),
        getPoints(point: '5,345'),
        getPoints(point: '2,423'),
      ],
    );
  }

  Widget getPoints({@required String point}) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        AppText(
          text: point,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          size: 18.0,
        ),
        AppText(
          text: 'Points',
          fontWeight: FontWeight.normal,
          color: Color(0X80FFFFFF),
          size: 14.0,
        ),
      ],
    );
  }
}
