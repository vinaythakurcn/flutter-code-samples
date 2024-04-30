import 'dart:async';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:demo_app/models/sendOtp/SendOtpResponse.dart';
import 'package:rxdart/rxdart.dart';
import '../../utils/base_bloc.dart';
import '../../utils/validations.dart';
import '../../web/web_service.dart';

class LoginBloc extends BaseBloc {
  final emailTEC = TextEditingController();

  late AnimationController _controller;
  late Animation<Offset> slidingRightToLeftAnimation,
      slidingLeftToRightAnimation,
      slidingTopRightToCenterAnimation;

  late BehaviorSubject<String> _emailController;
  late BehaviorSubject<bool> _loadingController;
  late BehaviorSubject<String> _errorMessageController;
  late BehaviorSubject<SendOtpResponse> _responseController;

  LoginBloc(TickerProvider provider) {

    _controller = AnimationController(
      vsync: provider,
      duration: const Duration(milliseconds: 700),
      reverseDuration: const Duration(milliseconds: 300),
    );
    slidingRightToLeftAnimation = Tween<Offset>(
            begin: const Offset(1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(_controller);
    slidingLeftToRightAnimation = Tween<Offset>(
            begin: const Offset(-1.0, 0.0), end: const Offset(0.0, 0.0))
        .animate(_controller);
    slidingTopRightToCenterAnimation = Tween<Offset>(
            begin: const Offset(1.0, -1.0), end: const Offset(0.0, 0.0))
        .animate(_controller);
    _emailController = BehaviorSubject.seeded("");
    _loadingController = BehaviorSubject.seeded(false);
    _errorMessageController = BehaviorSubject.seeded("");
    _responseController = BehaviorSubject();
  }

  StreamSink<String> get emailSink => _emailController.sink;

  StreamSink<bool> get loadingSink => _loadingController.sink;

  StreamSink<String> get errorMessageSink => _errorMessageController.sink;

  Stream<String> get emailStream => _emailController.stream;

  Stream<bool> get loadingStream => _loadingController.stream;

  Stream<String> get errorMessageStream => _errorMessageController.stream;

  Stream<SendOtpResponse> get responseStream => _responseController.stream;

  TickerFuture startAnimationForward() {
    return _controller.forward();
  }

  TickerFuture startAnimationReverse() {
    return _controller.reverse();
  }

  bool _areFieldsValid() {
    if (Validations.mInstance.isFieldEmpty(_emailController.value)) {
      _errorMessageController.sink.add("Please enter email address.");
      return false;
    } else if (Validations.mInstance.isInvalidEmail(_emailController.value)) {
      _errorMessageController.sink.add("Please enter valid email address.");
      return false;
    } else {
      return true;
    }
  }

  void onClickProceed(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    if (_areFieldsValid()) {
      var token;
      try {
        token = await FirebaseMessaging.instance.getToken();
      } catch (e) {
        print(e);
      }

      print("token: $token");

      _loadingController.sink.add(true);
      final response =
          await WebService.instance.generateOtp(_emailController.value);
      _loadingController.sink.add(false);
      if (response.success == true) {
        _responseController.add(response);
      } else {
        _errorMessageController.sink.add(response.message ?? "");
      }
    }
  }

  @override
  void dispose() {
    emailTEC.dispose();
    _controller.dispose();
    _emailController.close();
    _loadingController.close();
    _errorMessageController.close();
    _responseController.close();
  }
}
