import 'dart:async';

import 'package:flutter/material.dart';

import 'package:video_player/video_player.dart';

import './custom_progressbar.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String url;

  CustomVideoPlayer({@required this.url});

  @override
  _CustomVideoPlayerState createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  GlobalKey _keyVideoPlayer = GlobalKey();

  // ... Completed part of Progressbar
  double completeValue;
  // ... Incompleted part of Progressbar
  double inCompleteValue;

  bool isPlaying = false;

  String lapsedTime = '';
  String remainingTime = '';

  bool isVideoLoaded = false;

  @override
  void initState() {
    _controller = VideoPlayerController.network(widget.url);

    // Initialize the controller and store the Future for later use.
    _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    _controller.setLooping(false);

    startListener();

    super.initState();
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    // do subsequent updates.

    print('CustomVideoPlayer didUpdateWidget  ${widget.url}');

    _controller = VideoPlayerController.network(widget.url);
    _initializeVideoPlayerFuture = _controller.initialize();
    startListener();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  void playPauseVideo() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        var position = _controller.value.position;
        var duration = _controller.value.duration;
        if (duration.compareTo(position) == 0) {
          _controller.seekTo(Duration(seconds: 0));
        }
        _controller.play();
        completeValue = 0.0;
      }
    });
  }

  void muteUnmuteVideo() {
    setState(() {
      if (_controller.value.volume == 1.0) {
        _controller.setVolume(0.0);
      } else {
        _controller.setVolume(1.0);
      }
    });
  }

  String getFormatedDuration(Duration d) {
    if (d.inHours == 0) {
      var minSec = d.toString().split('.')[0];
      return minSec.split(':')[1] + ':' + minSec.split(':')[2];
    } else {
      return d.toString().split('.')[0];
    }
  }

  startListener() {
    _controller.addListener(() {
      if (isVideoLoaded) {
        final RenderBox renderBoxRed =
            _keyVideoPlayer.currentContext.findRenderObject();

        inCompleteValue = renderBoxRed.size.width;

        var position = _controller.value.position;
        var duration = _controller.value.duration;

        lapsedTime = getFormatedDuration(position);
        remainingTime = '-' + getFormatedDuration(duration - position);

        var durationCompare = duration.compareTo(position);

        if (durationCompare == 0) {
          isPlaying = false;
          completeValue = inCompleteValue;
        } else {
          var completedPercent =
              position.inMilliseconds * 100 / duration.inMilliseconds;
          completeValue = inCompleteValue * completedPercent / 100;
        }

        setState(() {});
      }
    });
  }

  Container getTimerBox(String time) {
    return Container(
      width: 56.0,
      constraints: BoxConstraints(minWidth: 40.0),
      padding: EdgeInsets.symmetric(horizontal: 4.0),
      child: Text(
        time,
        style: TextStyle(color: Colors.white, fontSize: 13.0),
        textAlign: TextAlign.center,
      ),
    );
  }

  RawMaterialButton getControlButton({IconData icon, Function handler}) {
    return RawMaterialButton(
      constraints: BoxConstraints(minWidth: 40.0),
      onPressed: handler,
      child: Icon(
        icon,
        color: Colors.white,
        size: 24.0,
      ),
    );
  }

  Widget getVideoControls() {
    if (isVideoLoaded) {
      return Container(
        width: double.infinity,
        height: 40.0,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              blurRadius: 10.0,
              spreadRadius: 0.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            getControlButton(
                icon: _controller.value.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                handler: playPauseVideo),
            getTimerBox(lapsedTime),
            Expanded(
              key: _keyVideoPlayer,
              child: CustomProgressbar(
                completeColor: Theme.of(context).primaryColor,
                inCompleteValue: inCompleteValue,
                completeValue: completeValue,
              ),
            ),
            getTimerBox(remainingTime),
            getControlButton(
              icon: _controller.value.volume == 1.0
                  ? Icons.volume_up
                  : Icons.volume_off,
              handler: muteUnmuteVideo,
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
  }

  Widget getPreloadedControl() {
    if (!isVideoLoaded) {
      return Container(
        decoration: BoxDecoration(color: Colors.black38),
        child: Center(
          child: IconButton(
            icon: Icon(Icons.play_circle_filled),
            iconSize: 56,
            color: Colors.white,
            onPressed: () {
              setState(() {
                isVideoLoaded = true;
                Future.delayed(
                    const Duration(milliseconds: 500), playPauseVideo);
              });
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: Stack(
                  children: <Widget>[
                    VideoPlayer(_controller),
                    getPreloadedControl()
                  ],
                ),
              );
            } else {
              return Container(
                width: double.infinity,
                height: 100.0,
                child: Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                ),
              );
            }
          },
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: getVideoControls(),
        ),
      ],
    );
  }
}
