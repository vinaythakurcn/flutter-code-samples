import 'dart:io';
import 'dart:async';

import 'package:education_app/components/app_circular_progress.dart';
import 'package:flutter/material.dart';
import 'package:image_crop/image_crop.dart';

import '../components/app_title.dart';
import '../components/appbar_flatbtn.dart';
import '../constants.dart';

class ImageCropScreen extends StatefulWidget {
  static const PAGEID = 'image_crop_test';

  // File fileObj;

  // ImageCropScreen(this.fileObj);

  @override
  _ImageCropScreenState createState() => new _ImageCropScreenState();
}

class _ImageCropScreenState extends State<ImageCropScreen> {
  final cropKey = GlobalKey<CropState>();
  File _file;
  File _sample;
  File _lastCropped;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(seconds: 2), _openImage);
  }

  @override
  void dispose() {
    super.dispose();
    _file?.delete();
    _sample?.delete();
    _lastCropped?.delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(kCropImageBg),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Color(kCropImageBg),
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBarFlatButton(
                padding: EdgeInsets.symmetric(horizontal: 0),
                color: Colors.white30,
                text: "Cancel",
                onPressed: () {
                  backWithData(_file.path);
                },
              ),
              Expanded(
                child: Center(
                  child: AppTitle(
                    text: 'Edit Photo',
                    size: 18,
                    color: Color(kAppBackgroundColor),
                  ),
                ),
              ),
              AppBarFlatButton(
                padding: EdgeInsets.symmetric(horizontal: 0),
                text: "Save",
                onPressed: () {
                  _cropImage();
                },
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
            color: Colors.black,
            padding:
                const EdgeInsets.symmetric(vertical: 40.0, horizontal: 20.0),
            child: _buildCroppingImage()),
      ),
    );
  }

  Widget _buildCroppingImage() {
    return Column(
      children: <Widget>[
        Expanded(
          child: _sample == null
              ? Center(
                  child: AppCircularProgress(
                    image: Image.asset(
                      'assets/images/loader.png',
                      width: 80,
                      height: 80,
                    ),
                  ),
                )
              : Crop.file(
                  _sample,
                  key: cropKey,
                  alwaysShowGrid: true,
                  aspectRatio: 1.0,
                ),
        ),
        /* Container(
          padding: const EdgeInsets.only(top: 20.0),
          alignment: AlignmentDirectional.center,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              FlatButton(
                child: Text(
                  'Crop Image',
                  style: Theme.of(context)
                      .textTheme
                      .button
                      .copyWith(color: Colors.white),
                ),
                onPressed: () => _cropImage(),
              ),
            ],
          ),
        ) */
      ],
    );
  }

  Future<void> _openImage() async {
    print('OPENIMAGE CALLED');
    final _image = ModalRoute.of(context).settings.arguments;
    print(':: ImageCropScreen $_image ::');

    final sample = await ImageCrop.sampleImage(
      file: _image,
      preferredSize: context.size.longestSide.ceil(),
    );

    print('::OpenImage $sample ::');

    _sample?.delete();
    _file?.delete();

    _sample = sample;
    _file = _image;

    setState(() {});
  }

  Future<void> _cropImage() async {
    final scale = cropKey.currentState.scale;
    final area = cropKey.currentState.area;
    if (area == null) {
      // cannot crop, widget is not setup
      return;
    }

    // scale up to use maximum possible number of pixels
    // this will sample image in higher resolution to make cropped image larger
    final sample = await ImageCrop.sampleImage(
      file: _file,
      preferredSize: (2000 / scale).round(),
    );

    final file = await ImageCrop.cropImage(
      file: sample,
      area: area,
    );

    sample.delete();

    _lastCropped?.delete();
    _lastCropped = file;

    backWithData(file.path);
  }

  void backWithData(String url) {
    Navigator.pop(context, url);
  }
}
