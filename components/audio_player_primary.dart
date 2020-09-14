import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

enum PlayerState { stopped, playing, paused }

class AudioPlayerPrimary extends StatefulWidget {
  final String url;
  final bool isLocal;
  final PlayerMode mode;

  final String title;
  final String subtitle;
  final bool isPrimaryTrack;

  AudioPlayerPrimary({
    @required this.title,
    @required this.url,
    @required this.isPrimaryTrack,
    this.subtitle,
    this.isLocal = false,
    this.mode = PlayerMode.MEDIA_PLAYER,
  });

  @override
  State<StatefulWidget> createState() {
    return new _AudioPlayerPrimaryState(url, isLocal, mode);
  }
}

class _AudioPlayerPrimaryState extends State<AudioPlayerPrimary> {
  String url;
  bool isLocal;
  PlayerMode mode;

  AudioPlayer _audioPlayer;
  AudioPlayerState _audioPlayerState;
  Duration _duration;
  Duration _position;

  PlayerState _playerState = PlayerState.stopped;
  StreamSubscription _durationSubscription;
  StreamSubscription _positionSubscription;
  StreamSubscription _playerCompleteSubscription;
  StreamSubscription _playerErrorSubscription;
  StreamSubscription _playerStateSubscription;

  get _isPlaying => _playerState == PlayerState.playing;
  get _isPaused => _playerState == PlayerState.paused;
  _durationText() {
    if (_duration != null) {
      var timeStr = _duration?.toString()?.split('.')?.first;
      var timeArr = timeStr.split(':');
      return timeArr[1] + ':' + timeArr[2];
    }
    return '';
    // _duration?.toString()?.split('.')?.first ?? '';
  }

  get _positionText => _position?.toString()?.split('.')?.first ?? '';

  _AudioPlayerPrimaryState(this.url, this.isLocal, this.mode);

  @override
  void initState() {
    super.initState();
    _initAudioPlayer();
  }

  @override
  void dispose() {
    _audioPlayer.stop();
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerErrorSubscription?.cancel();
    _playerStateSubscription?.cancel();
    super.dispose();
  }

  Widget _buildPrimaryTrack() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: Color(kHighlightColorOpac),
      ),
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: 40.0),
            onPressed: () {
              _isPlaying ? _pause() : _play();
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: _isPlaying
                  ? Color(kAppBackgroundColor)
                  : Theme.of(context).primaryColor,
              size: 24.0,
            ),
            shape: CircleBorder(),
            elevation: 2.0,
            fillColor: _isPlaying
                ? Theme.of(context).primaryColor
                : Color(kAppBackgroundColor),
            padding: const EdgeInsets.all(8.0),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text(
                          widget.subtitle,
                          style: TextStyle(
                            fontSize: 14.0,
                            color: Color(kAudioPlayerSubTitleColor),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          _durationText(),
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5.0),
                    child: Text(
                      widget.title,
                      style: TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Color(kPrimaryTitleColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildSecondaryTrack() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.0),
      width: double.infinity,
      child: Row(
        children: <Widget>[
          RawMaterialButton(
            constraints: BoxConstraints(minWidth: 40.0),
            onPressed: () {
              _isPlaying ? _pause() : _play();
            },
            child: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Theme.of(context).primaryColor,
              size: 24.0,
            ),
            shape: CircleBorder(
              side: BorderSide(
                width: 1.0,
                color: Color(kAppBorderColor),
              ),
            ),
            elevation: 0.0,
            fillColor: Color(kAppBackgroundColor),
            padding: const EdgeInsets.all(5.0),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(left: 8.0),
              child: Text(
                widget.title,
                style: TextStyle(
                  fontSize: 14.0,
                  color: Color(kPrimaryTextColor),
                ),
              ),
            ),
          ),
          Container(
            child: Text(
              _durationText(),
              style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return widget.isPrimaryTrack
        ? _buildPrimaryTrack()
        : _buildSecondaryTrack();
  }

  void _initAudioPlayer() {
    _audioPlayer = AudioPlayer(mode: mode);

    _durationSubscription =
        _audioPlayer.onDurationChanged.listen((duration) => setState(() {
              _duration = duration;
            }));

    _positionSubscription =
        _audioPlayer.onAudioPositionChanged.listen((p) => setState(() {
              _position = p;
            }));

    _playerCompleteSubscription =
        _audioPlayer.onPlayerCompletion.listen((event) {
      _onComplete();
      setState(() {
        _position = _duration;
      });
    });

    _playerErrorSubscription = _audioPlayer.onPlayerError.listen((msg) {
      print('audioPlayer error : $msg');
      setState(() {
        _playerState = PlayerState.stopped;
        _duration = Duration(seconds: 0);
        _position = Duration(seconds: 0);
      });
    });

    _audioPlayer.onPlayerStateChanged.listen((state) {
      if (!mounted) return;
      setState(() {
        _audioPlayerState = state;
      });
    });
  }

  Future<int> _play() async {
    final playPosition = (_position != null &&
            _duration != null &&
            _position.inMilliseconds > 0 &&
            _position.inMilliseconds < _duration.inMilliseconds)
        ? _position
        : null;
    final result =
        await _audioPlayer.play(url, isLocal: isLocal, position: playPosition);
    if (result == 1) setState(() => _playerState = PlayerState.playing);
    return result;
  }

  Future<int> _pause() async {
    final result = await _audioPlayer.pause();
    if (result == 1) setState(() => _playerState = PlayerState.paused);
    return result;
  }

  Future<int> _stop() async {
    final result = await _audioPlayer.stop();
    if (result == 1) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration();
      });
    }
    return result;
  }

  void _onComplete() {
    setState(() => _playerState = PlayerState.stopped);
  }

  test() {}
}
