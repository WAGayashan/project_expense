// lib/constants.dart
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

const Color kScaffoldColor = Color.fromARGB(255, 199, 198, 198);
const Color kPrimaryColor = Color.fromARGB(255, 255, 255, 255);
const Color kSecondaryColor = Color.fromARGB(255, 255, 162, 0);
const Color kTextColor = Color.fromARGB(255, 0, 0, 0);

final kMargin = EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h);
final kPadding = EdgeInsets.all(2.h);
final kRadius = BorderRadius.circular(2.h);

Color setupColor(double percentage) {
  if (percentage >= 0.50) {
    return kScaffoldColor;
  } else if (percentage >= 0.25) {
    return Colors.orange;
  }
  return Color.fromARGB(255, 1, 31, 99);
}
