import 'dart:async';
import 'dart:io';
import 'package:after_layout/after_layout.dart';
import 'package:calendar_view/calendar_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:demo_app/models/CrashReportData.dart';
import 'package:demo_app/utils/fcm_notifications.dart';
import 'package:demo_app/utils/in_app_purchase_helper.dart';
import 'package:demo_app/utils/no_grow_behavior.dart';
import 'package:demo_app/web/web_service.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../models/my_provider.dart';
import '../utils/SharedPref.dart';
import '../utils/app_router.dart';
import '../utils/constants.dart';
import 'dart:ui';

Future<CrashReportData> _getCrashReportData() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  final PackageInfo packageInfo = await PackageInfo.fromPlatform();
  String version = packageInfo.version;

  CrashReportData data = CrashReportData(appVersion: version);
  if (Platform.isAndroid) {
    final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    print('Running on ${androidInfo.model}'); // e.g. "Moto G (4)"
    data.osVersion = "Android ${androidInfo.version.release}";
    data.deviceName = androidInfo.model;
  } else {
    final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    print('Running on ${iosInfo.utsname.machine}'); // e.g. "iPod7,1"
    data.osVersion = "IOS ${(iosInfo.systemVersion ?? "")}";
    data.deviceName = iosInfo.utsname.machine;
  }

  return data;
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final CrashReportData data = await _getCrashReportData();

  final repo = WebService.instance;
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    data.pageName = AppRoute.currentRouteName;
    data.crashMessage = details.stack?.toString() ?? "";
    repo.sendCrashReport(crashData: data);
  };
  // PlatformDispatcher.instance.onError = (error, stack) {
  //   data.pageName = AppRoute.currentRouteName;
  //   data.crashMessage = stack.toString();
  //   repo.sendCrashReport(crashData: data);
  //   return true;
  // };

  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  await FcmNotification.getInstance().init();

  await SharedPref.initializePreferences();
  Stripe.publishableKey = stripePublishableKey;

  runApp(
    ChangeNotifierProvider(
      create: (BuildContext context) => MyProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with AfterLayoutMixin<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext c) {
    // InAppPurchaseHelper.initialize(c);
  }

  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider(
      controller: EventController(),
      child: MaterialApp(
        title: APP_NAME,
        theme: ThemeData(
          brightness: Brightness.light,
          primaryColor: APP_PRIMARY_COLOR,
          backgroundColor: APP_PRIMARY_COLOR,
          primaryColorDark: APP_PRIMARY_COLOR_DARK,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRoute.generateRoute,
        initialRoute: AppRoute.splash,
        scrollBehavior: NoGrowBehavior(),
        // localizationsDelegates: [
        //   S.delegate,
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: S.delegate.supportedLocales,
      ),
    );
  }
}
