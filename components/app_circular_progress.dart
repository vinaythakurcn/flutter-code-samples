import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AppCircularProgress extends StatefulWidget {
  final Widget image;

  AppCircularProgress({
    @required this.image,
  });

  @override
  _AppCircularProgressState createState() => _AppCircularProgressState();
}

class _AppCircularProgressState extends State<AppCircularProgress>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;

  @override
  initState() {
    super.initState();

    animationController = new AnimationController(
      vsync: this,
      duration: new Duration(seconds: 1),
    );

    animationController.repeat();

    // isWelcomePageDisplayed(context);
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: new AnimatedBuilder(
        animation: animationController,
        child: widget.image,
        builder: (BuildContext context, Widget _widget) {
          return new Transform.rotate(
            angle: animationController.value * 6.3,
            child: _widget,
          );
        },
      ),
    );
  }
}
