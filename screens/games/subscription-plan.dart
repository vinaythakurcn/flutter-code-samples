import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/custom_image_slider.dart';
import 'package:education_app/components/primary_button.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

List<String> firstPlanDescription = [
  'Everything in Pro',
  'Great match for events and conferences',
  'Additional support'
];

List<String> secondPlanDescription = [
  'Everything in Pro',
  'Create training content with slides',
  'Add poll questions to gather feedback'
];

List<String> thirdPlanDescription = [
  'Create, play and share quizzes',
  'Host games instead of giving',
  'Assign challenges for virtual training'
];

class SubscriptionPlan extends StatefulWidget {
  static const PAGEID = 'subscription-plan';
  @override
  _SubscriptionPlanState createState() => _SubscriptionPlanState();
}

class _SubscriptionPlanState extends State<SubscriptionPlan> {
  PageController _pageController = PageController(viewportFraction: 0.8);
  Color appBarColor = Color(kPrimaryColor);
  String appBarText = 'Premium';
  int selectedPage = 0;

  @override
  void initState() {
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  Widget bulletContainer(String text) {
    return Container(
      margin: EdgeInsets.only(left: 12, right: 12, top: 5),
      width: double.infinity,
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            width: 12,
            height: 12,
            margin: EdgeInsets.only(top: 6, left: 15),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color(kAccentColor)),
          ),
          SizedBox(
            width: 10,
            height: 30,
          ),
          Expanded(
            child: AppText(
              text: text,
              color: Color(kAccentColor),
              size: 16.0,
              fontWeight: FontWeight.normal,
            ),
          )
        ],
      ),
    );
  }

  Widget planView(
      {@required Color bodyBackground,
      @required String price,
      @required Color circleColor,
      @required List<String> descriptionList,
      @required String noOfPlayer}) {
    return Container(
      color: bodyBackground,
      child: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: 430,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white),
                  margin: EdgeInsets.only(top: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(),
                      Container(
                        margin: EdgeInsets.only(top: 30),
                        child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            AppText(
                              size: 18.0,
                              text: "From",
                              color: Color(kAccentColor),
                              fontWeight: FontWeight.normal,
                            ),
                            AppText(
                              text: '\$$price / mo',
                              color: Color(kPrimaryColor),
                              fontWeight: FontWeight.bold,
                              size: 26.0,
                            ),
                            Container(
                              margin:
                                  EdgeInsets.only(top: 20, left: 20, right: 20),
                              width: double.infinity,
                              child: AppText(
                                size: 26.0,
                                text: "$noOfPlayer players per game",
                                color: Color(kPrimaryTitleColor),
                                fontWeight: FontWeight.bold,
                                textAlign: TextAlign.start,
                              ),
                            ),
                            ...descriptionList.map((f) {
                              return bulletContainer(f);
                            }).toList(),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(15.0),
                        child: PrimaryButton(
                          text: 'Learn More',
                          handler: () {},
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: circleColor,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onPageChanged(int value) {
    print('*************<><><><><><>>>>>>>>>>>><><>>> $value');
    if (value == 0) {
      setState(() {
        appBarColor = Color(kPrimaryColor);
        appBarText = 'Premium';
        selectedPage = value;
      });
    }
    if (value == 1) {
      setState(() {
        appBarColor = Color(0XFFFEC22D);
        appBarText = 'Pro';
        selectedPage = value;
      });
    }
    if (value == 2) {
      setState(() {
        appBarColor = Color(0XFF869DA7);
        appBarText = 'Plus';
        selectedPage = value;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appBarColor,
      bottomNavigationBar: bottomBar(),
      appBar: AppBar(
        backgroundColor: appBarColor,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.white,
        ),
        title: AppText(
          text: appBarText,
          size: 18.0,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
              height: 530,
              child: PageView(
                onPageChanged: onPageChanged,
                controller: _pageController,
                // physics: new AlwaysScrollableScrollPhysics(),
                children: <Widget>[
                  planView(
                      bodyBackground: Color(kPrimaryColor),
                      price: '37.40',
                      circleColor: Color(0XFFFEC22D),
                      descriptionList: firstPlanDescription,
                      noOfPlayer: '20'),
                  planView(
                      bodyBackground: Color(0XFFFEC22D),
                      noOfPlayer: '50',
                      price: '37.40',
                      circleColor: Color(0XFF2BB1F3),
                      descriptionList: secondPlanDescription),
                  planView(
                      bodyBackground: Color(0XFF869DA7),
                      descriptionList: thirdPlanDescription,
                      circleColor: Color(0XFFFEC22D),
                      price: '37.50',
                      noOfPlayer: '20'),
                ],
              ),
            ),
            // Container(
            //   height: 50,
            //   color: appBarColor,
            //   child: DotsIndicator(
            //     color: Color(0x33ffffff),
            //     controller: _pageController,
            //     itemCount: 3,
            //     ctx: context,
            //     onPageSelected: (int page) {
            //       // pageController.animateToPage(
            //       //   page,
            //       //   duration: _kDuration,
            //       //   curve: _kCurve,
            //       // );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget bottomBar() {
    return Container(
      height: 50,
      color: appBarColor,
      child: DotsIndicator(
        color: Color(0x33ffffff),
        controller: _pageController,
        itemCount: 3,
        ctx: context,
        onPageSelected: (int page) {
          // pageController.animateToPage(
          //   page,
          //   duration: _kDuration,
          //   curve: _kCurve,
          // );
        },
      ),
    );
  }
}
