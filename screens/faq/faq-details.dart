import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../helper/functions.dart';

import '../../components/app_title.dart';
import '../../components/custom_appbar.dart';

import '../../components/app_text.dart';

class FaqDetails extends StatelessWidget {
  static const PAGEID = 'faq-details';

  final String para1 =
      'Do remote schools have electricity and wireless access for e-readers and mobile phones to operate?';
  final String para2 =
      'Mobile phones have paved the way for electricity even in remote locations, and telecommunications networks in the developing world are often on par with or have leapfrogged, network standards compared to more developed zones. In Ghana, for instance, mobile phone penetration is above 80%.';
  final String para3 =
      'Additionally, e-readers consume relatively little power; a one-hour charge typically lasts two weeks or more. In some areas, we need to provide additional help. In the case of one of our first pilots in Ghana, the school did not have reliable power, so we partnered with other organizations to help fund a solar cell and satellite Internet access.';

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
            Container(
              padding: const EdgeInsets.all(16.0),
              margin: const EdgeInsets.only(bottom: 8.0),
              child: AppTitle(text: 'Books'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: <Widget>[
                      AppTitle(text: para1, size: 18.0),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: AppText(text: para2),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 16.0),
                        child: AppText(text: para3),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
