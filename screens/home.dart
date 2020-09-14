import 'dart:async';
import 'dart:io';

import 'package:education_app/screens/games/main-screen.dart';
import 'package:education_app/testing/dialog-flow.dart';
import 'package:education_app/testing/firebase_chat.dart';
import 'package:education_app/testing/native-code-tester.dart';
import 'package:education_app/testing/signature-pad.dart';
import 'package:education_app/testing/test_aws_s3.dart';
import 'package:education_app/testing/test_azure.dart';
import 'package:education_app/testing/view-pdf.dart';
import 'package:uni_links/uni_links.dart';
import 'package:flutter/services.dart' show PlatformException;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toast/toast.dart';

import './change-password.dart';

import '../providers/auth.dart';

import '../components/download_file.dart';

import '../screens/email-pin-verification.dart';
import '../screens/faq/faq-categories.dart';
import '../screens/feed-list.dart';
import '../screens/about-app.dart';

import '../screens/course-browse.dart';
import '../screens/course-group-discussion.dart';
import '../screens/course-lesson.dart';
import '../screens/course_welcome.dart';
import '../screens/privacy.dart';
import '../screens/terms-of-service.dart';
import '../screens/user-profile.dart';
import '../screens/library-read.dart';

import '../testing/downloader.dart';
import '../testing/firebase_storage_test.dart';
import '../testing/reusable_downloader.dart';
import '../testing/video_player_example.dart';
import '../testing/test_backblaze.dart';

class HomePage extends StatefulWidget {
  static const PAGEID = 'home';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    initUniLinks();
  }

  Future<void> onRefresh(context) async {
    await Provider.of<Auth>(context).user.reload();
  }

  Future<Null> initUniLinks() async {
    getLinksStream().listen((String link) {
      print('got link: $link');
    }, onError: (err) {
      print('got err: $err');
    });

    // Platform messages may fail, so we use a try/catch PlatformException.
    // try {
    //   String initialLink = await getInitialLink();
    //   print('initialLink : $initialLink');
    //   // Parse the link and warn the user, if it is not correct,
    //   // but keep in mind it could be `null`.
    // } on PlatformException {
    //   print('PlatformException');
    //   // Handle exception by warning the user their action did not succeed
    //   // return?
    // }
  }

  @override
  Widget build(BuildContext context) {
    final _auth = Provider.of<Auth>(context);

    final String username = _auth.user == null ? 'Guest' : _auth.user.email;
    final String accountStatus =
        _auth.user != null && _auth.user.isEmailVerified
            ? 'Verified'
            : 'Not Verified';

    print('Homepage : ');
    print(_auth.user);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: RefreshIndicator(
        onRefresh: () => onRefresh(context),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Container(
            // height: MediaQuery.of(context).size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Welcome,',
                  style: TextStyle(fontSize: 15.0),
                ),
                Text(
                  username,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      '($accountStatus)',
                      style: TextStyle(fontSize: 15.0),
                    ),
                    if (accountStatus != 'Verified')
                      FlatButton(
                        child: const Text('Send verification email'),
                        onPressed: () async {
                          await _auth.sendVerificationMail();
                          Toast.show("Verification mail sent", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        },
                      ),
                  ],
                ),
                SizedBox(
                  height: 20.0,
                ),
                RaisedButton(
                  child: const Text('Logout'),
                  onPressed: () async => _auth.signOut(),
                ),
                SizedBox(
                  height: 40.0,
                ),
                Wrap(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Changes Password'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ChangePasswordPage.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Email verify OTP Page'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(EmailPinVerification.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('FAQ Categories'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(FaqCategories.PAGEID);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Wrap(
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Feed List'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(FeedList.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('About App'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(AboutApp.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Privacy'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(PrivacyPage.PAGEID);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: const Text('Terms Of Service'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(TermsOfService.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Course Browse'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(CourseBrowse.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Course Lesson'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CourseLessonPage.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('CourseGroupDiscussion'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CourseGroupDiscussion.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('UserProfile'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(UserProfile.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Course Welcomee'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(CourseWelcomePage.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Library Read'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(LibraryReadScreen.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Video Recording Test'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(VideoPlayerExample.PAGEID);
                      },
                    ),
                    /* RaisedButton(
                      child: const Text('FlutterDownloader Example'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(DownloaderPage.PAGEID);
                      },
                    ), */
                    RaisedButton(
                      child: const Text('Reusable Download Test'),
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamed(ReusableDownloaderPage.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Firebase Storage Test'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(FireStorageTest.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('BackBlaze Test'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(TestBackBlaze.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('AWS S3 Test'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(TestAwsS3.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Azure Test'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(TestAzure.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Games Pages'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(MainScreen.PAGEID);
                      },
                    ),
                     RaisedButton(
                      child: const Text('Run Native codes'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(NativeCodeTester.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Firebase chat'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(FirebaseChat.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Dialog Flow'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(DialogFlow.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('Signature Pad'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(SignaturePad.PAGEID);
                      },
                    ),
                    RaisedButton(
                      child: const Text('PDF Viewer'),
                      onPressed: () {
                        Navigator.of(context).pushNamed(ViewPdf.PAGEID);
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
