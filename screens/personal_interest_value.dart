import 'package:education_app/components/app_title.dart';
import 'package:education_app/components/appbar_flatbtn.dart';
import 'package:education_app/components/custom_appbar.dart';
import 'package:education_app/components/custom_checkbox.dart';
import 'package:education_app/constants.dart';
import 'package:education_app/helper/functions.dart';
import 'package:flutter/material.dart';

class PersonalInterestValue extends StatefulWidget {
  static const PAGEID = 'personal-interest-value';

  @override
  _PersonalInterestValueState createState() => _PersonalInterestValueState();
}

class _PersonalInterestValueState extends State<PersonalInterestValue> {
  List<Map<String, dynamic>> lists = [];
  List<String> items = [
    'Volunteer Work',
    'Club Memberships',
    'Blogging',
    'Sports',
    'Art',
    'Gaming'
  ];
  List<String> selectedItems = [
    'Club Memberships',
    'Sports',
  ];
  String title = 'Top Personal Interests';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    items.forEach((item) {
      lists.add({'name': item, 'value': selectedItems.indexOf(item) > -1});
    });

    print(lists);
  }

  @override
  Widget build(BuildContext context) {
    final param = ModalRoute.of(context).settings.arguments;
    print(param);

    return Scaffold(
      backgroundColor: const Color(kAppBackgroundColor),
      appBar: CustomAppBar(
        appBarLeading: getBackButton(context),
        appBarTitle: FittedBox(child: Text(title)),
        appBarActions: <Widget>[
          AppBarFlatButton(
            padding: EdgeInsets.symmetric(horizontal: 0),
            text: "Save",
            onPressed: () {
              print(lists);
            },
            color: Theme.of(context).primaryColor,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: lists.map((item) {
            return Container(
              decoration: new BoxDecoration(
                border: new Border(
                    top: new BorderSide(color: Color(kAppBorderColor))),
              ),
              child: ListTile(
                onTap: () {
                  setState(() {
                    item['value'] = !item['value'];
                  });
                },
                title: AppTitle(
                  text: item['name'],
                  size: 18,
                  color: (item['value'] ? Color(kPrimaryColor) : null),
                ),
                trailing: CustomCheckbox(
                  value: item['value'],
                  type: CheckboxType.Circular,
                  onChanged: () {
                    setState(() {
                      item['value'] = !item['value'];
                    });
                  },
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
