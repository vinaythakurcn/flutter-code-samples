import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class MultiQuestions extends StatefulWidget {
  static const PAGEID = 'multi-questions';
  @override
  _MultiQuestionsState createState() => _MultiQuestionsState();
}

class _MultiQuestionsState extends State<MultiQuestions> {
  List<Map<String, dynamic>> trueFalseOption = [
    {
      'label': 'A',
      'option': 'True',
      'isCorrect': false,
      'color': Color(0xFFBB6BD9), //... #BB6BD9,
      'opacColor': Color(0x20BB6BD9)
    },
    {
      'label': 'B',
      'option': 'False',
      'isCorrect': false,
      'color': Color(0xFF2F80ED), //... #BB6BD9,
      'opacColor': Color(0x202F80ED)
    },
  ];

  List<Map<String, dynamic>> quizOptions = [
    {
      'label': 'A',
      'option': 'Squirrels',
      'isCorrect': false,
      'color': Color(0xFFBB6BD9), //... #BB6BD9,
      'opacColor': Color(0x20BB6BD9)
    },
    {
      'label': 'B',
      'option': 'Elk',
      'isCorrect': false,
      'color': Color(0xFF2BB1F3), //... #2BB1F3,
      'opacColor': Color(0x202BB1F3)
    },
    {
      'label': 'C',
      'option': 'Hedgehogs',
      'isCorrect': false,
      'color': Color(0xFFFEC22D), //... #FEC22D,
      'opacColor': Color(0x20FEC22D)
    },
    {
      'label': 'D',
      'option': 'Bever',
      'isCorrect': false,
      'color': Color(0xFF2F80ED), //... #2F80ED,
      'opacColor': Color(0x202F80ED)
    },
  ];

  bool userGivenAns = false;
  int correctAnswer = 1;
  bool correntAnswerStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: userGivenAns && correntAnswerStatus
          ? correctAppBar()
          : userGivenAns && !correntAnswerStatus
              ? wrongAppBar()
              : defaultAppBar(),
      body: quizContainer(),
    );
  }

  Widget wrongAppBar() {
    return AppBar(
      backgroundColor: Color(0XFFE53B3B),
      leading: Container(),
      centerTitle: true,
      title: Column(
        children: <Widget>[
          AppText(
            text: 'Wrong',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          AppText(
            text: 'Trick Question?',
            color: Color(0X70FFFFFF),
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  Widget correctAppBar() {
    return AppBar(
      backgroundColor: Color(0XFF7BB74D),
      leading: Container(),
      centerTitle: true,
      title: Column(
        children: <Widget>[
          AppText(
            text: 'Correct',
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          AppText(
            text: '+908',
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ],
      ),
    );
  }

  Widget defaultAppBar() {
    return AppBar(
      leading: Container(),
      centerTitle: true,
      actions: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(top: 15, right: 10),
            child: AppText(
              text: 'Skip',
              fontWeight: FontWeight.bold,
              color: Color(kPrimaryColor),
            ),
          ),
        )
      ],
      title: Column(
        children: <Widget>[
          AppText(
            text: '1 of 10',
            color: Color(kPrimaryTitleColor),
            fontWeight: FontWeight.bold,
          ),
          AppText(
            text: '12 Answers',
            color: Color(kPrimaryTitleColor),
            fontWeight: FontWeight.normal,
          ),
        ],
      ),
    );
  }

  Widget quizContainer() {
    return ListView(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15, vertical: 20),
              child: AppText(
                text:
                    'In 1989 the United Nations made a human rights law for children called "The Convention on the Rights of the Child',
                fontWeight: FontWeight.w500,
                color: Color(kPrimaryTitleColor),
              ),
            ),
            Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(top: 22),
                  child: Image.network(
                      'https://www.un.org/en/ga/images/featured-image-index-new.jpg',
                      fit: BoxFit.fitWidth,
                      height: 200),
                  // FittedBox(
                  //   fit: BoxFit.fitWidth,
                  //   child: Image.network(
                  //     'https://www.un.org/en/ga/images/featured-image-index-new.jpg',
                  //   ),
                  // ),
                ),
                Positioned(
                  right: 10,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed('rating-page');
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: AppText(
                          text: '21',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: Color(kPrimaryColor),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
              child: getQuizOptions(),
            )
          ],
        ),
      ],
    );
  }

  selectOption(int i) {
    // print(index);
    setState(() {
      quizOptions[0]['isCorrect'] = false;
      quizOptions[1]['isCorrect'] = false;
      quizOptions[2]['isCorrect'] = false;
      quizOptions[3]['isCorrect'] = false;
      quizOptions[i]['isCorrect'] = true;
      userGivenAns = true;
    });
    if (i == correctAnswer) {
      setState(() {
        correntAnswerStatus = true;
        Navigator.of(context).pushNamed('correct-answer');
      });
    } else {
      setState(() {
        correntAnswerStatus = false;
        Navigator.of(context).pushNamed('incorrect-answer');
      });
    }
    // print(quizOptions);
  }

  Widget getQuizOptions() {
    return Container(
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
    ));
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
