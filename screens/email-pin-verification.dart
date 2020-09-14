import 'dart:convert';

import 'package:education_app/common-task.dart';
import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/appbar_flatbtn.dart';
import 'package:education_app/components/custom_appbar.dart';
import 'package:education_app/components/custom_input_form_field.dart';
import 'package:education_app/components/custom_otp_textfield.dart';
import 'package:education_app/components/primary_button.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/helper/functions.dart';
import 'package:education_app/screens/feed-list.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:toast/toast.dart';

class EmailPinVerification extends StatefulWidget {
  static const PAGEID = 'email-pin-verification';
  // final String countryCode;
  // final String phoneNumber;

  // EmailPinVerification(
  //     {@required this.countryCode, @required this.phoneNumber});

  @override
  _EmailPinVerificationState createState() => _EmailPinVerificationState();
}

class _EmailPinVerificationState extends State<EmailPinVerification> {
  double containerWidth;
  double otpBoxWidth;
  double otpBoxHeight;
  bool _isLoading = false;
  var navParams;
  String pin;
  final pinField = TextEditingController();
  String pinErrorMsg;
  bool showErrorPin = false;

  @override
  Widget build(BuildContext context) {
    containerWidth = MediaQuery.of(context).size.width * 0.7;
    otpBoxWidth = containerWidth * 0.20;
    otpBoxHeight = otpBoxWidth;
    final Map arguments = ModalRoute.of(context).settings.arguments as Map;
    // if (arguments != null) print(arguments['phone']);
    navParams = arguments;
    return Scaffold(
      backgroundColor: Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: null,
        appBarActions: <Widget>[],
      ),
      body: SafeArea(
        child: ModalProgressHUD(
          child: buildWidget(),
          inAsyncCall: _isLoading,
          progressIndicator: CircularProgressIndicator(
            backgroundColor: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  // getDeviceDetails() async {
  //   var res = await getRequest('devices/$pin');
  //   print(res.body);
  // }

  verifyOTP() async {
    final String pinCode = pinField.value.text.trim();
    print(pinCode);
    if (pinCode != '') {
      // print('in otp');
      Map data = {
        'phone_number': navParams['phone'],
        'country_code': navParams['countryCode']
      };
      var res = await putRequest('devices/$pinCode', data);
      print(res.body);
      var response = json.decode(res.body);
      if (response['success']) {
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DemoPage()),
        );
      } else {
        setState(() {
          showErrorPin = true;
        });
        Toast.show(response['message'], context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
    } else {
      Toast.show("Please enter a pin code", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Widget buildWidget() {
    return SingleChildScrollView(
      // padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          infoSection(),
          ...otpSection(),
          bottomSection(),
        ],
      ),
    );
  }

  Widget infoSection() {
    return Padding(
      padding: EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Container(
          //   width: 80.0,
          //   height: 80.0,
          //   decoration: new BoxDecoration(
          //     color: Theme.of(context).primaryColor,
          //     shape: BoxShape.circle,
          //   ),
          //   child: Icon(
          //     Icons.hourglass_empty,
          //     color: Color(kAppBackgroundColor),
          //     size: 48.0,
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(top: 24),
            child: AppTitle(text: 'Activate Device'),
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: AppText(
              text:
                  'Enter the code sent to your phone to activate your device and Start using Project Meta.',
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> otpSection() {
    return [
      if (showErrorPin)
        Container(
          // padding: EdgeInsets.all(12.0),
          child: AppText(
            size: 14.0,
            text: 'That activation code is not valid',
            color: Color(kAppErrorColor),
          ),
        ),
      Container(
        margin: EdgeInsets.only(top: 8.0, bottom: 24.0),
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: CustomInputFormField(
          keyboardType: TextInputType.number,
          fieldCtrl: pinField,
          onChangeHandler: (_) {
            pinErrorMsg = emptyValidator(pinField.value.text);
            // setState(() {
            showErrorPin = false;
            // });
          },
          hint: 'Activation Code',
          errorMsg: pinErrorMsg,
        ),
      ),
      Container(
        padding: EdgeInsets.only(right: 16.0, left: 16.0),
        child: PrimaryButton(
          text: 'Activate Device',
          handler: () {
            // print(navParams['countryCode'] + navParams['phone']);
            verifyOTP();
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => DemoPage()),
            // );
          },
        ),
      )
    ];
  }

  resendVerificationCode() async {
    Map data = {
      'phone_number': navParams['phone'],
      'country_code': navParams['countryCode'],
      'device_id': navParams['deviceID']
    };
    var res = await postRequest('devices', data);
    print(res.body);
    // setState(() {
    //   _isLoading = false;
    // });
    var response = json.decode(res.body);
    if (response['success']) {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    } else {
      Toast.show(response['message'], context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
  }

  Widget bottomSection() {
    return Container(
      margin: EdgeInsets.only(top: 16.0),
      child: FlatButton(
        child: Text(
          'Send New Activation Code',
          style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 14.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        onPressed: () {
          resendVerificationCode();
        },
      ),
    );
  }
}

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                    left: 32.0, right: 32.0, bottom: 15.0, top: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: AppTitle(text: 'Device Activated'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: AppText(
                        text:
                            'Success! Your device is now activated. You\'re ready to explore free books and courses in Project Meta.',
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 32.0, right: 32.0, bottom: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: 24),
                      child: AppTitle(text: 'Notifications'),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 16),
                      child: AppText(
                        text:
                            'You can be the first to hear new releases and more.',
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(right: 16.0, left: 16.0, top: 15),
                child: PrimaryButton(
                  text: 'Okay',
                  handler: () {
                    Navigator.pushNamed(context, FeedList.PAGEID);
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 16.0),
                child: FlatButton(
                  child: Text(
                    'Maybe Later',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
