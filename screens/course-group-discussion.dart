import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/chat_inputbox.dart';
import '../components/chat_message.dart';
import '../components/custom_appbar.dart';

class CourseGroupDiscussion extends StatelessWidget {
  static const PAGEID = 'course-group-discussion';

  static const _title = 'Online Master\'s of Accounting (iMSA)';

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(16.0),
              child: AppTitle(text: _title),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    children: <Widget>[
                      getOtherUserMsgBox(),
                      getOtherUserMsgBox(),
                      getOtherUserMsgBox(),
                    ],
                  ),
                ),
              ),
            ),
            ChatInputBox(
              onSend: (text) {
                print(text);
              },
            )
          ],
        ),
      ),
    );
  }

  getOtherUserMsgBox() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                const SizedBox(width: 64.0),
                AppText(text: 'Salma Alharoon', size: 14.0),
              ],
            ),
            AppText(text: '3 months ago', size: 14.0),
          ],
        ),
        ChatMessage(
          avatarUrl:
              'https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/avatar.png?alt=media&',
          message: 'The size of the avatar, expressed as the radius',
          isMe: false,
        ),
        Row(
          children: <Widget>[
            const SizedBox(width: 64.0),
            RatingBar(
              ignoreGestures: true,
              initialRating: 3,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: const Color(kRatedRatingColor),
              ),
              itemSize: 24.0,
              onRatingUpdate: null,
              unratedColor: const Color(kNavbarIconColor),
              alpha: 30,
            ),
          ],
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }
}
