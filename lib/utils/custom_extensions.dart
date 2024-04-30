import 'dart:math';

import 'package:flutter/material.dart';

/// Extensions for
/// num, String, Widget, Text, bool, object, MenuTimeType
/// */

// int
extension IntExtension on num {
  double percent(num total) {
    return ((toDouble() * 100.0) / total.toDouble());
  }

  onZeroToOneScale() {
    return toDouble() / 100.0;
  }

  SizedBox toVerticalSpace() {
    return SizedBox(
      height: toDouble(),
    );
  }

  SizedBox toHorizontalSpace() {
    return SizedBox(
      width: toDouble(),
    );
  }

  BorderRadius toRadius() {
    return BorderRadius.circular(toDouble());
  }

  RoundedRectangleBorder toRoundedRectRadius() {
    return RoundedRectangleBorder(borderRadius: toRadius());
  }

  double degreeToRadian() {
    return toDouble() * pi / 180.0;
  }
}

// string
extension StringExtension on String? {
  bool isNullOrEmpty() {
    return (this == null || this!.isEmpty);
  }

  bool isNullOrEmptyNot() {
    return (this != null && this!.isNotEmpty);
  }

  String withoutSpaces() {
    return this?.replaceAll(RegExp(r"\s\b|\b\s"), "") ?? "";
  }

  String capitalizeFirst() {
    return (isNullOrEmpty())
        ? ""
        : this!
            .toLowerCase()
            .replaceFirst(this![0].toLowerCase(), this![0].toUpperCase());
  }
}

// widgets
extension WidgetsExtension on Widget {
  // add click
  Widget addInkwell({required Function onClick}) {
    return InkWell(
      child: this,
      onTap: () => onClick(),
    );
  }

  // add padding
  Widget addPaddingAll(num value) {
    return Padding(
      padding: EdgeInsets.all(value.toDouble()),
      child: this,
    );
  }

  // add horizontal padding
  Widget addPaddingHorizonal(num value) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: value.toDouble()),
      child: this,
    );
  }

  // add vertical padding
  Widget addPaddingVertical(num value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: value.toDouble()),
      child: this,
    );
  }

  Widget alignCenterLeft() {
    return Align(alignment: Alignment.centerLeft, child: this);
  }

  Widget alignCenterRight() {
    return Align(alignment: Alignment.centerRight, child: this);
  }

  Widget alignCenter() {
    return Align(alignment: Alignment.center, child: this);
  }
}

// text
extension TextExtension on Text {
  Text addTextStyle(TextStyle style) {
    return Text(
      data ?? "",
      style: style,
    );
  }
}

//bool
extension BoolExtensions on bool {
  bool not() => !this;
}

//object
extension ObjectExtension on Object? {
  bool isNull() => this == null;

  bool isNotNull() => isNull().not();

  bool isNullOrEmpty() {
    if (this is String) {
      return (isNull() || (this as String).isEmpty);
    } else if (this is List) {
      return (isNull() || (this as List).isEmpty);
    } else {
      return isNull();
    }
  }

  bool isNotNullOrEmpty() => isNullOrEmpty().not();
}

//TimeOfDay
extension TimeOfDayExtensions on TimeOfDay {
  DateTime toDateTime() => DateTime(DateTime.now().year, DateTime.now().month,
      DateTime.now().day, hour, minute);
}