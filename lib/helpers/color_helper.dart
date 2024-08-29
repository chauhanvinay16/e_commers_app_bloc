


import 'dart:ui';

import 'package:flutter/material.dart';

class ColorHelper{
  static final ColorHelper _singleton = ColorHelper._internal();

  factory ColorHelper() {
    return _singleton;
  }

  ColorHelper._internal();

  static const Color primaryColor=Colors.deepPurple;
  static const Color whiteColor=Colors.white;
  static const Color blackColor=Colors.black;
  static const Color greyColor=Colors.grey;
  static const Color green=Colors.green;
  static const Color red=Colors.red;
}