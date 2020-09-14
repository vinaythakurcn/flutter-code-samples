import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import 'package:image_picker/image_picker.dart';

import '../constants.dart';
import '../helper/functions.dart';

import '../components/app_text.dart';
import '../components/app_title.dart';
import '../components/appbar_flatbtn.dart';
import '../components/custom_chip.dart';
import '../components/custom_input_form_field.dart';
import '../components/primary_button.dart';
import '../components/secondary_button.dart';
import '../components/image_crop_screen.dart';

import './personal_interest_value.dart';

class EditProfile extends StatefulWidget {
  static const PAGEID = 'edit-profile';

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final firstNameCtrl = TextEditingController();
  final lastNameCtrl = TextEditingController();
  final usernameCtrl = TextEditingController();

  File _imageFile;
  dynamic _pickImageError;
  String _retrieveDataError;

  String avatar =
      'https://firebasestorage.googleapis.com/v0/b/educationappflutter.appspot.com/o/avatar.png?alt=media&';

  @override
  initState() {
    super.initState();

    firstNameCtrl.text = 'Vinay';
    lastNameCtrl.text = 'Thakur';
    usernameCtrl.text = 'vinay@capitalnumbers.com';
  }

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
                    text: 'Edit Profile',
                    size: 18,
                    color: const Color(kNavbarIconColor),
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
            linkedInArea(),
            personalInterest(),
            personalValues(),
            const SizedBox(height: 16.0),
          ],
        ),
      ),
    );
  }

  Widget profileImageArea() {
    return Stack(
      children: <Widget>[
        Container(
          width: double.infinity,
          height: 300.0,
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            image: DecorationImage(
              image: isNetworkPath(avatar)
                  ? NetworkImage(avatar)
                  : FileImage(File(avatar)),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned(
          top: 8,
          right: 32,
          child: RaisedButton(
            color: const Color(0x65ffffff),
            child: AppText(
              text: 'Edit Photo',
              color: const Color(kAppBackgroundColor),
              size: 16.0,
            ),
            onPressed: () {
              containerForSheet<String>(
                context: context,
                child: customActionSheet(),
              );
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
            ),
          ),
        )
      ],
    );
  }

  Widget formArea() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      child: Column(
        children: <Widget>[
          CustomInputFormField(
            label: 'First Name',
            hint: 'Enter your first name',
            fieldCtrl: firstNameCtrl,
            // errorMsg: emailValidator(firstNameCtrl.value.text),
            onChangeHandler: (value) {
              setState(() {});
            },
          ),
          CustomInputFormField(
            label: 'Last Name',
            hint: 'Enter your last name',
            fieldCtrl: lastNameCtrl,
            // errorMsg: emailValidator(lastNameCtrl.value.text),
            onChangeHandler: (value) {
              setState(() {});
            },
          ),
          CustomInputFormField(
            label: 'Username',
            hint: 'Enter your username',
            fieldCtrl: usernameCtrl,
            // errorMsg: emailValidator(usernameCtrl.value.text),
            onChangeHandler: (value) {
              setState(() {});
            },
            prefix: Container(
              margin: const EdgeInsets.only(right: 8.0),
              child: AppText(text: '@'),
            ),
          ),
        ],
      ),
    );
  }

  Widget linkedInArea() {
    return Card(
      margin: const EdgeInsets.all(16.0),
      elevation: 0,
      color: const Color(kHighlightColorOpac),
      child: ListTile(
        title: AppTitle(
          text: 'LinkedIn Connected',
          size: 18.0,
          color: const Color(kPrimaryColor),
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: const Color(kPrimaryColor),
          size: 16,
        ),
      ),
    );
  }

  Widget personalInterest() {
    return chipBox(
      title: 'Top Personal Interests',
      children: ['Blogging', 'Sport', 'Gaming', 'Traveling', 'Art'],
      handler: () {
        Navigator.of(context).pushNamed(PersonalInterestValue.PAGEID,
            arguments: 'personal_interest');
      },
    );
  }

  Widget personalValues() {
    return chipBox(
      title: 'Top Six Personal Values',
      children: ['Blogging', 'Sport', 'Gaming', 'Traveling', 'Art'],
      handler: () {
        Navigator.of(context).pushNamed(PersonalInterestValue.PAGEID,
            arguments: 'personal_value');
      },
    );
  }

  Widget chipBox({String title, List<String> children, Function handler}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16.0),
            child: AppTitle(text: title, size: 18),
          ),
          InkWell(
            onTap: handler,
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              constraints: BoxConstraints(minHeight: 80.0),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(
                  width: 1,
                  color: const Color(kAppBorderColor),
                ),
              ),
              child: Wrap(
                  spacing: 8.0,
                  children: children
                      .map((value) => CustomChip(label: value))
                      .toList()),
            ),
          ),
        ],
      ),
    );
  }

  /* Widget personalInterest() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            child: AppTitle(
              text: 'Top Personal Interests',
              size: 18,
            ),
          ),
          CustomChipInput(
            inputs: ['Vinay', 'Thakur'],
            dataHandler: (List<String> dataList) {
              print(dataList);
            },
          )
        ],
      ),
    );
  }

  Widget personalValues() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(16.0),
            child: AppTitle(
              text: 'Top Personal Interests',
              size: 18,
            ),
          ),
          CustomChipInput(
            inputs: ['Flutter', 'Awesome'],
            dataHandler: (List<String> dataList) {
              print(dataList);
            },
          )
        ],
      ),
    );
  } */

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

  Widget defaultActionSheet() {
    return CupertinoActionSheet(
      // title: const Text('Choose frankly 😊'),
      // message: const Text('Your options are '),

      actions: <Widget>[
        CupertinoActionSheetAction(
          child: const Text('Take Photo'),
          onPressed: () {
            Navigator.pop(context, '');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text('Choose from Library'),
          onPressed: () {
            Navigator.pop(context, '');
          },
        ),
        CupertinoActionSheetAction(
          child: const Text("Remove Photo"),
          onPressed: () {
            Navigator.pop(context, '');
          },
        ),
      ],
      cancelButton: CupertinoActionSheetAction(
        child: const Text('Cancel'),
        isDefaultAction: true,
        onPressed: () {
          Navigator.pop(context, 'Cancel');
        },
      ),
    );
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
