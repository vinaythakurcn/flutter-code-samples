import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/circle_progress.dart';
import 'package:education_app/components/custom_circular_badge.dart';
import 'package:flutter/material.dart';

class CircularBadgeProgress extends StatelessWidget {
  final Color color;
  final String image;
  final double currentProgress;

  CircularBadgeProgress(
      {@required this.currentProgress,
      @required this.color,
      @required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        width: 100,
        height: 104,
        margin: EdgeInsets.only(right: 8.0),
        child: CustomPaint(
          foregroundPainter: CircleProgress(
              currentProgress: currentProgress, activeColor: color),
          child: Container(
            // margin: EdgeInsets.only(bottom: 50.0),
            child: Center(
              child: CustomCircularBadge(
                color: color,
                image: image,
              ),
            ),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(top: 8.0),
        child: AppText(
          text: '${currentProgress.round()} %',
          size: 14.0,
        ),
      ),
    ]);
  }
}
