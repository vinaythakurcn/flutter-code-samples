import 'package:flutter/gestures.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:demo_app/models/sendOtp/SendOtpResponse.dart';
import 'package:demo_app/utils/custom_extensions.dart';
import '../../utils/frequent_utils.dart';
import '../../utils/style.dart';
import 'package:flutter/material.dart';
import '../../utils/app_router.dart';
import '../../utils/constants.dart';
import '../webview_screen/webview_screen.dart';
import 'login_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  late LoginBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = LoginBloc(this);
    _initializeCommonListener(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: APP_PRIMARY_COLOR,
      appBar: AppBar(
        backgroundColor: APP_PRIMARY_COLOR,
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: double.maxFinite,
                height: double.maxFinite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SvgPicture.asset(
                      "assets/svg/app_logo.svg",
                      width: 120,
                      height: 55,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      "Enter your email",
                      style: textStyleBlackMontserratBold14,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "Please enter your email to set up your account",
                      style: textStyleColorDarkMontserrat12,
                    ),
                    const SizedBox(height: 10),
                    Container(
                      decoration: BoxDecoration(
                        color: APP_PRIMARY_COLOR_DARK2.withAlpha(70),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(
                          vertical: 12, horizontal: 12),
                      child: TextField(
                        style: textStyleBlackMontserrat14,
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 1,
                        controller: _bloc.emailTEC,
                        decoration: InputDecoration(
                          isDense: true,
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          hintText: "example@email.com",
                          hintStyle: textStyleColorDarkMontserrat12,
                        ),
                        onChanged: _bloc.emailSink.add,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            RichText(
              text: TextSpan(children: [
                TextSpan(
                  text: "By proceeding, you are agreeing to DemoApp’s ",
                  style: textStyleBlackMontserrat11,
                ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(
                          context,
                          AppRoute.webviewScreen,
                          arguments:
                          WebviewScreenArgument(url: TERMS_AND_CONDITIONS),
                        );
                      },
                    text: " Terms & Conditions",
                    style: textStyleColorDarkMontserrat11,
                  )
                ],
              ),
            ),
            const SizedBox(height: 10),
            InkWell(
              onTap: () => _bloc.onClickProceed(context),
              child: Container(
                height: 55,
                color: APP_PRIMARY_COLOR_DARK,
                child: Center(
                  child: Text(
                    "PROCEED",
                    style: textStyleWhiteMontserrat14,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _initializeCommonListener(BuildContext context) {
    //loading indicator
    _bloc.loadingStream.listen((bool value) {
      if (value) {
        FrequentUtils.instance.showProgressDialog(context);
      } else {
        FrequentUtils.instance.hideProgressDialog(context);
      }
    });
    //message
    _bloc.errorMessageStream.listen((String message) {
      if (message.isNullOrEmptyNot()) {
        FrequentUtils.instance.showToast(message, Toast.LENGTH_LONG);
      }
    });
    //response
    _bloc.responseStream.listen((SendOtpResponse response) {
      if (response.isNotNull()) {
        // FrequentUtils.instance.showToast(
        //     "${response.message}: ${response.data}", Toast.LENGTH_LONG);
        Navigator.of(context).pushNamed(
          AppRoute.verifyOtp,
          arguments: _bloc.emailTEC.text,
        );
      }
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
