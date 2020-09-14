import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

import 'dart:async';

class CountDown extends StatefulWidget {
  static const PAGEID = "count-down";

  @override
  _CountDownState createState() => _CountDownState();
}

class _CountDownState extends State<CountDown> {
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            Navigator.of(context).pushNamed('answers-graph');
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  @override
  void initState() {
    startTimer();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      appBar: AppBar(
        backgroundColor: Color(kPrimaryColor),
        centerTitle: true,
        leading: Container(),
        title: AppText(
          size: 18,
          text: '1 of 10',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: countBodyContainer(context),
    );
  }

  Widget countBodyContainer(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppText(
            text: 'True or False',
            size: 45.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: 'Win up to 1,000 points',
            size: 18,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          SizedBox(
            height: 30,
          ),
          GestureDetector(
            onTap: () {
              // startTimer();
            },
            child: AppText(
              text: _start.toString(),
              size: 144.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          )
        ],
      ),
    );
  }
}
