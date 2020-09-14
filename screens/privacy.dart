import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_appbar.dart';

class PrivacyPage extends StatelessWidget {
  static const PAGEID = 'privacy-page';

  static const para1 =
      'This Agreement contains the complete and entire understanding and agreement between you (User) and the Book Cave (BC) website. The BC website includes My Book Ratings (MBR) and Book Cave Direct (BCD).';
  static const para2 =
      'This Agreement supersedes any previous communications, representations, or agreements, verbal or written. This Agreement may not be modified or amended orally or in any manner not set forth in writing or permitted by this Agreement.';
  static const para3 =
      'This User Agreement may be amended by Book Cave at any time and without notice, by amending this document as posted on our site. Any amendments will become effective immediately. Book Cave will send an email to advise User of the changes, but BC is not responsible for any delay in receipt. Users agree to check this license Agreement and terms of use if they have any question regarding the Agreement.';
  static const para4 =
      'If User is an author or publisher, User attests that User holds all the rights necessary to pictures, book covers, MOBI and EPUB files, and other content they upload to the BC website, or have obtained permission from publishers or other entities to use the copyrighted materials in the BC website.';

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
              margin: const EdgeInsets.only(bottom: 8.0),
              child: AppTitle(text: 'Privacy'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleText('User Agreement'),
                      bodyText(para1),
                      bodyText(para2),
                      bodyText(para3),
                      const SizedBox(height: 32.0),
                      titleText('License Grant'),
                      bodyText(para4),
                      const SizedBox(height: 16.0),
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

  Widget bodyText(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 16.0),
      child: AppText(noOpacity: true, text: text),
    );
  }

  Widget titleText(String text) {
    return AppTitle(
      text: text,
      size: 18.0,
    );
  }
}
