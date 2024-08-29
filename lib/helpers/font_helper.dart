


import 'dart:ui';

class FontHelper{
  static final FontHelper _singleton = FontHelper._internal();

  factory FontHelper() {
    return _singleton;
  }

  FontHelper._internal();

  static const double font_14=14.0;
  static const double font_16=16.0;
  static const double font_18=18.0;
  static const double font_20=20.0;
  static const double font_22=22.0;
  static const double font_24=24.0;

  static FontWeight regular= FontWeight.w400;
  static FontWeight medium= FontWeight.w500;
  static FontWeight bold= FontWeight.bold;
}