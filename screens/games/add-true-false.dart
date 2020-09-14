import 'dart:async';
import 'dart:io';

import 'package:education_app/components/app_text.dart';
import 'package:education_app/components/custom_checkbox.dart';
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

class AddQuizTrueFalse extends StatefulWidget {
  static const PAGEID = 'add-true-false';

  @override
  _AddQuizTrueFalseState createState() => _AddQuizTrueFalseState();
}

class _AddQuizTrueFalseState extends State<AddQuizTrueFalse> {
  String avatar = 'assets/images/cover.png';

  final description = TextEditingController();

  List<Map<String, dynamic>> quizOptions = [
    {
      'label': 'A',
      'option': 'True',
      'isCorrect': false,
      'color': Color(0xFFBB6BD9) //... #BB6BD9
    },
    {
      'label': 'B',
      'option': 'False',
      'isCorrect': false,
      'color': Color(0xFF2F80ED) //... #2F80ED
    },
  ];

  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Container(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              AppBarFlatButton(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                text: "Cancel",
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: Center(
                  child: AppTitle(
                    text: 'True or False',
                    size: 18,
                    color: const Color(kPrimaryTitleColor),
                  ),
                ),
              ),
              AppBarFlatButton(
                padding: const EdgeInsets.symmetric(horizontal: 0),
                text: "Save",
                onPressed: () {},
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            profileImageArea(),
            formArea(),
            const SizedBox(height: 16.0),
            PrimaryButton(
              text: "Next",
              handler: () {
                actionSheet();
              },
              shape: Shape.block,
            )
          ],
        ),
      ),
    );
  }

  actionSheet() {
    const sheetShape = RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.0),
        topRight: Radius.circular(16.0),
      ),
    );

    showModalBottomSheet(
        context: context,
        shape: sheetShape,
        builder: (context) {
          return Container(
            child: ListView(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0),
                      child: AppText(
                        text: 'Checklist',
                        color: Color(kPrimaryTitleColor),
                        size: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomProgressbar(
                      inCompleteBarHeight: 5,
                      inCompleteValue: (MediaQuery.of(context).size.width - 50),
                      completeValue:
                          (MediaQuery.of(context).size.width - 100) * 0.6,
                      completeColor: Color(kPrimaryColor),
                      inCompleteColor: Color(0X15869DA7),
                      completeBarHeight: 6,
                    ),
                    tileList(
                        title: 'Add a Title',
                        iconName: Icons.info,
                        iconColor: Color(0XFFEB5757)),
                    tileList(
                      title: 'Make sure your Questions are Complete',
                      iconName: Icons.info,
                      iconColor: Color(0XFFEB5757),
                    ),
                    tileList(
                      title: 'Add Cover Image',
                      iconName: Icons.add_circle,
                      iconColor: Color(kPrimaryColor),
                    ),
                    tileList(
                      title: '5 or more Questions with Image',
                      iconName: Icons.add_circle,
                      iconColor: Color(kPrimaryColor),
                    ),
                    ListTile(
                      title: AppText(
                        text: 'Plus Subscription Required',
                        color: Color(kPrimaryTitleColor),
                        fontWeight: FontWeight.bold,
                        size: 18.0,
                      ),
                      trailing: RaisedButton(
                        child: AppText(
                          text: 'Upgrade',
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          size: 18.0,
                        ),
                        textColor: Colors.white,
                        color: Color(0XFF2F80ED),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(100.0),
                        ),
                        onPressed: () {},
                      ),
                    ),
                    PrimaryButton(
                      text: "Publish",
                      handler: () {
                        // actionSheet();
                      },
                      shape: Shape.block,
                    )
                  ],
                ),
              ],
            ),
          );
        });
  }

  Widget tileList({String title, IconData iconName, Color iconColor}) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Color(0xFFF0F0F0),
          ),
        )),
        child: ListTile(
          leading: Icon(
            iconName,
            color: iconColor,
          ),
          title: AppText(
            text: title,
            color: Color(kPrimaryTitleColor),
            size: 18.0,
            fontWeight: FontWeight.bold,
          ),
          trailing: Icon(
            Icons.arrow_forward_ios,
            color: Color(kPrimaryColor),
          ),
        ));
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
          CustomTextarea(
            hint: 'Description',
            controller: description,
            textColor: Color(kPrimaryColor),
            onChanged: (value) {
              setState(() {});
            },
          ),
          const SizedBox(height: 16.0),
          getQuizOptions()
        ],
      ),
    );
  }

  Widget getQuizOptions() {
    return Container(
        child: Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            getQuizOption(0, () {
              setState(() {
                quizOptions[1]['isCorrect'] = quizOptions[0]['isCorrect'];
                quizOptions[0]['isCorrect'] = !quizOptions[0]['isCorrect'];
              });
            }),
            getQuizOption(1, () {
              setState(() {
                quizOptions[0]['isCorrect'] = quizOptions[1]['isCorrect'];
                quizOptions[1]['isCorrect'] = !quizOptions[1]['isCorrect'];
              });
            }),
          ],
        ),
      ],
    ));
  }

  Widget getQuizOption(int i, Function handler) {
    return Expanded(
      child: InkWell(
        onTap: handler,
        child: Container(
          child: Card(
              color: quizOptions[i]['color'],
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: AppTitle(
                      text: quizOptions[i]['label'],
                      size: 18,
                      color: Color(kAppBackgroundColor),
                    ),
                    top: 8,
                    left: 8,
                  ),
                  quizOptions[i]['isCorrect']
                      ? Positioned(
                          child: Icon(
                            Icons.check_circle,
                            color: const Color(kAppBackgroundColor),
                            // size: 16,
                          ),
                          top: 8,
                          right: 8,
                        )
                      : Container(),
                  Center(
                    child: AppTitle(
                      text: quizOptions[i]['option'],
                      size: 18,
                      color: Color(kAppBackgroundColor),
                    ),
                  ),
                ],
              )),
          height: 200,
        ),
      ),
    );
  }

  void containerForSheet<T>({BuildContext context, Widget child}) {
    showCupertinoModalPopup<T>(
      context: context,
      builder: (BuildContext context) => child,
    ).then<void>((T value) {});
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
}
