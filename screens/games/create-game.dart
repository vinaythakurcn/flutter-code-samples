import 'dart:async';
import 'dart:io';

import 'package:education_app/components/app_text.dart';
import 'package:education_app/screens/games/add-quiz.dart';
import 'package:education_app/screens/games/add-true-false.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:image_picker/image_picker.dart';

import '../../constants.dart';
import '../../helper/functions.dart';

import '../../components/app_title.dart';
import '../../components/appbar_flatbtn.dart';
import '../../components/custom_input_form_field.dart';
import '../../components/custom_progressbar.dart';
import '../../components/custom_textarea.dart';
import '../../components/image_crop_screen.dart';
import '../../components/primary_button.dart';
import '../../components/secondary_button.dart';

class CreateGame extends StatefulWidget {
  static const PAGEID = 'create-game';

  @override
  _CreateGameState createState() => _CreateGameState();
}

class _CreateGameState extends State<CreateGame> {
  String avatar = 'assets/images/cover.png';

  final title = TextEditingController();
  final description = TextEditingController();

  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        centerTitle: true,
        leading: AppBarFlatButton(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          text: "Cancel",
          fontSize: 16.0,
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: AppTitle(
          text: 'Create Game',
          size: 18,
          color: const Color(kPrimaryTitleColor),
        ),
        actions: <Widget>[
          AppBarFlatButton(
            padding: const EdgeInsets.symmetric(horizontal: 0),
            text: "Save",
            onPressed: () {},
            color: Theme.of(context).primaryColor,
          ),
        ],
        // Container(
        //   width: double.infinity,
        //   child: Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //     children: <Widget>[
        //       AppBarFlatButton(
        //         padding: const EdgeInsets.symmetric(horizontal: 0),
        //         text: "Cancel",
        //         onPressed: () {
        //           Navigator.of(context).pop();
        //         },
        //       ),
        //       Expanded(
        //         child: Center(
        //           child: AppTitle(
        //             text: 'Create Game',
        //             size: 18,
        //             color: const Color(kPrimaryTitleColor),
        //           ),
        //         ),
        //       ),
        //       AppBarFlatButton(
        //         padding: const EdgeInsets.symmetric(horizontal: 0),
        //         text: "Save",
        //         onPressed: () {},
        //         color: Theme.of(context).primaryColor,
        //       ),
        //     ],
        //   ),
        // ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 16),
                child: CustomProgressbar(
                  completeColor: Theme.of(context).primaryColor,
                  inCompleteValue: MediaQuery.of(context).size.width * 0.9,
                  completeValue: MediaQuery.of(context).size.width * 0.5,
                ),
              ),
            ),
            profileImageArea(),
            formArea(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget profileImageArea() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            containerForSheet<String>(
              context: context,
              child: customActionSheet(),
            );
          },
          child: Container(
            width: double.infinity,
            height: 300.0,
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.0),
              image: DecorationImage(
                image: isNetworkPath(avatar)
                    ? NetworkImage(avatar)
                    : isAssetsPath(avatar)
                        ? AssetImage(avatar)
                        : FileImage(File(avatar)),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget formArea() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          CustomInputFormField(
            // label: 'First Name',
            hint: 'Title',
            fieldCtrl: title,
            onChangeHandler: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16.0),
          CustomTextarea(
            hint: 'Description',
            controller: description,
            textColor: Color(kPrimaryColor),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16.0),
          PrimaryButton(
            text: "Add Questions",
            handler: actionSheet,
          )
        ],
      ),
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {
      // Scaffold.of(context).showSnackBar(new SnackBar(
      //   content: new Text('You clicked $value'),
      //   duration: Duration(milliseconds: 800),
      // ));
    });
  }

  Widget customActionSheet() {
    return SafeArea(
      child: Material(
        type: MaterialType.transparency,
        child: Container(
          margin: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              PrimaryButton(
                text: 'Take Photo',
                handler: () {
                  _onImageButtonPressed(ImageSource.camera);
                  Navigator.pop(context, '');
                },
              ),
              const SizedBox(height: 8.0),
              SecondaryButton(
                text: 'Choose from Library',
                handler: () {
                  _onImageButtonPressed(ImageSource.gallery);
                  Navigator.pop(context, '');
                },
              ),
              const SizedBox(height: 8.0),
              SecondaryButton(
                text: 'Remove Photo',
                handler: () {
                  // ... REMOVE PHOTO HANDLING
                  Navigator.pop(context, '');
                },
              ),
              const SizedBox(height: 32.0),
              SecondaryButton(
                text: 'Cancel',
                handler: () {
                  Navigator.pop(context, '');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future _onImageButtonPressed(ImageSource source) async {
    try {
      _imageFile = await ImagePicker.pickImage(source: source);
      print('Camera Gallery Success : ${_imageFile.path}');

      final newPath = await Navigator.of(context)
          .pushNamed(ImageCropScreen.PAGEID, arguments: _imageFile);

      print('New Path after Cropping : $newPath');
      if (newPath.toString().isNotEmpty) {
        setState(() {
          avatar = newPath;
        });
      }
    } catch (e) {
      print('Error');
      print(e);
      _pickImageError = e;
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await ImagePicker.retrieveLostData();
    if (response.isEmpty) {
      return;
    }
    if (response.file != null) {
      setState(() {
        _imageFile = response.file;
      });
    } else {
      _retrieveDataError = response.exception.code;
    }
  }

  void actionSheet() {
    const sheetShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    );

    showModalBottomSheet(
        shape: sheetShape,
        backgroundColor: Color(kPrimaryColor),
        context: context,
        builder: (context) {
          return Container(
            height: 300,
            // color: Colors.transparent,
            child: new Container(
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 32.0),
                    child: AppTitle(
                      text: 'Add Question',
                      color: Color(kAppBackgroundColor),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      getQuizOption(
                          'Quiz', 'assets/images/quiz-options.png', false, () {
                        Navigator.of(context).pushNamed(AddQuiz.PAGEID);
                      }),
                      SizedBox(width: 32),
                      getQuizOption('True or False',
                          'assets/images/quiz-true-false.png', true, () {
                        Navigator.of(context)
                            .pushNamed(AddQuizTrueFalse.PAGEID);
                      }),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }

  Widget getQuizOption(
      String text, String image, bool isTrueFalse, Function handler) {
    Color bgClr =
        isTrueFalse ? Color(kPrimaryColor) : Color(kAppBackgroundColor);
    Color txtClr =
        isTrueFalse ? Color(kAppBackgroundColor) : Color(kPrimaryColor);

    return InkWell(
      onTap: handler,
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: bgClr,
          borderRadius: new BorderRadius.all(const Radius.circular(16.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              // 'assets/images/quiz-options.png',
              image,
              width: 84,
            ),
            SizedBox(height: 16),
            AppText(text: text, color: txtClr),
          ],
        ),
      ),
    );
  }
}
