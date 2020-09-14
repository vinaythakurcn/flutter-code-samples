import 'package:education_app/components/app_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AppLoader extends StatefulWidget {
  final bool inAsyncCall;

  final Widget child;

  final double opacity;

  final Widget progressIndicator;

  AppLoader({
    @required this.inAsyncCall,
    @required this.child,
    this.opacity = 0,
    this.progressIndicator,
  });

  @override
  _AppLoaderState createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader>
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
    return ModalProgressHUD(
      child: widget.child,
      inAsyncCall: widget.inAsyncCall,
      opacity: widget.opacity,
      progressIndicator: widget.progressIndicator ??
          AppCircularProgress(
            image: Image.asset(
              'assets/images/loader.png',
              width: 80,
              height: 80,
            ),
          ),
    );
  }
}
