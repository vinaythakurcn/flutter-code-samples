import 'dart:math';

import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/my_extended_text_selection_controls.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/helper/functions.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class LibraryReadScreen extends StatefulWidget {
  static const PAGEID = 'library_read_screen';
  @override
  _LibraryReadScreenState createState() => _LibraryReadScreenState();
}

class _LibraryReadScreenState extends State<LibraryReadScreen> {
  double fontSize = 18.0;

  bool showPopover = false;

  bool isDarkTheme = false;

  String title = 'Jack London';

  String para1 =
      'This should be a user profile page that displays this content: Avatar, Handle (e.g. @cindyrocks, 140- Character Max Bio, Points Earned (between 0 - 20,000), Earned Badges, Upcoming Badges, LinkedIn Profile Link, Top Personal Interests (tag list), Top Six Personal Values (tag list).';
  String para2 =
      'However, the page should have placeholder badges that show how those would be displayed in the profile. The Upcoming Badges section should show what Badges they are close to getting (with a percentage to completion provided for each).';
  String para3 =
      'The Cruise of the Dazzler (1902) A Daughter of the Snows (1902) The Call of the Wild (1903) The Kempton-Wace Letters (1903)';

  final BoxDecoration popoverBox = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(8.0),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 8.0,
        spreadRadius: 0.0,
      ),
    ],
  );

  getPageBgClr() {
    return isDarkTheme
        ? const Color(kPrimaryTitleColor)
        : const Color(kAppBackgroundColor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getPageBgClr(),
      appBar: AppBar(
        backgroundColor: getPageBgClr(),
        leading: getBackButton(context),
        title: null,
        actions: <Widget>[appBarActionBtn()],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(child: _getMainBody()),
            showPopover ? renderPopover() : Container(),
            showPopover ? renderPopoverTriangle() : Container(),
          ],
        ),
      ),
    );
  }

  Widget appBarActionBtn() {
    return InkWell(
      onTap: () {
        setState(() {
          showPopover = !showPopover;
        });
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Stack(
            children: <Widget>[
              Transform.rotate(
                angle: showPopover ? pi / 4 : 0,
                origin: Offset(0, 0),
                child: Container(
                  width: 16,
                  height: 2,
                  color: Color(kNavbarIconColor),
                ),
              ),
              Transform.rotate(
                angle: showPopover ? -pi / 4 : 0,
                origin: Offset(0, 0),
                child: Container(
                  margin: EdgeInsets.only(top: showPopover ? 0 : 8.0),
                  width: 16,
                  height: 2,
                  color: Color(kNavbarIconColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget renderPopover() {
    return Positioned(
      right: 8,
      top: 20,
      child: Container(
        height: 72,
        decoration: popoverBox,
        child: Row(
          children: <Widget>[
            getOptionsContainer([
              _getOptions(
                child: AppText(text: 'Aa'),
                handler: () {
                  _setFontSize(18.0);
                },
              ),
              _getOptions(
                child: AppText(
                  text: 'Aa',
                  fontWeight: FontWeight.w500,
                  size: 24,
                ),
                handler: () {
                  _setFontSize(24.0);
                },
              ),
              _getOptions(
                child: AppTitle(text: 'Aa'),
                handler: () {
                  _setFontSize(28.0);
                },
              ),
            ], true),
            getOptionsContainer([
              _getCircularOptions(
                child: AppText(
                  text: 'Aa',
                  color: Color(kPrimaryTitleColor),
                ),
                bgClr: Color(kChipBgColor),
                handler: () {
                  setState(() {
                    isDarkTheme = false;
                  });
                },
              ),
              _getCircularOptions(
                child: AppText(
                  text: 'Aa',
                  color: Color(kAppBackgroundColor),
                ),
                bgClr: Color(kPrimaryTitleColor),
                handler: () {
                  setState(() {
                    isDarkTheme = true;
                  });
                },
              ),
            ], false),
          ],
        ),
      ),
    );
  }

  Widget renderPopoverTriangle() {
    return Positioned(
      top: 10,
      right: 18,
      child: RotationTransition(
        turns: new AlwaysStoppedAnimation(45 / 360),
        child: Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5.0),
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.black12,
            //     blurRadius: 6.0,
            //     spreadRadius: 0.0,
            //     offset: Offset(-6.0, -6.0),
            //   ),
            //   BoxShadow(
            //     color: Colors.white24,
            //     blurRadius: 0.0,
            //     spreadRadius: 0.0,
            //     offset: Offset(0.0, -10.0),
            //   ),
            // ],
          ),
        ),
      ),
    );
  }

  Widget getOptionsContainer(List<Widget> children, bool showBorder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      decoration: BoxDecoration(
        border: Border(
          right: BorderSide(
            width: showBorder ? 1 : 0,
            color: Color(kAppBorderColor),
          ),
        ),
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: children),
    );
  }

  Widget _getOptions({Widget child, Function handler}) {
    return InkWell(
      onTap: handler,
      child: Container(
        width: 48,
        child: Center(child: child),
      ),
    );
  }

  Widget _getCircularOptions({Widget child, Color bgClr, Function handler}) {
    return InkWell(
      onTap: handler,
      child: Container(
        width: 48,
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: bgClr,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(child: child),
      ),
    );
  }

  Widget _getMainBody() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          _getPara(
            child: _title(title),
          ),
          /* SelectableText.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: 'Styling ',
                ),
                TextSpan(text: 'text', style: TextStyle(color: Colors.blue)),
                TextSpan(
                  text: ' in Flutter',
                ),
              ],
            ),
          ),
          ExtendedText(
            para1,
            selectionEnabled: true,
            textSelectionControls: MyExtendedMaterialTextSelectionControls(
              colorHandler: (value) {
                print('Value inside page : $value');
              },
            ),
          ), */

          _getPara(
            child: _paragraph(para1),
          ),
          _getPara(
            child: _paragraph(para2),
          ),
          _getPara(
            child: _paragraph(para3),
          ),
        ],
      ),
    );
  }

  Widget _getPara({Widget child}) {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      width: double.infinity,
      child: child,
    );
  }

  _paragraph(String text) {
    return ExtendedText(
      text,
      style: TextStyle(
        color: isDarkTheme
            ? const Color(kAppBackgroundColor)
            : const Color(kPrimaryTextColorNoOpac),
        fontSize: fontSize,
      ),
      selectionEnabled: true,
      textSelectionControls: MyExtendedMaterialTextSelectionControls(
        colorHandler: (value) {
          print('Value inside page : $value');
        },
      ),
    );
    //   size: fontSize,
    //   color: isDarkTheme
    //       ? const Color(kAppBackgroundColor)
    //       : const Color(kPrimaryTextColorNoOpac),
    // );
  }

  _title(text) {
    return AppTitle(
      text: text,
      color: isDarkTheme
          ? const Color(kAppBackgroundColor)
          : const Color(kPrimaryTitleColor),
    );
  }

  void _setFontSize(size) {
    setState(() {
      fontSize = size;
    });
  }
}
