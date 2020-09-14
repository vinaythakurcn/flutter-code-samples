import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class AnswerGraph extends StatefulWidget {
  static const PAGEID = "answers-graph";
  @override
  _AnswerGraphState createState() => _AnswerGraphState();
}

class _AnswerGraphState extends State<AnswerGraph> {
  List<Map<String, dynamic>> quizOptions = [
    {
      'label': 'A',
      'option': 'Disney World',
      'isCorrect': false,
      'color': Color(0xFFBB6BD9), //... #BB6BD9,
      'opacColor': Color(0x20BB6BD9)
    },
    {
      'label': 'B',
      'option': 'Universal Studios',
      'isCorrect': false,
      'color': Color(0xFF2BB1F3), //... #2BB1F3,
      'opacColor': Color(0x202BB1F3)
    },
    {
      'label': 'C',
      'option': 'Busch',
      'isCorrect': false,
      'color': Color(0xFFFEC22D), //... #FEC22D,
      'opacColor': Color(0x20FEC22D)
    },
    {
      'label': 'D',
      'option': 'Six Flags',
      'isCorrect': false,
      'color': Color(0xFF2F80ED), //... #2F80ED,
      'opacColor': Color(0x202F80ED)
    },
  ];

  bool userGivenAns = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: answerAppBar(),
      body: answerBodyContainer(),
    );
  }

  answerBodyContainer() {
    return ListView(
      children: <Widget>[
        Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: AppText(
            text:
                'The Haunted Mansion is a movie starring Eddie Murphy and is based.',
            color: Color(kPrimaryTitleColor),
            fontWeight: FontWeight.w500,
            size: 20.0,
          ),
        ),
        SizedBox(
          height: 15,
        ),
        barContainer(),
        SizedBox(
          height: 5,
        ),
        barlevelContainer(),
        getQuizOptions(),
      ],
    );
  }

  Widget barlevelContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        barLevel(
          title: 'A',
          barColor: Color(0XFFBB6BD9),
        ),
        barLevel(
          title: 'B',
          barColor: Color(0XFF2BB1F3),
        ),
        barLevel(
          title: 'C',
          barColor: Color(0XFFFEC22D),
        ),
        barLevel(
          title: 'D',
          barColor: Color(0XFF2F80ED),
        )
      ],
    );
  }

  Widget barLevel({String title, Color barColor}) {
    return Container(
      height: 40,
      width: 65,
      decoration: BoxDecoration(
        color: barColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: AppText(
          text: title,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget barContainer() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        getbar(name: '120', value: 160, barcolor: Color(0XFFBB6BD9)),
        getbar(name: '5 ', value: 0, barcolor: Color(0XFF2BB1F3)),
        getbar(name: '6', value: 0, barcolor: Color(0XFFFEC22D)),
        getbar(name: '3', value: 0, barcolor: Color(0XFF2F80ED)),
      ],
    );
  }

  Widget getbar({String name, double value, Color barcolor}) {
    return Column(
      children: <Widget>[
        AppText(
          text: name,
          color: barcolor,
          fontWeight: FontWeight.bold,
          size: 18.0,
        ),
        SizedBox(
          height: 5,
        ),
        Container(
          height: value,
          width: 65,
          decoration: BoxDecoration(
              color: barcolor, borderRadius: BorderRadius.circular(8.0)),
        )
      ],
    );
  }

  Widget answerAppBar() {
    return AppBar(
      centerTitle: true,
      leading: Container(),
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          AppText(
            text: '1 of 10',
            color: Color(kPrimaryTitleColor),
            size: 18.0,
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: '1 answer',
            color: Color(0X604C4C4C),
            size: 14.0,
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
      actions: <Widget>[
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, 'game-over');
          },
          child: Container(
            margin: EdgeInsets.only(top: 15, right: 10),
            child: AppText(
              text: 'Next',
              size: 18.0,
              color: Color(kPrimaryColor),
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }

  Widget getQuizOptions() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              getQuizOption(0, () {
                selectOption(0);
              }),
              getQuizOption(1, () {
                selectOption(1);
              }),
            ],
          ),
          Row(
            children: <Widget>[
              getQuizOption(2, () {
                selectOption(2);
              }),
              getQuizOption(3, () {
                selectOption(3);
              }),
            ],
          ),
        ],
      ),
    );
  }

  selectOption(int i) {
    setState(() {
      quizOptions[0]['isCorrect'] = false;
      quizOptions[1]['isCorrect'] = false;
      quizOptions[2]['isCorrect'] = false;
      quizOptions[3]['isCorrect'] = false;
      quizOptions[i]['isCorrect'] = true;
      userGivenAns = true;
    });
  }

  Widget getQuizOption(int i, Function handler) {
    return Expanded(
      child: InkWell(
        onTap: handler,
        child: Container(
          child: Card(
              color: userGivenAns && !quizOptions[i]['isCorrect']
                  ? quizOptions[i]['opacColor']
                  : quizOptions[i]['color'],
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: AppTitle(
                      text: quizOptions[i]['label'],
                      size: 18,
                      color: Color(kAppBackgroundColor),
                    ),
                    top: 8,
                    left: 8,
                  ),
                  quizOptions[i]['isCorrect']
                      ? Positioned(
                          child: Icon(
                            Icons.check_circle,
                            color: const Color(kAppBackgroundColor),
                            // size: 16,
                          ),
                          top: 8,
                          right: 8,
                        )
                      : Container(),
                  Center(
                    child: AppTitle(
                      text: quizOptions[i]['option'],
                      size: 18,
                      textAlign: TextAlign.center,
                      color: Color(kAppBackgroundColor),
                    ),
                  ),
                ],
              )),
          height: 100,
        ),
      ),
    );
  }
}
