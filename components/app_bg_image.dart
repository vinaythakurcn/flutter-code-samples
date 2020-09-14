import 'package:flutter/material.dart';

class AppBgImage extends StatelessWidget {
  final String url;
  final double width;
  final double height;
  final double radius;

  static const double defaultRadius = 8.0;
  static const double defaultHeight = 180.0;

  AppBgImage({@required this.url, this.height, this.width, this.radius});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? double.infinity,
      height: height ?? defaultHeight,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(url),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(radius ?? defaultRadius),
      ),
    );
  }
}
