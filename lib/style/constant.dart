import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import '../size_config.dart';

const kPrimaryColor = Color(0xFF6A62B7);
const kBackgroundColor = Color(0xFFE5E5E5);
const kPrimaryLightColor = Color(0xFFF1E6FF);
const double kDefaultPadding = 20.0;
const kTextColor = Color(0xFF757575);

final headingStyle = TextStyle(
  fontSize: getProportionateScreenWidth(28),
  fontWeight: FontWeight.bold,
  color: Colors.black,
  height: 1.5,
  fontFamily: 'NotoSansLao',
);
final otpInputDecoration = InputDecoration(
  contentPadding:
  EdgeInsets.symmetric(vertical: getProportionateScreenWidth(15)),
  border: outlineInputBorder(),
  focusedBorder: outlineInputBorder(),
  enabledBorder: outlineInputBorder(),
);
OutlineInputBorder outlineInputBorder() {
  return OutlineInputBorder(
    borderRadius: BorderRadius.circular(getProportionateScreenWidth(15)),
    borderSide: BorderSide(color: kTextColor),
  );
}


num degToRad(num deg) => deg * (pi / 180.0);

num normalize(value, min, max) => ((value - min) / (max - min));

const Color kScaffoldBackgroundColor = Color(0xFFF3FBFA);
const double kDiameter = 300;
const double kMinDegree = 16;
const double kMaxDegree = 28;
