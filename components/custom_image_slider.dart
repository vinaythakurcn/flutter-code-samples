import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class CustomImageSlider extends StatefulWidget {
  final List<Map<String, String>> images;
  final double sliderHeight;
  final double imageWidth;
  final double imageHeight;
  final double viewportFrac;
  final bool isText;
  final bool showBullets;
  final Function handler;

  CustomImageSlider(
      {@required this.images,
      @required this.sliderHeight,
      @required this.imageWidth,
      @required this.imageHeight,
      this.viewportFrac: 0.6,
      this.isText = false,
      this.showBullets = true,
      this.handler});

  @override
  _CustomImageSliderState createState() => _CustomImageSliderState();
}

class _CustomImageSliderState extends State<CustomImageSlider> {
  PageController pageController;

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;

  @override
  void initState() {
    // double viewportFrac = (widget.imageWidth * 100) / MediaQuery.of(context).size.width;
    pageController =
        PageController(initialPage: 1, viewportFraction: widget.viewportFrac);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // return PageView.builder(
    //   controller: pageController,
    //   itemCount: images.length,
    //   physics: new AlwaysScrollableScrollPhysics(),
    //   itemBuilder: (context, position) {
    //     return imageSlider(position);
    //   },
    // );

    return Column(
      children: <Widget>[
        Container(
          child: widget.showBullets
              ? Container(
                  width: double.infinity,
                  // color: Colors.grey[800].withOpacity(0.5),
                  padding: const EdgeInsets.all(20.0),
                  child: Center(
                    child: DotsIndicator(
                      controller: pageController,
                      itemCount: widget.images.length,
                      ctx: context,
                      onPageSelected: (int page) {
                        pageController.animateToPage(
                          page,
                          duration: _kDuration,
                          curve: _kCurve,
                        );
                      },
                    ),
                  ),
                )
              : null,
        ),
        Container(
          width: double.infinity,
          height: widget.sliderHeight,
          child: PageView.builder(
            controller: pageController,
            itemCount: widget.images.length,
            physics: new AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, position) {
              return imageSlider(
                  position, widget.imageWidth, widget.imageHeight);
            },
          ),
        ),
      ],
    );
  }

  imageSlider(int index, double imageWidth, double imageHeight) {
    return AnimatedBuilder(
      animation: pageController,
      builder: (context, widget) {
        // return SizedBox(
        //   width: imageWidth,
        //   height: imageHeight,
        //   child: widget,
        // );
        return widget;
      },
      child: Container(
        width: imageWidth,
        height: imageHeight,
        margin: EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(
              width: imageWidth,
              height: imageHeight,
              child: GestureDetector(
                onTap: () {
                  widget.handler != null
                      ? widget.handler(index)
                      : print('no handler');
                },
                child: ClipRRect(
                  borderRadius: new BorderRadius.circular(8.0),
                  child: Image.network(
                    widget.images[index]['url'],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 8.0, left: 8.0),
              child: widget.isText == true
                  ? AppText(
                      text: widget.images[index]['label'],
                      color: Color(kPrimaryColor),
                      fontWeight: FontWeight.bold,
                      size: 18,
                    )
                  : null,
            )
          ],
        ),
      ),
    );
  }
}

class DotsIndicator extends AnimatedWidget {
  DotsIndicator(
      {this.controller,
      this.itemCount,
      this.onPageSelected,
      this.color: Colors.green,
      this.ctx})
      : super(listenable: controller);

  /// The PageController that this DotsIndicator is representing.
  final PageController controller;

  /// The number of items managed by the PageController
  final int itemCount;

  /// Called when a dot is tapped
  final ValueChanged<int> onPageSelected;

  /// The color of the dots.
  ///
  /// Defaults to `Colors(0xfff0f0f0)`.
  final Color color;

  // The base size of the dots
  static const double _kDotSize = 16.0;

  // The increase in the size of the selected dot
  static const double _kMaxZoom = 2.0;

  // The distance between the center of each dot
  static const double _kDotSpacing = 25.0;

  final BuildContext ctx;

  Widget _buildDot(int index) {
    // double selectedness = Curves.easeOut.transform(
    //   max(
    //     0.0,
    //     1.0 - ((controller.page ?? controller.initialPage) - index).abs(),
    //   ),
    // );
    // double zoom = 1.0 + (_kMaxZoom - 1.0) * selectedness;

    // print(controller.initialPage);

    Color dotColor = color;
    if (controller.page != null) {
      if (controller.hasClients) {
        if (controller.page.ceil() == index) {
          dotColor = Colors.white;
        }
        // dotColor = color;
      } else {
        if (controller.initialPage == index) {
          dotColor = Colors.white;
        }
      }
    }
    else {
      if(index == 0) {
        dotColor = Colors.white;
      }
       
    }

    return new Container(
      width: _kDotSpacing,
      child: new Center(
        child: new Material(
          color: dotColor,
          type: MaterialType.circle,
          child: new Container(
            width: _kDotSize,
            height: _kDotSize,
            child: new InkWell(
              onTap: () => onPageSelected(index),
            ),
          ),
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: new List<Widget>.generate(itemCount, _buildDot),
    );
  }
}
