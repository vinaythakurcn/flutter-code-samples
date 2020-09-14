import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/functions.dart';

import '../../components/app_title.dart';
import '../../components/custom_appbar.dart';
import '../../components/app_text.dart';

import './faq-details.dart';

class FaqList extends StatefulWidget {
  static const PAGEID = 'faq-list';

  @override
  _FaqListState createState() => _FaqListState();
}

class _FaqListState extends State<FaqList> {
  final List<Map<String, dynamic>> lists = [
    {
      'name': 'General',
      'sublist': [
        'What’s the difference between a feature phone and a smartphone?',
        'Why is Worldreader working in underserved communities rather than in the U.S. or Europe?',
        'Who decides which books are loaded onto the e-readers?',
        'Do remote schools have electricity and wireless access for e-readers and mobile phones to operate?'
      ],
    },
    {
      'name': 'iOS Books',
      'sublist': [
        'What’s the difference between a feature phone and a smartphone?',
        'Why is Worldreader working in underserved communities rather than in the U.S. or Europe?',
        'Who decides which books are loaded onto the e-readers?',
        'Do remote schools have electricity and wireless access for e-readers and mobile phones to operate?'
      ],
    },
    {
      'name': 'Androdi Books',
      'sublist': [
        'What’s the difference between a feature phone and a smartphone?',
        'Why is Worldreader working in underserved communities rather than in the U.S. or Europe?',
        'Who decides which books are loaded onto the e-readers?',
        'Do remote schools have electricity and wireless access for e-readers and mobile phones to operate?'
      ],
    }
  ];

  List<bool> subListController;

  @override
  initState() {
    super.initState();
    subListController = new List(lists.length);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: const Text('FAQ'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: AppTitle(text: 'Account'),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lists.length,
                itemBuilder: (BuildContext ctx, int i) {
                  return getListItem(i);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getListItem(int index) {
    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Theme(
      data: theme,
      child: Container(
        color: subListController[index] ?? false
            ? const Color(kSecondaryBackgroundColor)
            : Colors.transparent,
        child: ExpansionTile(
          onExpansionChanged: (value) {
            setState(
              () {
                subListController[index] = value;
              },
            );
          },
          title: AppText(
            text: lists[index]['name'],
            color: Theme.of(context).primaryColor,
            size: 24.0,
            fontWeight: FontWeight.w500,
          ),
          leading: Icon(
            subListController[index] ?? false ? Icons.remove : Icons.add,
            color: Theme.of(context).primaryColor,
            size: 24.0,
          ),
          trailing: const Icon(
            Icons.add,
            size: 0,
          ),
          children: getSubLists(index),
        ),
      ),
    );
  }

  List<Widget> getSubLists(index) {
    final List<Widget> sublist = [];
    for (var i = 0; i < lists[index]['sublist'].length; i++) {
      sublist.add(
        getSubListItem(
            text: lists[index]['sublist'][i],
            isLastBorder: i == lists[index]['sublist'].length - 1),
      );
    }

    return sublist;
  }

  Widget getSubListItem({String text, bool isLastBorder}) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushNamed(FaqDetails.PAGEID);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: isLastBorder ? 0 : 1,
              color: const Color(kAppBorderColor),
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: AppTitle(
                text: text,
                size: 18.0,
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Color(kPrimaryColor),
              size: 14.0,
            ),
          ],
        ),
      ),
    );
  }
}
