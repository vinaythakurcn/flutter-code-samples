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

class AddQuiz extends StatefulWidget {
  static const PAGEID = 'add-quiz';

  @override
  _AddQuizState createState() => _AddQuizState();
}

class _AddQuizState extends State<AddQuiz> {
  String avatar = 'assets/images/cover.png';

  final description = TextEditingController();

  List<Map<String, dynamic>> quizOptions = [
    {
      'label': 'A',
      'option': 'Squirrels',
      'isCorrect': true,
      'color': Color(0xFFBB6BD9) //... #BB6BD9
    },
    {
      'label': 'B',
      'option': 'Elk',
      'isCorrect': false,
      'color': Color(0xFF2BB1F3) //... #2BB1F3
    },
    {
      'label': 'C',
      'option': 'Hedgehogs',
      'isCorrect': false,
      'color': Color(0xFFFEC22D) //... #FEC22D
    },
    {
      'label': 'D',
      'option': 'Bever',
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
                    text: 'Quiz',
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
              handler: () {},
              shape: Shape.block,
            )
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
              alertDialogInput(0);
            }),
            getQuizOption(1, () {
              alertDialogInput(1);
            }),
          ],
        ),
        Row(
          children: <Widget>[
            getQuizOption(2, () {
              alertDialogInput(2);
            }),
            getQuizOption(3, () {
              alertDialogInput(3);
            }),
          ],
        ),
      ],
    ));
  }

  void alertDialogInput(int index) async {
    TextEditingController _textFieldController =
        TextEditingController(text: quizOptions[index]['option']);

    const inputBorder = UnderlineInputBorder(
      borderSide: BorderSide(
        color: Color(kAppBackgroundColor),
      ),
    );

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: quizOptions[index]['color'],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(16.0))),
            content: Container(
              height: 200,
              child: Stack(
                children: <Widget>[
                  Positioned(
                    child: AppText(
                      text: quizOptions[index]['label'],
                      size: 18,
                      color: Color(kAppBackgroundColor),
                    ),
                    top: 0,
                    left: 0,
                  ),
                  Positioned(
                    child: Row(
                      children: <Widget>[
                        AppText(
                          text: 'Right Answer',
                          size: 18,
                          color: Color(kAppBackgroundColor),
                        ),
                        CustomCheckbox(
                          type: CheckboxType.Circular,
                          onChanged: () {
                            setState(() {
                              print(
                                  'Before isCorrect : ${quizOptions[index]['isCorrect']}');
                              quizOptions[index]['isCorrect'] =
                                  !quizOptions[index]['isCorrect'];
                              print(
                                  'After isCorrect : ${quizOptions[index]['isCorrect']}');
                            });
                          },
                          value: quizOptions[index]['isCorrect'],
                        )
                      ],
                    ),
                    top: 0,
                    right: 0,
                  ),
                  Center(
                    child: TextField(
                      style: TextStyle(
                        color: Color(kAppBackgroundColor),
                        fontSize: 28.0,
                        fontWeight: FontWeight.bold,
                      ),
                      decoration: InputDecoration(
                          focusedBorder: inputBorder,
                          border: inputBorder,
                          enabledBorder: inputBorder),
                      controller: _textFieldController,
                      onChanged: (value) {
                        setState(() {
                          quizOptions[index]['option'] = value;
                        });
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
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
          height: 100,
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
