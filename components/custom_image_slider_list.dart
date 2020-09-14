import 'package:flutter/material.dart';

class CustomListImageSlider extends StatefulWidget {
  final List<Map<String, String>> images;
  final double sliderHeight;
  final double imageWidth;
  final double imageHeight;
  final bool isText;

  CustomListImageSlider(
      {@required this.images,
      @required this.sliderHeight,
      @required this.imageWidth,
      @required this.imageHeight,
      this.isText = false});

  @override
  _CustomListImageSliderState createState() => _CustomListImageSliderState();
}

class _CustomListImageSliderState extends State<CustomListImageSlider> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: widget.images.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          height: widget.sliderHeight,
          margin: EdgeInsets.all(10.0),
          // width: 300,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                width: widget.imageWidth,
                height: widget.imageHeight,
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.images[index]['url'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                // width: double.infinity,
                margin: EdgeInsets.only(top: 8.0, left: 8.0),
                child: widget.isText
                    ? Text(
                        widget.images[index]['label'],
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            color: Color(0xff777777),
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      )
                    : null,
              )
            ],
          ),
        );
      },
    );
  }
}
