import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_appbar.dart';

class TermsOfService extends StatelessWidget {
  static const PAGEID = 'terms-of-service';

  static const title1 =
      'Book Cave hereby grants to User a non-exclusive, nontransferable license to use the content only as authorized in this License Agreement. User agrees to accept this license and use the site only according to this Agreement.';
  static const title2 = 'Grant of license to BC through use of the BCD program';

  static const para1 =
      'If User chooses to participate on the BCD program by adding a magnet to BC, User grants to BC a non-exclusive license, until terminated, to copy and distribute copies of the book to third parties within the parameters User sets in the subscriber magnet, and to publicly perform and display the book and related information, in part or in whole, through BC\'s products and services as they exist now and in the future.';
  static const para2 =
      'User also grants to BC a non-exclusive license to make minor changes to User\'s books, provided that these changes do not materially alter the meaning, context, narrative, or representation of the book. As an example, we may remove debug data from MOBI files for the purpose of reducing their size, or add meta data for the purpose of making ebook sideloading easier for the end-user.';

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
              child: AppTitle(text: 'Terms of Service'),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      titleText(title1),
                      bodyText(para1),
                      bodyText(para2),
                      const SizedBox(height: 32.0),
                      titleText(title2),
                      bodyText(para1),
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
