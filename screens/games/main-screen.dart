import 'package:education_app/components/custom_otp_textfield.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/screens/email-pin-verification.dart';
import 'package:education_app/screens/games/browse-categories.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  static const PAGEID = 'main-screen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  double containerWidth;
  double otpBoxWidth;
  double otpBoxHeight;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    containerWidth = MediaQuery.of(context).size.width * 0.7;
    otpBoxWidth = containerWidth * 0.20;
    otpBoxHeight = otpBoxWidth;

    return Scaffold(
      backgroundColor: Color(kPrimaryColor),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Container(),
            Column(
              children: <Widget>[
                Text(
                  'Game PIN Code',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter'),
                ),
                SizedBox(
                  height: 33,
                ),
                Container(
                  width: containerWidth,
                  child: CustomOTPTextField(
                    fieldWidth: otpBoxWidth,
                    fieldHeight: otpBoxHeight,
                    fieldBackground: Colors.white,
                    onSubmit: (value) {
                      print(value);
                      Navigator.of(context).pushNamed(BrowserCategories.PAGEID);
                    },
                  ),
                )
              ],
            ),
            btn(
              text: 'Play Game',
              bgClr: Colors.white,
              txtClr: Theme.of(context).primaryColor,
              ontap: () {
                // Navigator.of(context).pushNamed(EmailPinVerification.PAGEID);
              },
            ),
          ],
        ),
      ),
    );
  }
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
