import 'package:education_app/components/app_text.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/functions.dart';

import '../../components/app_title.dart';
import '../../components/custom_appbar.dart';

import '../../screens/faq/faq-list.dart';

class FaqCategories extends StatelessWidget {
  static const PAGEID = 'faq-categories';

  final List<String> lists = [
    'Account',
    'Books',
    'Courses',
    'Games',
    'Submissions',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(kAppBackgroundColor),
        appBar: CustomAppBar(appBarLeading: getBackButton(context)),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: AppTitle(
                  text: 'FAQ',
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: lists.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return getListItem(
                      itemName: lists[index],
                      isLast: index == lists.length - 1,
                      handler: () {
                        Navigator.of(context).pushNamed(FaqList.PAGEID);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Widget getListItem({String itemName, isLast, handler}) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: const BorderSide(
            width: 1,
            color: Color(kAppBorderColor),
          ),
          bottom: BorderSide(
            width: isLast ? 1 : 0,
            color: const Color(kAppBorderColor),
          ),
        ),
      ),
      child: ListTile(
        onTap: handler,
        title: AppText(
          text: itemName,
          color: Color(kPrimaryColor),
          size: 24.0,
          fontWeight: FontWeight.w500,
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Color(kPrimaryColor),
          size: 14.0,
        ),
      ),
    );
  }
}
