import 'package:education_app/components/app_text.dart';
import 'package:education_app/constants.dart';
import 'package:flutter/material.dart';

class CustomInputFormField extends StatelessWidget {
  final TextEditingController fieldCtrl;
  final Function onChangeHandler;
  final String hint;
  final String errorMsg;
  final String label;
  final bool isPassword;
  final bool isSuffixEnable;
  final EdgeInsetsGeometry contentPadding;
  final TextInputType keyboardType;
  final Widget prefix;
  final TextAlign textAlign;

  static const outlineBorder = OutlineInputBorder(
    borderSide: BorderSide(
      color: Color(kAppBorderColor),
    ),
  );

  CustomInputFormField({
    @required this.fieldCtrl,
    @required this.onChangeHandler,
    this.label,
    this.hint,
    this.errorMsg,
    this.isPassword,
    this.contentPadding,
    this.keyboardType,
    this.isSuffixEnable,
    this.prefix,
    this.textAlign=TextAlign.left
  });

  Widget getSuffixIcon(context) {
    if (fieldCtrl.value.text != '') {
      if (errorMsg == null) {
        return Icon(
          Icons.check_circle,
          color: Theme.of(context).primaryColor,
          size: 32.0,
        );
      } else {
        return Icon(
          Icons.error,
          color: Color(kAppErrorColor),
          size: 32.0,
        );
      }
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        label == null
            ? Container()
            : Container(
                width: double.infinity,
                margin: EdgeInsets.only(left: 8.0),
                padding: EdgeInsets.all(8.0),
                child: label == null
                    ? Container()
                    : AppText(
                        text: label,
                        size: 14.0,
                      ),
              ),
        TextField(
          textAlign: textAlign,
          keyboardType:
              keyboardType != null ? keyboardType : TextInputType.text,
          controller: fieldCtrl,
          style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold),
          obscureText: isPassword == true,
          decoration: InputDecoration(
            border: outlineBorder,
            hintText: hint == null ? '' : hint,
            hintStyle: TextStyle(
                color: Theme.of(context).accentColor,
                fontSize: 18.0,
                fontWeight: FontWeight.bold),
            prefix: prefix ?? null,
            suffixIcon: isSuffixEnable == true ? getSuffixIcon(context) : null,
            focusedBorder: outlineBorder,
            focusedErrorBorder: outlineBorder,
            enabledBorder: outlineBorder,
            contentPadding:
                contentPadding != null ? contentPadding : EdgeInsets.all(12.0),
          ),

          onChanged: onChangeHandler,
          // validator: validatorFunction,
        ),
        if (errorMsg != null)
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(8.0),
            child: Text(
              errorMsg,
              textAlign: TextAlign.right,
              style: TextStyle(color: Color(kAppErrorColor)),
            ),
          ),
      ],
    );
  }
}
