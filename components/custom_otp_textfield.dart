import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomOTPTextField extends StatefulWidget {
  final int fields;
  final Function onSubmit;
  final double fieldWidth;
  final double fieldHeight;
  final bool isTextObscure;
  final TextStyle inputStyle;
  final InputDecoration inputDecoration;
  final Color fieldBackground;

  CustomOTPTextField({
    this.fields: 4,
    @required this.onSubmit,
    this.fieldWidth: 60.0,
    this.fieldHeight: 60.0,
    this.isTextObscure: false,
    this.inputStyle,
    this.inputDecoration,
    this.fieldBackground
  }) : assert(fields > 0);

  @override
  _CustomOTPTextFieldState createState() => _CustomOTPTextFieldState();
}

class _CustomOTPTextFieldState extends State<CustomOTPTextField> {
  List<String> _pin;
  List<FocusNode> _focusNodes;
  List<TextEditingController> _textControllers;


  InputDecoration defaultDecoration = InputDecoration();

  TextStyle defaultTextStyle =
      TextStyle(color: Color(kPrimaryTextColorNoOpac), fontSize: 24);

  @override
  void initState() {    
    super.initState();

    defaultDecoration = InputDecoration(
      fillColor: widget.fieldBackground ?? Colors.transparent,
      filled: true,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(kAppBorderColor),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Color(kAppBorderColor),
        ),
      ),
    );

    _pin = List<String>(widget.fields);
    _focusNodes = List<FocusNode>(widget.fields);
    _textControllers = List<TextEditingController>(widget.fields);

    for (var i = 0; i < widget.fields; i++) {
      _pin[i] = '';
      _focusNodes[i] = FocusNode();
      _textControllers[i] = TextEditingController();
    }
  }

  @override
  void dispose() {
    _textControllers.forEach((TextEditingController t) => t.dispose());
    super.dispose();
  }

  void clearTextFields() {
    _textControllers.forEach(
        (TextEditingController tEditController) => tEditController.clear());
    _pin.clear();
  }

  Widget buildTextField(int i, BuildContext context) {
    return Container(
      width: widget.fieldWidth,
      height: widget.fieldHeight,
      margin: EdgeInsets.only(right: 10.0),
      child: TextField(        
        controller: _textControllers[i],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [LengthLimitingTextInputFormatter(1)],
        style: widget.inputStyle != null ? widget.inputStyle : defaultTextStyle,
        decoration: widget.inputDecoration != null
            ? widget.inputDecoration
            : defaultDecoration,
        focusNode: _focusNodes[i],
        obscureText: widget.isTextObscure,
        onChanged: (String str) {
          if (str != '') {
            _pin[i] = str;
            if (i + 1 != widget.fields) {
              FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
            } else {
              widget.onSubmit(_pin.join());
            }
          }
        },
        onSubmitted: (String str) {
          widget.onSubmit(_pin.join());
        },
      ),
    );
  }

  Widget generateTextFields(BuildContext context) {
    List<Widget> textFields = List.generate(widget.fields, (int i) {
      return buildTextField(i, context);
    });

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      verticalDirection: VerticalDirection.down,
      children: textFields,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: generateTextFields(context),
    );
  }
}
