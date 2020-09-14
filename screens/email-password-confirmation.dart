import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/custom_appbar.dart';
import 'package:education_app/components/custom_flat_button.dart';
import 'package:education_app/components/primary_button.dart';
import 'package:education_app/helper/functions.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class EmailPasswordRecoveryConfirmation extends StatelessWidget {
  static const PAGEID = 'email-password-recovery-confirmation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: null,
        appBarActions: <Widget>[],
      ),
      body: buildWidget(context),
    );
  }

  Widget buildWidget(context) {
    final email = ModalRoute.of(context).settings.arguments;

    List<String> l = email.toString().split('@');

    final String replaceStr = l[0].substring(2);

    l[0] = l[0].replaceAll(replaceStr, '*****');

    final String result = l.join('@');

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: new BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.done,
                    color: Color(kAppBackgroundColor),
                    size: 48.0,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 24),
                  child: AppTitle(text: 'Password Reset Email Sent'),
                ),
                Container(
                  margin: EdgeInsets.only(top: 16),
                  child: AppText(
                      text:
                          'An email has been sent to your rescue email address, $result. Follow the direction in the email to reset your password.'),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 16.0),
                  child: CustomFlatButton(
                    text: 'Resend Validation Link',
                    handler: () {},
                  ),
                ),
              ],
            ),
          ),
          PrimaryButton(
            text: 'Done',
            handler: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          ),
        ],
      ),
    );
  }
}
