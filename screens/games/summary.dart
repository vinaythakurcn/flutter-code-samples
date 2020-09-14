import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/custom_progressbar.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class SummaryQuiz extends StatefulWidget {
  static const PAGEID = 'summary-quiz';
  @override
  _SummaryQuizState createState() => _SummaryQuizState();
}

class _SummaryQuizState extends State<SummaryQuiz>
    with SingleTickerProviderStateMixin {
  final List<Map<String, dynamic>> checkOptions = [
    {
      "columnName": "A",
      "answerKey": "Bever",
      "checked": false,
      "backColor": Color(0xFFBB6BD9)
    },
    {
      "columnName": "B",
      "answerKey": "Elk",
      "checked": false,
      "backColor": Color(0xFF2BB1F3)
    },
    {
      "columnName": "C",
      "answerKey": "Squirrels",
      "checked": false,
      "backColor": Color(0xFFFEC22D)
    },
    {
      "columnName": "D",
      "answerKey": "Hedgehogs",
      "checked": true,
      "backColor": Color(0xFF2F80ED)
    }
  ];
  TabController _tabController;
  final selectedTabBorder = BoxDecoration(
    border: Border(
      bottom: BorderSide(width: 6.0, color: Colors.white),
    ),
  );

  @override
  void initState() {
    _tabController = TabController(vsync: this, length: 2);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      bottomNavigationBar: btn(
          text: 'Next',
          bgClr: Colors.white,
          txtClr: Color(kPrimaryColor),
          ontap: () {}),
      appBar: AppBar(
        leading: Container(),
        backgroundColor: Color(kPrimaryColor),
        centerTitle: true,
        title: Text(
          'The frightening History of Halloween in America',
          maxLines: 2,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18.0),
        ),
        bottom: getTabController(),
      ),
      body: SafeArea(
        child: TabBarView(
          controller: _tabController,
          children: <Widget>[
            reportSection(),
            answerSection(),
          ],
        ),
      ),
    );
  }

  answerSection() {
    return ListView(
      children: <Widget>[
        answerContainer(
            headerName: 'Quiz 1',
            questions: 'The first month of fall is',
            answerType: 1),
        answerContainer(
            headerName: 'True or False 2',
            questions:
                'In the fall you turn your clock back (and gain an hour)',
            answerType: 2),
        answerContainer(
            headerName: 'Quiz 3',
            questions: 'Which of these animals hibernate?',
            answerType: 3),
      ],
    );
  }

  answerContainer({String headerName, String questions, int answerType}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(16.0)),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: AppText(
              text: headerName,
              color: Color(kPrimaryTitleColor),
              fontWeight: FontWeight.bold,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Color(kPrimaryTextColor),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  width: 120.0,
                  height: 90.0,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1507842217343-583bb7270b66?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80')),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    color: Colors.redAccent,
                  ),
                ),
                Container(
                  child: Expanded(
                    child: AppText(
                      text: questions,
                      color: Color(kPrimaryColor),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              ],
            ),
          ),
          answerType == 1
              ? answeredView()
              : answerType == 2 ? noAnswerView() : allAnswerView()
        ],
      ),
    );
  }

  optionsView(res) {
    return Container(
      child: ListTile(
        leading: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: res['backColor'],
          ),
          child: Center(
            child: AppText(
              text: res['columnName'],
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: AppText(
          text: res['answerKey'],
          color: Color(kPrimaryTitleColor),
          fontWeight: FontWeight.bold,
        ),
        trailing: res['checked']
            ? Icon(
                Icons.check,
                color: Color(0XFF2BB1F3),
              )
            : null,
      ),
    );
  }

  allAnswerView() {
    return Container(
        child: Column(
      children: <Widget>[
        noAnswerView(),
        ...checkOptions.map((el) {
          return optionsView(el);
        }).toList()
      ],
    ));
  }

  noAnswerView() {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Color(0X20869DA7), borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        title: AppText(
          text: "You didn't answer",
          color: Color(kPrimaryTitleColor),
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  answeredView() {
    return Container(
      margin: EdgeInsets.all(15.0),
      decoration: BoxDecoration(
          color: Color(0XFFE53B3B), borderRadius: BorderRadius.circular(16.0)),
      child: ListTile(
        title: AppText(
          text: 'November',
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(Icons.close),
          color: Colors.white,
        ),
      ),
    );
  }

  reportSection() {
    return Column(
      children: <Widget>[
        progressSection('1', 'Haylee', '1746', 0.8, false),
        progressSection('2', 'Bob', '1265', 0.6, false),
        progressSection('3', 'Lisa', '935', 0.5, false),
        progressSection('4', 'Roman', '735', 0.4, true),
        progressSection('5', 'Andrew', '384', 0.2, false),
      ],
    );
  }

  progressSection(String index, String name, String value, double percentage,
      bool currentUser) {
    return Container(
      margin: EdgeInsets.only(top: 15),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10),
            width: 30,
            height: 30,
            decoration: BoxDecoration(
                color: currentUser ? Colors.white : Color(0X20FFFFFF),
                borderRadius: BorderRadius.circular(15)),
            child: Center(
              child: AppText(
                text: index,
                color: currentUser ? Color(kPrimaryColor) : Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        AppText(
                          text: name,
                          color: Colors.white,
                          size: 16.0,
                        ),
                        AppText(
                          text: value,
                          color: Colors.white,
                          size: 16.0,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    // width: double.infinity,
                    child: CustomProgressbar(
                      inCompleteBarHeight: 5,
                      inCompleteValue:
                          (MediaQuery.of(context).size.width - 100),
                      completeValue: (MediaQuery.of(context).size.width - 100) *
                          percentage,
                      completeColor:
                          currentUser ? Color(0XFFFEC22D) : Colors.white,
                      inCompleteColor: Color(0X20FFFFFF),
                      completeBarHeight: 8,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget getTabController() {
    return TabBar(
      controller: _tabController,
      indicator: selectedTabBorder,
      // isScrollable: true,
      tabs: [
        getTab('Report', 0),
        getTab('My Answers', 1),
      ],
    );
  }

  getTab(String tabName, int index) {
    return Tab(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: FittedBox(
            child: AppText(
              text: tabName,
              size: 24.0,
              color: _tabController.index == index
                  ? const Color(0XFFFFFFFF)
                  : Color(0X60FFFFFF),
              fontWeight: _tabController.index == index
                  ? FontWeight.bold
                  : FontWeight.normal,
            ),
          ),
        ),
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
