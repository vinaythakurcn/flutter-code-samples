import 'package:flutter/material.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_bg_image.dart';
import '../components/app_map.dart';
import '../components/audio_player_primary.dart';
import '../components/custom_video_player.dart';
import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/custom_appbar.dart';

class CourseLessonPage extends StatelessWidget {
  static const PAGEID = 'course-lesson';

  static const String _courseTitle = 'Unit 1: Entering the Job Market';
  final String image =
      'https://rukminim1.flixcart.com/image/832/832/poster/f/k/g/doraemon-cartoon-hd-poster-art-bshi293-bshil293-large-original-imaeg56yzpmgjacg.jpeg?q=70';
  final String videoUrl =
      'https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/big_buck_bunny_720p_1mb.mp4?alt=media&';

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
              child: AppTitle(text: _courseTitle),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  margin: const EdgeInsets.only(top: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      /**
                       * LESSON 1
                       */
                      AppTitle(
                        text: '1.1  What is Networking?',
                        size: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: AppText(
                          text:
                              'In this unit, you will learn how to describe yourself and your experiences in a résumé. The unit will also help you build your job-related vocabulary.',
                        ),
                      ),
                      AudioPlayerPrimary(
                        title:
                            'Course Overview: Introduction to the Career Development Process',
                        subtitle: '1.1 Audio',
                        isPrimaryTrack: true,
                        url:
                            'https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/song1.mp3?alt=media&',
                      ),
                      const SizedBox(height: 24.0),
                      /**
                       * LESSON 2
                       */
                      AppTitle(
                        text: '1.2  Unlockable Achievement',
                        size: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: AppText(
                          text:
                              'This unit focuses on another important document for job-seekers: the cover letter. You will learn how to write a clear cover letter that tells employers why you are the right person for the job.',
                        ),
                      ),
                      AppBgImage(url: image),
                      const SizedBox(height: 24.0),
                      /**
                       * LESSON 3
                       */
                      AppTitle(
                        text: '1.3  Writing a Cover Letter',
                        size: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: AppText(
                          text:
                              'This unit focuses on another important document for job-seekers: the cover letter. You will learn how to write a clear cover letter that tells employers why you are the right person for the job.',
                        ),
                      ),
                      AppMap(
                        centerLat: 22.5871415,
                        centerLng: 88.3608955,
                        height: 180,
                      ),
                      const SizedBox(height: 24.0),
                      /**
                       * LESSON 4
                       */
                      AppTitle(
                        text: '1.4  Networking',
                        size: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 16.0),
                        child: AppText(
                          text:
                              'This unit will teach job-seekers language for meeting new people, making small talk, and describing',
                        ),
                      ),
                      CustomVideoPlayer(
                        url: videoUrl,
                      ),
                      const SizedBox(height: 24.0),
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
}
